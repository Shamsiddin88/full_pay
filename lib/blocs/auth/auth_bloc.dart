import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/network_response.dart';
import 'package:full_pay/data/models/user_model.dart';
import 'package:full_pay/data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(
          AuthState(
              status: FormsStatus.pure,
              errorMessage: "",
              statusMessage: "",
              userModel: UserModel.initial()),
        ) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<LogOutUserEvent>(_logOutUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: FormsStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.logInWithEmailAndPassword(
      email: "${event.username.toLowerCase()}@gmail.com",
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {

      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel = state.userModel.copyWith(authUid: userCredential.user!.uid);

      emit(state.copyWith(
        status: FormsStatus.authenticated,userModel: userModel
      ));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: event.userModel.email,
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {

      UserCredential userCredential = networkResponse.data as UserCredential;

      UserModel userModel = event.userModel.copyWith(authUid: userCredential.user!.uid);
      emit(state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse networkResponse = await authRepository.logOutUser();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        status: FormsStatus.unauthenticated,
      ));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse networkResponse = await authRepository.googleSignIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(state.copyWith(
          status: FormsStatus.authenticated,
          userModel: UserModel(
              username: "",
              password: "",
              lastname: userCredential.user!.displayName ?? "",
              email: userCredential.user!.email ?? "",
              imageUrl: userCredential.user!.photoURL ?? "",
              phoneNumber: userCredential.user!.phoneNumber ?? "",
              userId: "",
          authUid: userCredential.user!.uid,
          fcm: "")));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }
}
