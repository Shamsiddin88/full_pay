import 'package:equatable/equatable.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/history_model.dart';


class HistoryState extends Equatable {
  final List<HistoryModel> histories;
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const HistoryState({
    required this.status,
    required this.histories,
    required this.errorMessage,
    required this.statusMessage,
  });

  HistoryState copyWith({
    List<HistoryModel>? histories,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) {
    return HistoryState(
      histories: histories ?? this.histories,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    statusMessage,
    histories,
  ];
}
