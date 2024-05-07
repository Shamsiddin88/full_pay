import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/blocs/user_cards/user_cards_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/models/card_model.dart';
import 'package:full_pay/screens/routes.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    context.read<UserCardsBloc>().add(GetCardsByUserIdEvent(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cards"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addCardRoute);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return ListView(
            children: List.generate(state.userCards.length, (index) {
              CardModel cardModel = state.userCards[index];
              return Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Color(int.parse("0xFF${cardModel.color}"))),
              );
            }),
          );
        },
      ),
    );
  }
}
