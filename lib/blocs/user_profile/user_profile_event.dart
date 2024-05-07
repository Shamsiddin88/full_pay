part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {}

class AddUserEvent extends UserProfileEvent {
  final UserModel userModel;

  AddUserEvent(this.userModel);

  @override
  List<Object?> get props => [userModel];

}

class UpdateUserEvent extends UserProfileEvent {
  final UserModel userModel;

  UpdateUserEvent(this.userModel);

  @override
  List<Object?> get props => [userModel];

}

class DeleteUserEvent extends UserProfileEvent {
  final UserModel userModel;

  DeleteUserEvent(this.userModel);

  @override
  List<Object?> get props => [userModel];

}


class GetUserByDocIdEvent extends UserProfileEvent {

  final String docId;

  GetUserByDocIdEvent({required this.docId});

  @override
  List<Object?> get props => [docId];

}


class GetCurrentUserEvent extends UserProfileEvent {
  final String uid;

  GetCurrentUserEvent(this.uid);
  @override
  List<Object?> get props => [uid];

}
