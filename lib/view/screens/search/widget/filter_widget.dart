import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/helper/responsive_helper.dart';
import 'package:zabayeh_aljazeera/localization/language_constrants.dart';
import 'package:zabayeh_aljazeera/provider/category_provider.dart';
import 'package:zabayeh_aljazeera/provider/search_provider.dart';
import 'package:zabayeh_aljazeera/utill/color_resources.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';
import 'package:zabayeh_aljazeera/view/base/custom_button.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  final double maxValue;
  final int index;

  FilterWidget({@required this.maxValue, this.index});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 700,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, size: 18, color: ColorResources.getTextColor(context)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated('filter', context),
                      textAlign: TextAlign.center,
                      style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: ColorResources.getTextColor(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<CategoryProvider>(context, listen: false).updateSelectCategory(-1);
                      searchProvider.setLowerAndUpperValue(0, 0);
                      searchProvider.setFilterIndex(-1);
                    },
                    child: Text(
                      getTranslated('reset', context),
                      style: poppinsRegular.copyWith(color: Colors.red),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text(
                getTranslated('price', context),
                style: poppinsMedium.copyWith(color: ColorResources.getTextColor(context)),
              ),

              // price range
              RangeSlider(
                values: RangeValues(searchProvider.lowerValue, searchProvider.upperValue),
                max: maxValue,
                min: 0,
                activeColor: Theme.of(context).primaryColor,
                labels: RangeLabels(searchProvider.lowerValue.toString(), searchProvider.upperValue.toString()),
                onChanged: (RangeValues rangeValues) {
                  searchProvider.setLowerAndUpperValue(rangeValues.start, rangeValues.end);
                },
              ),

              SizedBox(height: 15),
              Text(
                getTranslated('sort_by', context),
                style: poppinsMedium.copyWith(color: ColorResources.getTextColor(context)),
              ),
              SizedBox(height: 13),
              ListView.builder(
                itemCount: searchProvider.allSortBy.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => searchProvider.setFilterIndex(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    child: Row(
                      mainAxisAlignment: !ResponsiveHelper.isDesktop(context)
                          ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                      children: [
                      if(!ResponsiveHelper.isDesktop(context))  Text(
                          searchProvider.allSortBy[index],
                          style: poppinsRegular.copyWith(color: ColorResources.getTextColor(context)),
                        ),

                        Container(
                          padding: EdgeInsets.all(2),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: searchProvider.filterIndex == index
                                      ? Theme.of(context).primaryColor
                                      : ColorResources.getHintColor(context),
                                  width: 2)),
                          child: searchProvider.filterIndex == index
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),

                        if(ResponsiveHelper.isDesktop(context))
                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                        if(ResponsiveHelper.isDesktop(context))  Text(
                          searchProvider.allSortBy[index],
                          style: poppinsRegular.copyWith(color: ColorResources.getTextColor(context)),
                        ),
                      ],
                    ),
                  ),
                ),

              ),
              SizedBox(height: 30),

              Container(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  buttonText: getTranslated('apply', context),
                  onPressed: () {
                    Provider.of<SearchProvider>(context, listen: false).sortSearchList();
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
