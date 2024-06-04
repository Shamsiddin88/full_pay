import 'package:flutter/material.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../data/models/card_model.dart';

class CardItemView extends StatefulWidget {
  const CardItemView({
    super.key,
    required this.cardModel,
    this.onTap,
    this.chipVisibility = true,
  });

  final CardModel cardModel;
  final VoidCallback? onTap;
  final bool chipVisibility;

  @override
  State<CardItemView> createState() => _CardItemViewState();
}

class _CardItemViewState extends State<CardItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Color(int.parse("0xff${widget.cardModel.color}")),
              Color(int.parse("0xff${widget.cardModel.color}")).withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.cardModel.bank,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  NumberFormat.currency(locale: "uz").format(widget.cardModel.balance),
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Visibility(
              visible: widget.chipVisibility,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Image.asset(
                  AppImages.chip,
                  width: 56.w,
                  height: 56.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maskFormatter.maskText(widget.cardModel.cardNumber),
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.cardModel.expireDate,
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.cardModel.cardHolder.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: widget.cardModel.type == -1
                      ? Icon(
                          Icons.credit_card,
                          size: 56.w,
                        )
                      : Image.asset(
                          getIconPath(widget.cardModel.type),
                          width: 56.w,
                          height: 56.w,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getIconPath(int type) {
    if (type == 1) {
      return AppImages.uzcard;
    }
    if (type == 2) {
      return AppImages.humo;
    }
    return AppImages.visa;
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
