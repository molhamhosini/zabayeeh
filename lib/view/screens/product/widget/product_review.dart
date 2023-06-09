import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/data/model/response/product_model.dart';
import 'package:zabayeh_aljazeera/data/model/response/review_model.dart';
import 'package:zabayeh_aljazeera/localization/language_constrants.dart';
import 'package:zabayeh_aljazeera/provider/splash_provider.dart';
import 'package:zabayeh_aljazeera/utill/color_resources.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/images.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';
import 'package:zabayeh_aljazeera/view/base/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReviewWidget extends StatelessWidget {
  final ActiveReview reviewModel;
  ReviewWidget({@required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    String _customerName = getTranslated('user_not_available', context);

    if(reviewModel.customer != null) {
      _customerName = '${reviewModel.customer.fName ?? ''} ${reviewModel.customer.lName ?? ''}';
    }




    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorResources.getCardBgColor(context),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ClipOval(

            child: FadeInImage.assetNetwork(
              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${
                  reviewModel.customer != null ? reviewModel.customer.image ?? '' : ''}',
              placeholder: Images.placeholder(context),
              width: 30, height: 30, fit: BoxFit.cover,
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder(context), height: 30, width: 30, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 5),

          Expanded(child: Text(
            _customerName,
            style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          )),
          SizedBox(width: 5),
          RatingBar(rating: double.parse('${reviewModel.rating}'), size: Dimensions.PADDING_SIZE_DEFAULT),

        ]),
        SizedBox(height: 5),
        Text(reviewModel.comment, style: poppinsRegular),
      ]),
    );
  }
}

class ReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorResources.getCardBgColor(context),
      ),
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(height: 30, width: 30, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            SizedBox(width: 5),
            Container(height: 15, width: 100, color: Colors.white),
            Expanded(child: SizedBox()),
            Icon(Icons.star, color: Theme.of(context).primaryColor, size: 18),
            SizedBox(width: 5),
            Container(height: 15, width: 20, color: Colors.white),
          ]),
          SizedBox(height: 5),
          Container(height: 15, width: MediaQuery.of(context).size.width, color: Colors.white),
          SizedBox(height: 3),
          Container(height: 15, width: MediaQuery.of(context).size.width, color: Colors.white),
        ]),
      ),
    );
  }
}

