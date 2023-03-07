import 'dart:async';
import 'dart:developer';
import 'dart:convert' as convert;
import 'dart:io';



import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/navigation.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/pages/manageorder.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/pages/wallet.dart';
import 'package:winao_client_app/pages/welcome_screen.dart';
import 'package:winao_client_app/services/api_urls.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/showSnackbar.dart';
import 'bottomnavigation.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // StreamSubscription<PendingDynamicLinkData?>? mySocket;
  // Future<void> initDynamicLinks(context) async {
  //   final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  //   print('the link are');
  //   print(initialLink?.utmParameters);
  //   print('thhhhhh');
  //   print(initialLink?.asMap());
  //   print('thhhhhhgf');
  //   print(initialLink?.link);
  //
  //
  //   print('thhhhhhrfgtrf');
  //   print(initialLink?.android);
  //   if(initialLink!=null){
  //     print("this is initiallink ----"+initialLink.utmParameters.toString());
  //   }
  //   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //   // dynamicLinks.;
  //
  //   mySocket = dynamicLinks.onLink.listen((PendingDynamicLinkData? dynamicLinkData) {
  //     print('link data----- ${dynamicLinkData?.link.path}');
  //     showSnackbar(context, '${dynamicLinkData?.link.path}');
  //     // Navigator.pushNamed(context, dynamicLinkData.link.path);
  //   });
  //   //     .onError((error) {
  //   //   print('onLink error');
  //   //   print(error.message);
  //   // });
  // }

  Future<void> initDynamicLinks(context) async {
    // print('hello print');
    // log('hello print');
    //
    //
    // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    // print('hello print');
    // log('hello print');
    // print('initialLinkkkkk-----${initialLink}');
    // print('initialLink-----${initialLink?.link.path.toString()}');
    // // await showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'initialLink---${initialLink}');

    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    // try{
    //   PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
    //   final Uri? code = m?.link;
    //   // final Uri code = m?.link.path.toString();
    //
    //   print('codenotinitilize----${code}');
    // }
    // catch(e){
    //   log('error---${e}');
    // }



    dynamicLinks.onLink.listen((dynamicLinkData) async {
      var code = dynamicLinkData.link.path.toString().substring(1);
      // navigateThroughDynamicLink(context,code);

    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  takePer() async {
    // final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> statuses;
    // Map<Permission, PermissionStatus> statuses = await [
    //   // Permission.location,
    //   Permission.storage,
    // ].request();
    // print("annnnn----------------${statuses[Permission.storage]}");
    // print(statuses[Permission.storage]);
    statuses = await [Permission.photos , Permission.notification].request();
    print("annnnn------11----------${statuses[Permission.photos]}");
    var isDenied=statuses[Permission.photos];

    if (isDenied == PermissionStatus.permanentlyDenied) {
      print("Permission-----------");
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
      print("annnnn------22----------${statuses[Permission.photos]}");

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds:2)).then((value) async {
    //
      Foo.initDynamicLinks();
     // await Permission.camera.request();
     await Permission.storage.request();
     // await Permission.manageExternalStorage.request();
     // takePer();

        print("gfjygdj ..............${await Permission.storage.isGranted}");
      await Permission.storage.request();
      print("gfjygdj ..............${await Permission.storage.isGranted}");
        // Either the permission was already granted before or the user just granted it.
      // return ;
      var userLoggedIn = await isUserLoggedIn();

      if(userLoggedIn==true){

        print("login");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyStatefulWidget(key: MyGlobalKeys.tabBarKey,)));
      }
      else{
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const WelcomeScreen(),
          ),
        );
      }


      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WalletPage()));
      // push(context: this.context, screen: WelcomeScreen());
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xFF004173),
      body: SingleChildScrollView(

        child: Column(
          children: [
            // RoundEdgedButton(text: 'gfksjklgf', onTap: ()async{
            //   await Permission.mediaLibrary;
            //   await Permission.mediaLibrary.request();
            //
            //
            //   await Permission.storage.request();
            //   print("gfjygdj ..............${await Permission.mediaLibrary.isGranted}");
            // },),
            Container(
              // width: 250,
              height: 760,
              child: Center(

                child: Image.asset(
                  'assets/images/logo-2.png',
                  width: 250,
                  fit: BoxFit.fitWidth,
                ),

              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(10),
            //     child: Text('Tus compras más fáciles y seguras',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: MyColors.primaryColor),))
          ],
        ),
      ),
    );
  }
}
class Foo {
  static void func() => print('Hello');
  static Future<void> initDynamicLinks() async {
    print('kbpohjhpobjrt');
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    //dynamic link code.......
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      print('dynamicLink-------${dynamicLinkData.link.toString()}');
      var code = dynamicLinkData.link.path.toString().substring(1);
      print('codewhendynamiclink----------------${code}');
      await navigateThroughDynamicLink(code);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

    //initial link code.......
    PendingDynamicLinkData? m = await dynamicLinks.getInitialLink();
    final Uri? code = m?.link;
    print('initial link------${code}');
    var code1 = code?.path.toString().substring(1);
    print('theeee data is-- -------${code1}');
    await navigateThroughDynamicLink(code1);

  }

  static navigateThroughDynamicLink(code)async{
    print('code-----${code}');



    var res1 = await Webservices.getData(ApiUrls.getrecommend_bycode+'?code=${code}');
    var jsonResponse = convert.jsonDecode(res1.body);
    var res=jsonResponse['data'];
    if(jsonResponse['status'].toString() == '0'){
      print('Invalid  code');
      // showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Invalid code.');
    }
    else if(jsonResponse['status'].toString() == '1'){
      var agentinfo=res['agent_info'];
      var customerinfo=res['customer_info'];
      print('recomenid..${res['id']}');
      var id=res['id'];
      print('Agentinfo..$agentinfo');
      print('ref_id..${res['ref_id']}');
      var refid=res['ref_id'];

      // print('orderinfo..$Id');
      var date=res['created_at'];
      print('orderinfo..$date');
      var products=res['products'];
      print('products..$products');
      print('status..........${res['status']}');
      print('i am in checkout');

      if(res['status'].toString() == '0'){
        print('hiihrhjrfgth');
        Navigator.push(MyGlobalKeys.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:'Id' ,date:date,reffid:refid,recomenid:id)));
      }
      else {
        print('iaminelse');
        var orderid=res['order']!['id'].toString();
        refid=res['ref_id'].toString();
        print('orderid..........${orderid}');

        await Navigator.push(
          MyGlobalKeys.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
        );
      }

      //res['status']==0  => checkout
      //Detail page
    }
    log('Apiresponse................867.${jsonResponse['status']}');
  }

}

