
import 'package:equatable/equatable.dart';
import 'package:full_pay/data/models/history_model.dart';

import '../../data/models/card_model.dart';

abstract class HistoryEvent extends Equatable {}

class AddHistoryEvent extends HistoryEvent {
  final HistoryModel historyModel;

  AddHistoryEvent(this.historyModel);

  @override
  List<Object?> get props => [historyModel];
}


class GetHistoriesByUserId extends HistoryEvent {
  GetHistoriesByUserId({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}