import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/data/model/response/onboarding_model.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';

class OnBoardingWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  OnBoardingWidget({@required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Expanded(flex: 7, child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Image.asset(onBoardingModel.imageUrl),
      )),

      Expanded(
        flex: 1,
        child: Text(
          onBoardingModel.title,
          style: poppinsMedium.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      Expanded(
        flex: 2,
        child: Text(
          onBoardingModel.description,
          style: poppinsLight.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
          textAlign: TextAlign.center,
        ),
      )

    ]);
  }
}
