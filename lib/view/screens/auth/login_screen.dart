import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/data/model/response/user_log_data.dart';
import 'package:zabayeh_aljazeera/helper/email_checker.dart';
import 'package:zabayeh_aljazeera/helper/responsive_helper.dart';
import 'package:zabayeh_aljazeera/helper/route_helper.dart';
import 'package:zabayeh_aljazeera/localization/language_constrants.dart';
import 'package:zabayeh_aljazeera/provider/auth_provider.dart';
import 'package:zabayeh_aljazeera/provider/splash_provider.dart';
import 'package:zabayeh_aljazeera/utill/color_resources.dart';
import 'package:zabayeh_aljazeera/utill/dimensions.dart';
import 'package:zabayeh_aljazeera/utill/images.dart';
import 'package:zabayeh_aljazeera/utill/styles.dart';
import 'package:zabayeh_aljazeera/view/base/custom_button.dart';
import 'package:zabayeh_aljazeera/view/base/custom_snackbar.dart';
import 'package:zabayeh_aljazeera/view/base/custom_text_field.dart';
import 'package:zabayeh_aljazeera/view/base/footer_view.dart';
import 'package:zabayeh_aljazeera/view/screens/auth/signup_screen.dart';
import 'package:zabayeh_aljazeera/view/screens/auth/widget/code_picker_widget.dart';
import 'package:zabayeh_aljazeera/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:zabayeh_aljazeera/view/base/web_app_bar/web_app_bar.dart';
import 'package:zabayeh_aljazeera/view/screens/menu/menu_screen.dart';
import 'package:provider/provider.dart';

import 'widget/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode _emailFocus = FocusNode();
  FocusNode _numberFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKeyLogin;
  bool email = true;
  bool phone =false;
  String _countryDialCode;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    UserLogData _userData = Provider.of<AuthProvider>(context, listen: false).getUserData();


    if(_userData != null) {
      if(Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification) {
        _emailController.text = _userData.email;
      }else{
        _emailController.text = _userData.phoneNumber;
      }

      _passwordController.text = _userData.password;


      _countryDialCode = _userData.countryCode;
    }else{
      _countryDialCode = CountryCode.fromCountryCode(Provider.of<SplashProvider>(context, listen: false).configModel.country).dialCode;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final _configModel = Provider.of<SplashProvider>(context,listen: false).configModel;
    final _socialStatus = _configModel.socialLoginStatus;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120)) :null,
      body: SafeArea(child: Center(child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: ResponsiveHelper.isDesktop(context)
            ? MediaQuery.of(context).size.height - 560 : MediaQuery.of(context).size.height),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_LARGE),
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            ResponsiveHelper.isDesktop(context) ? SizedBox(height: 30,) : SizedBox(),
            Center(child: Container(
              width: _width > 700 ? 700 : _width,
              padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.symmetric(horizontal: 100,vertical: 50) :  _width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
              decoration: _width > 700 ? BoxDecoration(
                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 1)],
              ) : null,
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) => Form(key: _formKeyLogin, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        Images.app_logo,
                        height: ResponsiveHelper.isDesktop(context)
                            ? MediaQuery.of(context).size.height*0.15
                            : MediaQuery.of(context).size.height / 4.5,
                        fit: BoxFit.scaleDown,
                      ),
                    )),
                    //SizedBox(height: 20),

                    Center(child: Text(
                      getTranslated('login', context),
                      style: poppinsMedium.copyWith(fontSize: 24, color: ColorResources.getTextColor(context)),
                    )),
                    SizedBox(height: 35),

                    Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification ?
                    Text(
                      getTranslated('email', context),
                      style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
                    ):Text(
                      getTranslated('mobile_number', context),
                      style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification ?
                    CustomTextField(
                      hintText: getTranslated('demo_gmail', context),
                      isShowBorder: true,
                      focusNode: _emailFocus,
                      nextFocus: _passwordFocus,
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                    ):Row(children: [
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) {
                          _countryDialCode = countryCode.dialCode;
                        },
                        initialSelection: _countryDialCode,
                        favorite: [_countryDialCode],
                        countryFilter: [_countryDialCode],
                        enabled: false,
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge.color),

                      ),

                      Expanded(child: CustomTextField(
                        hintText: getTranslated('number_hint', context),
                        isShowBorder: true,
                        focusNode: _numberFocus,
                        nextFocus: _passwordFocus,
                        controller: _emailController,
                        inputType: TextInputType.phone,
                      )),

                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    Text(
                      getTranslated('password', context),
                      style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    CustomTextField(
                      hintText: getTranslated('password_hint', context),
                      isShowBorder: true,
                      isPassword: true,
                      isShowSuffixIcon: true,
                      focusNode: _passwordFocus,
                      controller: _passwordController,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 20),

                    // for remember me section
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      InkWell(
                        onTap: () => authProvider.toggleRememberMe(),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Row(children: [
                            Container(
                              width: 18, height: 18,
                              decoration: BoxDecoration(
                                color: authProvider.isActiveRememberMe ? Theme.of(context).primaryColor : ColorResources.getCardBgColor(context),
                                border: Border.all(color: authProvider.isActiveRememberMe ? Colors.transparent : Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: authProvider.isActiveRememberMe
                                  ? Icon(Icons.done, color: Colors.white, size: 17)
                                  : SizedBox.shrink(),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Text(
                              getTranslated('remember_me', context),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  .copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getHintColor(context)),
                            ),
                          ]),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteHelper.forgetPassword, arguments: ForgotPasswordScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            getTranslated('forgot_password', context),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                .copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getHintColor(context)),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10),

                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      authProvider.loginErrorMessage.length > 0
                          ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5)
                          : SizedBox.shrink(),
                      SizedBox(width: 8),

                      Expanded(child: Text(
                        authProvider.loginErrorMessage ?? "",
                        style: Theme.of(context).textTheme.displayMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),

                    ]),
                    SizedBox(height: 10),

                    // for login button

                    !authProvider.isLoading ? CustomButton(
                      buttonText: getTranslated('login', context),
                      onPressed: () async {
                        String _email = _emailController.text.trim();
                        if(!Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification) {
                          _email = _countryDialCode + _emailController.text.trim();
                        }
                        String _password = _passwordController.text.trim();
                        if (_email.isEmpty) {
                          if(Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification){
                            showCustomSnackBar(getTranslated('enter_email_address', context), context);
                          }else {
                            showCustomSnackBar(getTranslated('enter_phone_number', context), context);
                          }
                        }else if (Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification
                            && EmailChecker.isNotValid(_email)) {
                          showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                        }else if (_password.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_password', context), context);
                        }else if (_password.length < 6) {
                          showCustomSnackBar(getTranslated('password_should_be', context), context);
                        }else {
                          authProvider.login(_email, _password).then((status) async {
                            
                            if (status.isSuccess) {
                              if (authProvider.isActiveRememberMe) {
                                authProvider.saveUserNumberAndPassword(UserLogData(
                                  countryCode:  _countryDialCode,
                                  phoneNumber: _configModel.emailVerification ? null : _emailController.text,
                                  email: _configModel.emailVerification ? _emailController.text : null,
                                  password: _password,
                                ));
                              } else {
                                authProvider.clearUserLogData();
                              }

                             Navigator.pushNamedAndRemoveUntil(context, RouteHelper.menu, (route) => false, arguments: MenuScreen());
                            }
                          });
                        }
                      },
                    ) : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        )),
                    SizedBox(height: 20),


                    // for create an account
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteHelper.signUp, arguments: SignUpScreen());
                      },
                      child: Padding(padding: EdgeInsets.all(8.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated('create_an_account', context),
                              style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getHintColor(context)),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Text(
                              getTranslated('signup', context),
                              style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getTextColor(context)),
                            ),
                          ])),
                    ),

                    if(_socialStatus.isFacebook || _socialStatus.isGoogle)
                      Center(child: SocialLoginWidget()),


                    Center(child: Text(getTranslated('OR', context), style: poppinsRegular.copyWith(fontSize: 12))),

                    Center(child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(1, 40),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RouteHelper.menu, arguments: MenuScreen());
                      },
                      child: RichText(text: TextSpan(children: [
                        TextSpan(text: '${getTranslated('continue_as_a', context)} ',  style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getHintColor(context))),
                        TextSpan(text: getTranslated('guest', context), style: poppinsRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge.color)),
                      ])),

                    )),
                  ],
                )),
              ),
            )),

            ResponsiveHelper.isDesktop(context) ? SizedBox(height: 50,) : SizedBox(),

            ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
          ]),
        ),
      ))),

    );
  }
}