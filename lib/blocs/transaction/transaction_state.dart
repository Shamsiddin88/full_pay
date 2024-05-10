import 'package:equatable/equatable.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/card_model.dart';

class TransactionState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormsStatus status;
  final CardModel receiverCard;
  final CardModel senderCard;
  final double amount;

  const TransactionState({
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
    required this.receiverCard,
    required this.senderCard,
    required this.amount,
  });

  TransactionState copyWith(
      {String? errorMessage,
      String? statusMessage,
      FormsStatus? status,
      CardModel? receiverCard,
      CardModel? senderCard,
      double? amount}) {
    return TransactionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      receiverCard: receiverCard ?? this.receiverCard,
      senderCard: senderCard ?? this.senderCard,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, statusMessage,receiverCard,senderCard, amount ];
}
