import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/history/history_event.dart';
import 'package:full_pay/blocs/history/history_state.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/history_model.dart';
import 'package:full_pay/data/models/network_response.dart';
import 'package:full_pay/data/repositories/histories_repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.historiesRepository})
      : super(
          const HistoryState(
            status: FormsStatus.pure,
            histories: [],
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddHistoryEvent>(_addHistory);
    on<GetHistoriesByUserId>(_listenHistories);
  }

  final HistoriesRepository historiesRepository;

  _addHistory(AddHistoryEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response = await historiesRepository.addHistory(event.historyModel);
    if (response.errorText.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          statusMessage: "added",
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: response.errorText,
      ));

    }
  }



  _listenHistories(GetHistoriesByUserId event, Emitter emit) async {
    await emit.onEach(
      historiesRepository.getHistoriesByUserId(event.userId),
      onData: (List<HistoryModel> histories) {
        emit(state.copyWith(histories: histories));
      },
    );
  }
}
