import 'package:equatable/equatable.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/user_model.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormsStatus status;
  final UserModel userModel;

  const AuthState({
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
    required this.userModel,
  });

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormsStatus? status,
    UserModel? userModel
  }) {
    return AuthState(status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        statusMessage: statusMessage ?? this.statusMessage,
        userModel: userModel ?? this.userModel
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, statusMessage, userModel];
}
