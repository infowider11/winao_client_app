import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/billing.dart';
import 'package:winao_client_app/pages/bottomnavigation.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/pages/detail.dart';
import 'package:winao_client_app/pages/forgot_password.dart';
import 'package:winao_client_app/pages/home.dart';
import 'package:winao_client_app/pages/home_without_login.dart';
import 'package:winao_client_app/pages/manageorder.dart';
import 'package:winao_client_app/pages/myorder.dart';
import 'package:winao_client_app/pages/notification.dart';
import 'package:winao_client_app/pages/recommended_product.dart';
import 'package:winao_client_app/pages/referral_code.dart';
import 'package:winao_client_app/pages/settings.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/pages/signup.dart';
import 'package:winao_client_app/pages/splash_screen.dart';
import 'package:winao_client_app/pages/thankyou.dart';
import 'package:winao_client_app/pages/wallet.dart';
import 'package:winao_client_app/pages/welcome_screen.dart';
import 'package:path/path.dart';
// import 'package:path/path.dart' as Path;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:winao_client_app/services/api_urls.dart';
import 'package:winao_client_app/services/firebasesetup.dart';
import 'package:winao_client_app/services/webservices.dart';
import 'package:winao_client_app/widgets/loader.dart';
import 'package:winao_client_app/widgets/showSnackbar.dart';

import 'constants/colors.dart';
import 'dart:convert' as convert;


void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // await FlutterDownloader.initialize(debug: true);

  await Firebase.initializeApp();


  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
  // final Uri? code = m?.link;
  // print('theeee data is ${code?.path}');

  // Foo.initDynamicLinks();

  // Future.delayed(Duration(seconds: 7)).then((value){
  //   Foo.initDynamicLinks();
  // });



  print('prasoon-----firebase ini successfully-----------');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload)async{
        print('the notification is selected $payload');
        // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
        if(payload!=null){
          try{
            Map data = jsonDecode(payload);
            print('Notification-----------');
            print('Notification data-------${data}');
            if(data['screen']=='recommended'){
              print('popping');
              Navigator.popUntil(MyGlobalKeys.navigatorKey.currentContext!, (route) => route.isFirst);
              MyGlobalKeys.tabBarKey.currentState?.onItemTapped(1);
              // // Navigator.push(
              //   MyGlobalKeys.tabBarKey.currentContext!,
              //   MaterialPageRoute(builder: (context) =>  Home()),
              // );

              // Navigator.push(
              //     Navigator.popUntil(context, (route) => route.isFirst),
              //     MyGlobalKeys.tabBarKey.currentState?.onItemTapped(0),
              // );
            }
            else if(data['screen']=='order'){
              // for (var i=0; i<data.length; i++)
              Navigator.push(
                MyGlobalKeys.tabBarKey.currentContext!,
                MaterialPageRoute(builder: (context) =>
                    ManageOrdersPage(orderid: '${data['other']['order_id']}', orderData: {},)),
              );
              // Navigator.push(
              //   MyGlobalKeys.tabBarKey.currentContext!,
              //   MaterialPageRoute(builder: (context) =>  MyorderPage()),
              // );
            }

            // if(data['screen']=='withdrawal'){
            //   try{
            //     // if(MyGlobalKeys.tabBarKey2.currentState!=null)
            //
            //     if(data['user_type'].toString()=='3'){
            //       MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
            //     }
            //     else if(data['user_type'].toString()=='2'){
            //       MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
            //     }
            //
            //   }catch(e){
            //     print('Error in catch block 342 $e');
            //   }
            // }
            // else if(data['screen']=='order'){
            //   Navigator.push(
            //     MyGlobalKeys.navigatorKey.currentContext!,
            //     MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:data['order_id'].toString(),)),
            //   );
            // }
          }catch(e){
            print('Error in catch block 332 $e');
          }

        }
      });
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebasePushNotifications.firebaseSetup();
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en']);

  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  // if (initialLink != null) {
  //   final Uri deepLink = initialLink.link;
  //   log('deepLink-----${deepLink}');
  //
  // }


  // Future<void> initDynamicLinks(context) async {
  //   print('initDynamicLinks function run');
  //   // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  //   // if(initialLink!=null){
  //   //   print("app open first time this is initiallink ----"+initialLink.utmParameters.toString());
  //   // }
  //   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     print('app open from background '+dynamicLinkData.link.path);
  //     print('app open from backgrounddddd======${dynamicLinkData.link.path}');
  //
  //     showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, dynamicLinkData.link.path);
  //     Navigator.pushNamed(context, dynamicLinkData.link.path);
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }



  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  void initState() {
    print('init state called in mainfile...');
    // initDynamicLinks(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        navigatorKey:MyGlobalKeys.navigatorKey,
        title: 'winao_client_app',
        theme: ThemeData(
          fontFamily: 'regular',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        // initialRoute: SplashScreen.id,
        home: ScaffoldMessenger(child: SplashScreen()),
        routes: {
          // '/': (context)=> SplashScreen(),
          SplashScreen.id: (context)=> SplashScreen(),
          WelcomeScreen.id: (context)=> WelcomeScreen(),
          Referral_code.id: (context)=> Referral_code(),
          SignInPage.id: (context)=> SignInPage(),
          Signup.id: (context)=> Signup(),
          Forgotpassword.id: (context)=> Forgotpassword(),
          Home.id: (context)=> Home(),
          Detail_page.id: (context)=> Detail_page(productdata: {}, agent_name: '',),
          Checkout.id: (context)=> Checkout(),
          NotificationPage.id: (context)=> NotificationPage(),
          SettingsPage.id: (context)=> SettingsPage(),
          MyStatefulWidget.id: (context)=> MyStatefulWidget(key: MyGlobalKeys.tabBarKey,),
          BillingPage.id: (context)=> BillingPage(carts: [],),
          Thankyou.id: (context)=> Thankyou(),
          HomeWithoutLogin.id: (context)=> HomeWithoutLogin(),
          RecommendedProduct.id: (context)=> RecommendedProduct(),
          WalletPage.id: (context)=> WalletPage(),
        },
      ),
    );
  }
  // Future<void> initDynamicLinks(context) async {
  //
  //   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //   dynamicLinks.onLink.listen((dynamicLinkData) async {
  //     var code = dynamicLinkData.link.path.toString().substring(1);
  //     navigateThroughDynamicLink(context,code);
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }



  // navigateThroughDynamicLink(context,code)async{
  //   // print('code-----${code}');
  //   // print('context----${context}');
  //
  //   // print('app open from backgroundddlink1--- '+dynamicLinkData.link.path.toString());
  //
  //
  //   var res1 = await Webservices.getData(ApiUrls.getrecommend_bycode+'?code=${code}');
  //   var jsonResponse = convert.jsonDecode(res1.body);
  //   var res=jsonResponse['data'];
  //   if(jsonResponse['status'].toString() == '0'){
  //     print('Invalid  code');
  //     showSnackbar(context, 'Invalid code.');
  //   }
  //   else if(jsonResponse['status'].toString() == '1'){
  //     var agentinfo=res['agent_info'];
  //     var customerinfo=res['customer_info'];
  //     print('recomenid..${res['id']}');
  //     var id=res['id'];
  //     print('Agentinfo..$agentinfo');
  //     print('ref_id..${res['ref_id']}');
  //     var refid=res['ref_id'];
  //
  //     // print('orderinfo..$Id');
  //     var date=res['created_at'];
  //     print('orderinfo..$date');
  //     var products=res['products'];
  //     print('products..$products');
  //     print('status..........${res['status']}');
  //     print('i am in checkout');
  //
  //     if(res['status'].toString() == '0'){
  //       print('hiihrhjrfgth');
  //       Navigator.push(MyGlobalKeys.navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:'Id' ,date:date,reffid:refid,recomenid:id)));
  //     }
  //     else {
  //       print('iaminelse');
  //       var orderid=res['order']!['id'].toString();
  //       refid=res['ref_id'].toString();
  //       print('orderid..........${orderid}');
  //
  //       await Navigator.push(
  //         MyGlobalKeys.navigatorKey.currentContext!,
  //         MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
  //       );
  //     }
  //
  //     //res['status']==0  => checkout
  //     //Detail page
  //   }
  //   log('Apiresponse................867.${jsonResponse['status']}');
  // }



    // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    // print('hello print');
    // log('hello print');
    // print('initialLinkkkkk-----${initialLink}');
    // print('initialLink-----${initialLink?.link.path.toString()}');
    // // await showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'initialLink---${initialLink}');



    // PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
    // final Uri? code = m?.link;
    // print('theeee data is ${code?.path}');



    // try{
    //  PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
    //  final Uri? code = m?.link;
    //  // final Uri code = m?.link.path.toString();
    //
    //  print('codenotinitilize----${code}');
    // }
    //   catch(e){
    //        log('error---${e}');
    //      }







  }

// class Foo {
//   static void func() => print('Hello');
//   static Future<void> initDynamicLinks() async {
//     FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//
//
//
//
//     dynamicLinks.onLink.listen((dynamicLinkData) async {
//       var code = dynamicLinkData.link.path.toString().substring(1);
//       print('codewhendynamiclink----------------${code}');
//       await navigateThroughDynamicLink(code);
//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
//
//     PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
//     final Uri? code = m?.link;
//     print('initial link------${code}');
//     var code1 = code?.path.toString().substring(1);
//     print('theeee data is-- -------${code1}');
//     await navigateThroughDynamicLink(code1);
//
//   }
//   static navigateThroughDynamicLink(code)async{
//     print('code-----${code}');
//     // print('context----${context}');
//
//     // print('app open from backgroundddlink1--- '+dynamicLinkData.link.path.toString());
//
//
//     var res1 = await Webservices.getData(ApiUrls.getrecommend_bycode+'?code=${code}');
//     var jsonResponse = convert.jsonDecode(res1.body);
//     var res=jsonResponse['data'];
//     if(jsonResponse['status'].toString() == '0'){
//       print('Invalid  code');
//       showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Invalid code.');
//     }
//     else if(jsonResponse['status'].toString() == '1'){
//       var agentinfo=res['agent_info'];
//       var customerinfo=res['customer_info'];
//       print('recomenid..${res['id']}');
//       var id=res['id'];
//       print('Agentinfo..$agentinfo');
//       print('ref_id..${res['ref_id']}');
//       var refid=res['ref_id'];
//
//       // print('orderinfo..$Id');
//       var date=res['created_at'];
//       print('orderinfo..$date');
//       var products=res['products'];
//       print('products..$products');
//       print('status..........${res['status']}');
//       print('i am in checkout');
//
//       if(res['status'].toString() == '0'){
//         print('hiihrhjrfgth');
//         Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
//             MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:'Id' ,date:date,reffid:refid,recomenid:id)));
//       }
//       else {
//         print('iaminelse');
//         var orderid=res['order']!['id'].toString();
//         refid=res['ref_id'].toString();
//         print('orderid..........${orderid}');
//
//         await Navigator.push(
//           MyGlobalKeys.navigatorKey.currentContext!,
//           MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
//         );
//       }
//
//       //res['status']==0  => checkout
//       //Detail page
//     }
//     log('Apiresponse................867.${jsonResponse['status']}');
//   }
// }
