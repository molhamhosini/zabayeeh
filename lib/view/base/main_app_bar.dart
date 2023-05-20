import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/helper/route_helper.dart';
import 'package:zabayeh_aljazeera/utill/app_constants.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/images.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';
import 'package:zabayeh_aljazeera/view/base/menu_bar.dart' as widget;


class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).cardColor,
        width: 1170.0,
        height: 45.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, RouteHelper.menu),
                child: Row(
                children: [
                  Image.asset(Images.app_logo, color: Theme.of(context).primaryColor),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Text(AppConstants.APP_NAME, style: poppinsMedium.copyWith(color: Theme.of(context).primaryColor)),
                ],
              )),
            ),
            widget.MenuBarWidget(),
          ],
        )
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}
