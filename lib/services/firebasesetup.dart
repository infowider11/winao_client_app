import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:winao_client_app/services/auth.dart';
import 'package:winao_client_app/services/webservices.dart';

import '../constants/global_keys.dart';
import '../pages/manageorder.dart';

String token = '';
// {receiver: 51, sender: 55, screen: chat_page}
FirebaseMessaging messaging = FirebaseMessaging.instance;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
InitializationSettings initializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: IOSInitializationSettings(),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  print('${message.data}');
  if (message.data['screen'] == 'recommended') {
    print('firebase notification baghhsid callled ');
    print('popping');
    Navigator.popUntil(
        MyGlobalKeys.navigatorKey.currentContext!, (route) => route.isFirst);
    MyGlobalKeys.tabBarKey.currentState?.onItemTapped(0);
  }
  if (message.data['screen'] == 'order') {
    print('popping');
    Navigator.push(
      MyGlobalKeys.tabBarKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => ManageOrdersPage(
                orderid: '${message.data['order_id']}',
                orderData: {},
              )),
    );
  }
  // if(message.data['screen']=='order'){
  //   print('firebase notification baghhsid callled ');
  //   // try{
  //   //   Navigator.push(
  //   //     MyGlobalKeys.navigatorKey.currentContext!,
  //   //     MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData: {}, orderid:message.data['order_id'],)),
  //   //   );
  //   //
  //   //
  //   // }catch(e){
  //   //   print('error in updating notifications count');
  //   // }
  // }
  // else if(message.data['screen']=='withdrawal'){
  //   print('firebase notification baghhsid callled ');
  //   try{
  //     Navigator.push(
  //       MyGlobalKeys.navigatorKey.currentContext!,
  //       MaterialPageRoute(builder: (context) =>  WalletPage(id:message.data['id'] ,)),
  //     );
  //
  //
  //   }catch(e){
  //     print('error in updating notifications count');
  //   }
  // }
}

class FirebasePushNotifications {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
  ///step 1: Add this to main

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   onSelectNotification: (payload)async{
//   print('the notification is selected $payload');
//   // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
//   if(payload!=null){
//   try{
//   Map data = jsonDecode(payload);
//   if(data['screen']=='booking'){
//   Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${data['booking_id']}');
//   push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
//   }
//   }catch(e){
//   print('Error in catch block 332 $e');
//   }
//
//   }
// }
// await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  //
  // );
  // await FirebasePushNotifications.firebaseSetup();
  /// step 2:
  ///Create certificate Key from here
  /// https://console.firebase.google.com/project/cycle-up-338208/settings/cloudmessaging

  /// step 3 :
  /// get permission
  /// step 4 :
  /// get token and then store it to database, so that we can send notification to that specific
  /// android token.

  static const String webPushCertificateKey =
      'BPE6NfMirgOcbGrnJJ-NvlXwMpRnWm_Df0UNwLSxFXshKgAUNF-HjNmbgye_knKsbZxmTEOQz6w10Mm9TVcibO4';

  /// this token is used to send notification // use the returned token to send messages to users from your custom server
  static String? token;

  static Future<NotificationSettings> getPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings;
  }

  static Future<String?> getToken() async {
    token = await messaging.getToken(vapidKey: webPushCertificateKey);
    return token;
  }

  static Future<void> firebaseSetup() async {
    // FirebaseMessaging.onBackgroundMessage((message)async{
    //   print)
    // })
    // FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
    //   print('firebase messaging is being listened');
    //   try{
    //     RemoteNotification? notification = message.notification;
    //     var data = message.data;
    //
    //     // log('notidata+--'+data.toString());
    //     AndroidNotification? android = message.notification?.android;
    //     log('this is notification bb bb ---  ');
    //     print('___________${notification.toString()}');
    //     print('________________');
    //     print(message.data);
    //     print('________________');
    //     if (notification != null && android != null) {
    //       if(message.data['screen']=='withdrawal'){
    //         try{
    //           // if(MyGlobalKeys.tabBarKey2.currentState!=null)
    //           wallet_id=message.data['id'];
    //           if(message.data['user_type'].toString()=='1'){
    //             MyGlobalKeys.tabBarKey2.currentState!.onItemTapped(3);
    //           }
    //           else if(message.data['user_type'].toString()=='2'){
    //             MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
    //           }
    //
    //         }catch(e){
    //           print('Error in catch block 342 $e');
    //         }
    //       }
    //       else if(message.data['screen']=='order'){
    //         Navigator.push(
    //           MyGlobalKeys.navigatorKey.currentContext!,
    //           MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:message.data['order_id'].toString(),)),
    //         );
    //       }
    //
    //
    //       // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
    //       await flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           // null,
    //           notification.title,
    //           notification.body,
    //
    //           NotificationDetails(
    //             android: AndroidNotificationDetails(
    //               channel.id,
    //               channel.name,
    //               color: Colors.blue,
    //               playSound: true,
    //               icon: '@mipmap/notification_icon',
    //             ),
    //           ),
    //           payload:jsonEncode(data)
    //       );
    //       print('the payLoad is $data');
    //     }
    //   }catch(e){
    //     print('error in listening notifications $e');
    //   }
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      print('notification get-------${message.data}',);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String title = "";
      log('this is notification aa aa ---  ');

      if (notification != null) {
        title = notification.title.toString();
      }
      if (notification != null && android != null) {
        log('this is notification ---  ');

        if(message.data['screen']=='recommended'){
          print('recommended screen---');
          Navigator.popUntil(MyGlobalKeys.navigatorKey.currentContext!, (route) => route.isFirst);
          // MyGlobalKeys.tabBarKey.currentState?.onItemTapped(1);
        }

        if(message.data['screen']=='order'){
          print('order screen---');
          Navigator.push(
            MyGlobalKeys.tabBarKey.currentContext!,
              MaterialPageRoute(builder: (context) =>
                  ManageOrdersPage(orderid: '${message.data['order_id']}', orderData: {},)),
          );
        }

      }
    });

    FirebaseMessaging.instance.getToken().then((value) async {
      token = value.toString();
      print('device token---------------------- ' + value.toString());
      if (value != null) {
        // String? userId = await getCurrentUserId();

        if (await isUserLoggedIn()) {
          var id = await getCurrentUserId();
          await Webservices.updateDeviceToken(userId: id, token: value);
          // id, device_id
        } else {
          print('device token not updated');
        }
      }

      // log("token-------"+value.toString());
    });
  }
}
