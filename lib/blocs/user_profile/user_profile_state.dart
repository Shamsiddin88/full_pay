part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  final UserModel userModel;
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const UserProfileState({
    required this.status,
    required this.userModel,
    required this.statusMessage,
    required this.errorMessage,
  });

  UserProfileState copyWith({
    UserModel? userModel,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [userModel, status, errorMessage, statusMessage];
}
