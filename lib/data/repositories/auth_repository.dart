import 'package:firebase_auth/firebase_auth.dart';
import 'package:full_pay/data/models/exceptions/firebase_exceptions.dart';
import 'package:full_pay/data/models/network_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  Future <NetworkResponse> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: LogInWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    }catch (error){
      return NetworkResponse(
        errorText: "An unknown exception occured.${error}",
      );
    }
  }

  Future <NetworkResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: SignUpWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    }catch (_){
      return NetworkResponse(
        errorText: "An unknown exception occured.",
      );
    }
  }

  Future <NetworkResponse> googleSignIn() async {
    try {
      late final AuthCredential credential;
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorCode: LogInWithGoogleFailure.fromCode(e.code).message,
      );
    }catch (_){
      return NetworkResponse(
        errorText: "An unknown exception occured.",
      );
    }
  }

  Future <NetworkResponse> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return NetworkResponse(data: "success");
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorCode: e.code,
        errorText: "Error"
      );
    }catch (_){
      return NetworkResponse(
        errorText: "An unknown exception occured.",
      );
    }
  }

}