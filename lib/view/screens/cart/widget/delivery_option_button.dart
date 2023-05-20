import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/helper/price_converter.dart';
import 'package:zabayeh_aljazeera/localization/language_constrants.dart';
import 'package:zabayeh_aljazeera/provider/order_provider.dart';
import 'package:zabayeh_aljazeera/provider/splash_provider.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';
import 'package:provider/provider.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  final bool kmWiseFee;
  final bool freeDelivery;
  DeliveryOptionButton({@required this.value, @required this.title, @required this.kmWiseFee, this.freeDelivery = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return InkWell(
          onTap: () => order.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: order.orderType,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (String value) => order.setOrderType(value),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Text(title, style: poppinsRegular),
              SizedBox(width: 5),

              freeDelivery ? Text('(${getTranslated('free', context)})', style: poppinsMedium) :  kmWiseFee  ? SizedBox() : Text('(${value == 'delivery' && !freeDelivery
                  ? PriceConverter.convertPrice(context, Provider.of<SplashProvider>(context, listen: false).configModel.deliveryCharge)
                  : getTranslated('free', context)})', style: poppinsMedium,
              ),

            ],
          ),
        );
      },
    );
  }
}
