import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/blocs/user_cards/user_cards_state.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/card_model.dart';
import 'package:full_pay/data/models/network_response.dart';
import 'package:full_pay/data/repositories/cards_repository.dart';
import 'package:pinput/pinput.dart';

class UserCardsBloc extends Bloc<UserCardsEvent, UserCardsState> {
  UserCardsBloc({required this.cardsRepository})
      : super(const UserCardsState(
          status: FormsStatus.pure,
          userCards: [],
          activeCards: [],
          statusMessage: "",
          errorMessage: "",
          cardsDB: [],
        )) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserIdEvent>(_listenCard);
    on<GetCardsDatabaseEvent>(_listenCardsDatabase);
    on<GetActiveCards>(_listenActiveCard);
  }

  final CardsRepository cardsRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response = await cardsRepository.addCard(event.cardModel);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.success, statusMessage: "added"));
    } else {
      emit(state.copyWith(
          status: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _updateCard(UpdateCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response =
        await cardsRepository.updateCard(event.cardModel);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.success));
    } else {
      emit(state.copyWith(
          status: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _deleteCard(DeleteCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response =
        await cardsRepository.deleteCard(event.cardDocId);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.success));
    } else {
      emit(state.copyWith(
          status: FormsStatus.error, errorMessage: response.errorText));
    }
  }

  _listenCard(GetCardsByUserIdEvent event, Emitter emit) async {
    await emit.onEach(cardsRepository.getCardsByUserId(event.userId),
        onData: (List<CardModel> userCards) {
      emit(state.copyWith(userCards: userCards));
    });
  }

  _listenActiveCard(GetActiveCards event, Emitter emit) async {
    await emit.onEach(
      cardsRepository.getActiveCards(),
      onData: (List<CardModel> activeCards) {
        emit(state.copyWith(activeCards: activeCards));
        debugPrint("ACTIVEEEEEEE${activeCards.length}");
      },
    );
  }

  _listenCardsDatabase(GetCardsDatabaseEvent event, Emitter emit) async {
   await emit.onEach(cardsRepository.getCardsDatabase(),
        onData: (List<CardModel> userCards) {
          emit(state.copyWith(cardsDB: userCards));
          print("KKKKKKKKKKKKKK${userCards.length}");
        });

  }
}
