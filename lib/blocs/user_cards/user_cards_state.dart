import 'package:equatable/equatable.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/card_model.dart';

class UserCardsState extends Equatable {
  final List <CardModel> userCards;
  final List <CardModel> cardsDB;
  final List<CardModel> activeCards;
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const UserCardsState({
    required this.status,
    required this.userCards,
    required this.statusMessage,
    required this.errorMessage,
    required this.cardsDB,
    required this.activeCards,
  });

  UserCardsState copyWith({
    List <CardModel> ? userCards,
    List <CardModel> ? cardsDB,
    List <CardModel> ? activeCards,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserCardsState(
      status: status ?? this.status,
      userCards: userCards ?? this.userCards,
      cardsDB: cardsDB ?? this.cardsDB,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.statusMessage,
      activeCards: activeCards ?? this.activeCards,
    );
  }

  @override
  List<Object?> get props => [userCards, status, errorMessage, statusMessage, cardsDB, activeCards];
}
