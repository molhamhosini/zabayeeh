import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/data/datasource/remote/dio/dio_client.dart';
import 'package:zabayeh_aljazeera/data/datasource/remote/exception/api_error_handler.dart';
import 'package:zabayeh_aljazeera/data/model/response/base/api_response.dart';
import 'package:zabayeh_aljazeera/data/model/response/onboarding_model.dart';
import 'package:zabayeh_aljazeera/localization/language_constrants.dart';
import 'package:zabayeh_aljazeera/utill/images.dart';

class OnBoardingRepo {
  final DioClient dioClient;

  OnBoardingRepo({@required this.dioClient});

  Future<ApiResponse> getOnBoardingList(BuildContext context) async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.on_boarding_1, getTranslated('Select Your Zabeha', context), getTranslated('onboarding_1_text', context)),
        OnBoardingModel(Images.on_boarding_2, getTranslated('Select Your Cutting Type', context), getTranslated('onboarding_2_text', context)),
        OnBoardingModel(Images.on_boarding_3, getTranslated('Select Address', context), getTranslated('onboarding_3_text', context)),
      ];

      Response response = Response(requestOptions: RequestOptions(path: ''), data: onBoardingList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
