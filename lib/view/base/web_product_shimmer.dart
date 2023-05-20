import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/utill/color_resources.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebProductShimmer extends StatelessWidget {
  final bool isEnabled;
  WebProductShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorResources.getWhiteColor(context),
      ),
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: isEnabled,
        child: Column(children: [
          Expanded(
            child: Container(
              height: 100,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: ColorResources.getGreyColor(context)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 15, width: MediaQuery.of(context).size.width, color: Colors.grey[300]),
                SizedBox(height: 2),
                Container(height: 15, width: MediaQuery.of(context).size.width, color: Colors.grey[300]),
                SizedBox(height: 10),
                Container(height: 10, width: 50, color: Colors.grey[300]),
              ]),
            ),
          ),

        ]),
      ),
    );
  }
}