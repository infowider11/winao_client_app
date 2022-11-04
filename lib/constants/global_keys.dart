import 'package:flutter/cupertino.dart';
import 'package:winao_client_app/pages/home.dart';

import '../packages/packages/lib/widget/search_widget.dart';
import '../pages/bottomnavigation.dart';
import '../pages/checkout.dart';



class MyGlobalKeys{
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  static final GlobalKey<SearchLocationState> searchLocationKey = new GlobalKey<SearchLocationState>();
  static GlobalKey<MyStatefulWidgetState> tabBarKey = GlobalKey<MyStatefulWidgetState>();
  //step 1
  // static GlobalKey xcy = GlobalKey();
//step 2
  static GlobalKey<CheckoutState> xcy = GlobalKey<CheckoutState>();
  static GlobalKey<HomeState> homepagekey = GlobalKey<HomeState>();



}
String notificationnumber='';