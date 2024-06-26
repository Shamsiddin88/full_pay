part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {}

class SetAmountEvent extends TransactionEvent{
  SetAmountEvent({required this.amount});

  final double amount;

  @override
  List<Object?> get props => [amount];
}

class SetReceiverCardEvent extends TransactionEvent{
  SetReceiverCardEvent({required this.cardModel});

  final CardModel cardModel;

  @override
  List<Object?> get props => [cardModel];
}


class SetSenderCardEvent extends TransactionEvent{
  SetSenderCardEvent({required this.cardModel});

  final CardModel cardModel;

  @override
  List<Object?> get props => [cardModel];
}



class CheckValidationEvent extends TransactionEvent{
  CheckValidationEvent();

  @override
  List<Object?> get props => [];
}



class RunTransactionEvent extends TransactionEvent{
  RunTransactionEvent();

  @override
  List<Object?> get props => [];
}

class SetInitialEvent extends TransactionEvent {
  @override
  List<Object?> get props => [];
}