import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Images {
  // SVG
  static const String more_icon = 'assets/image/more_icon.png';
  static const String england_flag = 'assets/image/england.png';
  static const String maintenance = 'assets/image/maintenance.png';
  static const String chat = 'assets/image/chat.png';
  static const String language = 'assets/image/language.png';
  static const String privacy_policy = 'assets/image/privacy_policy.png';
  static const String coupon = 'assets/image/coupon.png';
  static const String home = 'assets/image/home.png';
  static const String list = 'assets/image/list.png';
  static const String location = 'assets/image/location.png';
  static const String log_out = 'assets/image/log_out.png';
  static const String order_bag = 'assets/image/order_bag.png';
  static const String box = 'assets/image/box.png';
  static const String not_found = 'assets/image/not_found.png';
  static const String shopping_cart = 'assets/image/shopping_cart.png';
  static const String settings = 'assets/image/settings.png';
  static const String order_list = 'assets/image/order_list.png';
  static const String order_placed = 'assets/image/order_placed.png';
  static const String about_us = 'assets/image/about_us.png';
  static const String privacy = 'assets/image/privacy.png';
  static const String lock = 'assets/image/lock.png';
  static const String grofresh_text = 'assets/image/GroFresh.png';
  static const String search = 'assets/image/search.png';
  static const String profile = 'assets/image/profile.png';
  static const String notification = 'assets/image/notification.png';
  static const String shopping_cart_bold = 'assets/image/cart_bold.png';
  static const String terms_and_conditions = 'assets/image/terms_and_conditions.png';
  static const String login = 'assets/image/login.png';
  static const String close = 'assets/image/clear.png';
  static const String arabic_flag = 'assets/image/arabic.png';
  static const String support = 'assets/image/support.png';
  static const String profile_placeholder = 'assets/image/pro_place_holder.png';
  static const String google = 'assets/image/google.png';
  static const String faq = 'assets/image/faq.png';
  static const String translate_logo = 'assets/image/translate_logo.png';
  static const String loyalty_icon = 'assets/image/loyalty_icon.png';
  static const String referral_icon = 'assets/image/referral_icon.png';
  static const String earning_image = 'assets/image/earning.png';
  static const String converted_image = 'assets/image/converted.png';
  static const String loyal = 'assets/image/loyal.png';
  static const String return_policy = 'assets/image/return_policy.png';
  static const String refund_policy = 'assets/image/refund_policy.png';
  static const String cancellation_policy = 'assets/image/cancellation_policy.png';
  static const String whatsapp = 'assets/image/whatsapp.png';
  static const String telegram = 'assets/image/telegram.png';
  static const String messenger = 'assets/image/messenger.png';
  static const String favourite_icon = 'assets/image/favourite_icon.png';
  static const String gif_box_dark = 'assets/image/gift_box_dark.gif';
  static const String gif_box = 'assets/image/giftbox.gif';
  static const String loyalty_background = 'assets/image/loyalty_background.png';
  static const String wallet_background = 'assets/image/wallet_background.png';







  // Image
  static const String app_logo = 'assets/image/app_logo.png';
  static const String app_logo_bar = 'assets/image/app_logo_bar.png';
  static const String on_boarding_1 = 'assets/image/on_boarding_1.png';
  static const String on_boarding_2 = 'assets/image/on_boarding_2.png';
  static const String on_boarding_3 = 'assets/image/on_boarding_3.png';
  static const String close_lock = 'assets/image/close_lock.png';
  static const String open_lock = 'assets/image/open_lock.png';
  static const String email_with_background = 'assets/image/email_with_background.png';
  static const String cart_icon = 'assets/image/cart.png';
  static const String coupon_bg = 'assets/image/coupon_bg.png';
  static const String percentage = 'assets/image/percentage.png';
  static const String line = 'assets/image/line.png';
  static const String call = 'assets/image/call.png';
  static const String placeholder_light = 'assets/image/placeholder.jpg';
  static const String placeholder_dark = 'assets/image/placeholder.jpeg';
  static String placeholder(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? placeholder_light : placeholder_light;
  }
  static const String update = 'assets/image/update.png';

  static const String camera = 'assets/image/camera.png';
  static const String map_marker = 'assets/image/marker.png';
  static const String restaurant_marker = 'assets/image/restaurant_marker.png';
  static const String delivery_boy_marker = 'assets/image/delivery_boy_marker.png';
  static const String destination_marker = 'assets/image/destination_marker.png';
  static const String unselected_restaurant_marker = 'assets/image/unselected_restaurant_marker.png';
  static const String wallet = 'assets/image/wallet.png';
  static const String facebook = 'assets/image/facebook.png';
  static const String twitter = 'assets/image/twitter.png';
  static const String youtube = 'assets/image/youtube.png';
  static const String play_store = 'assets/image/play_store.png';
  static const String app_store = 'assets/image/app_store.png';
  static const String send = 'assets/image/send.png';
  static const String image = 'assets/image/image.png';
  static const String linked_in_icon = 'assets/image/linkedin_icon.png';
  static const String in_sta_gram_icon = 'assets/image/instagram_icon.png';
  static const String pinterest = 'assets/image/pinterest.png';
  static const String refer_banner = 'assets/image/refer_banner.png';
  static const String i_mark = 'assets/image/i_mark.png';
  static const String flash_deal = 'assets/image/flash_deal.png';


  static String getShareIcon(String name) => 'assets/image/$name.png';
  static String getPaymentImage(String name) => 'assets/payment/$name.png';


}
