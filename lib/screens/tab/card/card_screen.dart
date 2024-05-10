import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/blocs/user_cards/user_cards_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/models/card_model.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

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
              var cardStartWith=cardModel.cardNumber.substring(0,4);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(int.parse("0xFF${cardModel.color}")).withOpacity(.8)),
                child: Stack(
                  children: [
                    Image.asset(AppImages.dottedMap,
                        height: height,
                        width: width,
                        fit: BoxFit.fitWidth,
                        color: Colors.white),
                    Positioned(
                      right: 10.w,
                      top: 20.h,
                      child: Text(
                        cardModel.bank,
                        style:
                        AppTextStyle.interBold.copyWith(color: Colors.yellow, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cardModel.type==1 && cardStartWith =="8600"? Image.asset(AppImages.uzcard, height: 55,):Image.asset(AppImages.humo, height: 55,),
                        Text(
                          "${cardModel.balance} so'm",
                          style:
                          AppTextStyle.interBold.copyWith(color: Colors.white),
                        ),
                        10.getH(),
                        Text(
                          cardModel.cardNumber,
                          style:
                          AppTextStyle.interBold.copyWith(color: Colors.white),
                        ),
                        Text(
                          cardModel.cardHolder,
                          style:
                          AppTextStyle.interBold.copyWith(color: Colors.white),
                        ),
                          10.getH(),

                          Text(
                          cardModel.expireDate,
                          style:
                          AppTextStyle.interBold.copyWith(color: Colors.white),
                        ),
                      ],),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(onPressed: (){
                          context.read<UserCardsBloc>().add(DeleteCardEvent(cardModel.cardId));

                        }, icon: Icon(Icons.delete, color: Colors.white,)))

                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
