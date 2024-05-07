import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/blocs/user_cards/user_cards_state.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/card_model.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/edit_profile_screen/widget/edit_text_input.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/project_extensions.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumber = TextEditingController();

  final TextEditingController expireDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Card"),),
      body: BlocConsumer<UserCardsBloc, UserCardsState>(
        listener: (context, state) {
          if (state.statusMessage=="added"){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(children: [

              EditTextInput(controller: cardNumber, hintText: "Card number", type: TextInputType.number, errorTitle: "card number", regExp: AppConstants.number,),
              20.getH(),
              EditTextInput(controller: expireDate, hintText: "Expire Date", type: TextInputType.text, errorTitle: "Expire Date", regExp: AppConstants.textRegExp,),
              20.getH(),
              MyCustomButton(onTap: (){
                List <CardModel> db=state.cardsDB;
                List <CardModel> myCards=state.userCards;
                bool isExist = false;

                for (var element in myCards) {
                    if (element.cardNumber==cardNumber.text){
                      isExist = true;
                      break;
                    }
                }

                CardModel? cardModel;

                bool hasInDb = false;

                for (var element in db) {
                  if (element.cardNumber==cardNumber.text){
                    hasInDb = true;
                    cardModel=element;
                    break;
                  }
                }

                if(!isExist && hasInDb){
                  context.read<UserCardsBloc>().add(AddCardEvent(cardModel!));
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Karta oldin qo'shilgan yoki bazada mavjud emas")));
                }
                }, title: "Add Card", isLoading: state.status==FormsStatus.loading,)
            ],),
          );
        },
      ),
    );
  }
}
