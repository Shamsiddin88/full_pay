import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/history/history_bloc.dart';
import 'package:full_pay/blocs/history/history_event.dart';
import 'package:full_pay/blocs/history/history_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/models/history_model.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(GetHistoriesByUserId(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (AppBar(title: Text("History Screen"))),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            print(state.histories.length);
            return ListView(
              children: List.generate(state.histories.length, (index) {
                HistoryModel historyModel = state.histories[index];
                return ListTile(
                  leading: Text((index + 1).toString(), style: AppTextStyle.interBold.copyWith(color: Colors.black),),
                  title: Text(
                    historyModel.senderName,
                    style: AppTextStyle.interBold.copyWith(color: Colors.black),
                  ),
                  trailing:context.read<UserProfileBloc>().state.userModel.userId==historyModel.senderId? Text(
                    "- ${historyModel.amount}",
                    style: AppTextStyle.interBold.copyWith(color: Colors.red),
                  ):Text(
                    "+ ${historyModel.amount}",
                    style: AppTextStyle.interBold.copyWith(color: Colors.blue),
                  ),
                );
              }),
            );
          },
        ));
  }
}
