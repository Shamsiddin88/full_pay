import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/history/history_bloc.dart';
import 'package:full_pay/blocs/history/history_event.dart';
import 'package:full_pay/blocs/transaction/transaction_bloc.dart';
import 'package:full_pay/blocs/transaction/transaction_state.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_state.dart';
import 'package:full_pay/data/models/card_model.dart';
import 'package:full_pay/data/models/history_model.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/tab/card/widgets/amount_input.dart';
import 'package:full_pay/screens/tab/card/widgets/card_item_view.dart';
import 'package:full_pay/screens/tab/card/widgets/card_number_input.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int selectedCardIndex = 0;

  final TextEditingController cardNumberController = TextEditingController();
  final FocusNode cardFocusNode = FocusNode();

  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  CardModel senderCard = CardModel.initial();
  CardModel receiverCard = CardModel.initial();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    senderCard = context.read<UserCardsBloc>().state.userCards[0];
    List<CardModel> cards = context.read<UserCardsBloc>().state.activeCards;
    print("SSSSSSSSSSSSSS${cards.length}");
    cardNumberController.addListener(
          () {
        String receiverCardNumber =
        cardNumberController.text.replaceAll(" ", "");
        if (receiverCardNumber.length == 16) {
          for (var element in cards) {
            print(element);
            if (element.cardNumber == receiverCardNumber &&
                senderCard.cardNumber != receiverCardNumber) {
              receiverCard = element;

              context
                  .read<TransactionBloc>()
                  .add(SetReceiverCardEvent(cardModel: receiverCard));
              context
                  .read<TransactionBloc>()
                  .add(SetSenderCardEvent(cardModel: senderCard));

              setState(() {});
              break;
            } else {
              receiverCard = CardModel.initial();
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CardNumberInput(
                      controller: cardNumberController,
                      focusNode: cardFocusNode,
                    ),
                    Visibility(
                      visible: cardNumberController.text.length == 19,
                      child: Row(
                        children: [
                          SizedBox(width: 24.w),
                          Text(
                            "Qabul qiluvchi: ${receiverCard.cardHolder.isEmpty ? "Topilmadi" : receiverCard.cardHolder}",
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      child: AmountInput(
                        controller: amountController,
                        focusNode: amountFocusNode,
                        amount: (amount) {
                          if (amount >= 1000) {
                            context
                                .read<TransactionBloc>()
                                .add(SetAmountEvent(amount: amount));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: List.generate(
                  state.userCards.length,
                      (index) {
                    CardModel cardModel = state.userCards[index];
                    return CardItemView(
                      chipVisibility: false,
                      cardModel: cardModel,
                    );
                  },
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 7,
                  viewportFraction: 0.95,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  onPageChanged: (index, reason) {
                    selectedCardIndex = index;
                    debugPrint("INDEX:$index");
                    senderCard = state.userCards[index];
                  },
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state.statusMessage == "not_validated") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ma'lumotlar xato!"),
                      ),
                    );
                  } else if (state.statusMessage == "validated") {
                    Navigator.pop(context);
                  }
                },
                child: MyCustomButton(
                  onTap: () {
                    context.read<TransactionBloc>().add(CheckValidationEvent());
                    print(amountController.text.trim());
                    context.read<HistoryBloc>().add(
                      AddHistoryEvent(
                        HistoryModel(
                          amount: double.parse((amountController.text.replaceAll(RegExp(r'[^0-9]'), ''))),
                          senderName: senderCard.cardHolder,
                          receiverName: receiverCard.cardHolder,
                          senderId: senderCard.userId,
                          receiverId: receiverCard.userId,
                          docId: "",
                        ),
                      ),
                    );

                  },
                  title: "Yuborish",
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
