import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/referral_code.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../constants/global_costants.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/customtextfield.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
import 'checkout.dart';
import 'dart:convert' as convert;

import 'manageorder.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController controller = PageController();
  List products = [];
  Map orderinfo = {};
  String? Id;
  String? orderid;
  String? date;
  String? refid;
  String? id;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // page0() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(10),
  //           child: Container(
  //
  //             decoration: BoxDecoration(
  //                 // color: Colors.red,
  //                 image: DecorationImage(
  //                     image: AssetImage(MyImages.welcomeScreen1),
  //                     fit: BoxFit.fitWidth,
  //                     alignment: Alignment.topCenter)),
  //             height: 380,
  //             width: MediaQuery.of(context).size.width,
  //             // width: 100,
  //           ),
  //         ),
  //         // Container(
  //         //   child: Column(
  //         //     children: [
  //         //       Container(
  //         //         padding: EdgeInsets.symmetric(horizontal: 16),
  //         //         child: MainHeadingText(
  //         //           text: 'Productos recomendados',
  //         //           color: MyColors.bul,
  //         //           textAlign: TextAlign.center,
  //         //           fontSize: 28,
  //         //           fontFamily: 'bold',
  //         //           height: 1.4,
  //         //         ),
  //         //       ),
  //         //       vSizedBox4,
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ParagraphText(
  //                   text: translate(
  //                       "Recibe las mejores recomendaciones de tus amigos, conocidos y familiares"),
  //                   color: MyColors.welcomescreensubtextcolor,
  //                   textAlign: TextAlign.center,
  //                   // letterspacing: 1,
  //                   // height:1,
  //
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               vSizedBox4,
  //               vSizedBox4,
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: RoundEdgedButton(
  //                   // isSolid: false,
  //
  //                   text: 'Comenzar con código',
  //                   textColor: MyColors.whiteColor,
  //                   color: Color(0xFF13b8e8),
  //
  //                   onTap: () {
  //                     showModalBottomSheet<void>(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
  //                       ),
  //                       backgroundColor: Colors.transparent,
  //                       context: context,
  //                       builder: (BuildContext context) {
  //
  //                         return Scaffold(
  //                           backgroundColor: Colors.transparent,
  //                           body: Column(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //                               Container(
  //                                 // height:300,
  //
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
  //
  //                                 ),
  //
  //                                 child: SingleChildScrollView(
  //                                   child: Column(
  //                                     mainAxisAlignment: MainAxisAlignment.center,
  //                                     // mainAxisSize: MainAxisSize.min,
  //                                     children: <Widget>[
  //                                       Container(
  //                                         // height:300,
  //                                         padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
  //                                         child: Column(
  //                                           crossAxisAlignment: CrossAxisAlignment.center,
  //                                           children: [
  //                                             MainHeadingText(
  //                                               text: 'Ingresa tu codigo de recomendación',
  //                                               color: Color(0xFF5b5b5b),
  //                                               textAlign: TextAlign.center,
  //                                               fontSize: 18,
  //                                               // fontFamily: 'semibold',
  //                                             ),
  //                                             vSizedBox2,
  //                                             CustomTextField(
  //                                               controller: codeController,
  //                                               hintText: 'PQR12345',
  //                                               textcolor: Color(0xFF828282),
  //                                               textAlign: TextAlign.center,
  //                                               borderColor: Color(0xFFd2d2d2),
  //                                             ),
  //                                             RoundEdgedButtonred(
  //                                               text: 'Ver los productos',
  //                                               color: Color(0xFF00a1e4),
  //                                               onTap: () async {
  //                                                 print("data");
  //                                                 if (codeController.text == '') {
  //                                                   showSnackbar(context, 'Please Enter your code.');
  //                                                   print("i am in ifftjfj");
  //                                                 } else {
  //                                                   print("gsghghshg");
  //                                                   loadingShow(context);
  //                                                   print("gsgh");
  //                                                   var res1 = await Webservices.getData(
  //                                                       ApiUrls.getrecommend_bycode +
  //                                                           '?code=${codeController.text}');
  //                                                   var jsonResponse = convert.jsonDecode(res1.body);
  //                                                   log('Apiresponse................867.${jsonResponse['status']}');
  //
  //                                                   var res = jsonResponse['data'];
  //                                                   // loadingHide(context);
  //                                                   //  print("Appiresponse"+res.body);
  //                                                   //  print('Apiresponse----$res');
  //                                                   //
  //                                                   // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
  //                                                   log('Apiresponse.................889.$res');
  //                                                   loadingHide(context);
  //
  //                                                   if (jsonResponse['status'].toString() == '0') {
  //                                                     print('Invalid  code');
  //                                                     showSnackbar(context, 'Invalid code.');
  //                                                   } else if (jsonResponse['status'].toString() == '1') {
  //                                                     agentinfo = res['agent_info'];
  //                                                     customerinfo = res['customer_info'];
  //                                                     print('recomenid..${res['id']}');
  //                                                     id = res['id'];
  //                                                     print('Agentinfo..$agentinfo');
  //                                                     print('ref_id..${res['ref_id']}');
  //                                                     refid = res['ref_id'];
  //                                                     print('orderinfo..$Id');
  //                                                     date = res['created_at'];
  //                                                     print('orderinfo..$date');
  //                                                     products = res['products'];
  //                                                     print('products..$products');
  //                                                     print('status..........${res['status']}');
  //                                                     print('i am in checkout');
  //
  //                                                     if (res['status'].toString() == '0') {
  //                                                       Navigator.push(
  //                                                           context,
  //                                                           MaterialPageRoute(
  //                                                               builder: (context) => Checkout(
  //                                                                   product: products,
  //                                                                   agent: agentinfo,
  //                                                                   customer: customerinfo,
  //                                                                   order_id: Id,
  //                                                                   date: date,
  //                                                                   reffid: refid,
  //                                                                   recomenid: id)));
  //                                                     } else {
  //                                                       orderid = res['order']!['id'].toString();
  //                                                       refid = res['ref_id'].toString();
  //                                                       print('orderid..........${orderid}');
  //                                                       await showDialog(
  //                                                         context: context,
  //                                                         builder: (context) {
  //                                                           return Dialog(
  //                                                             insetPadding: EdgeInsets.symmetric(
  //                                                                 horizontal: 32, vertical: 64),
  //                                                             shape: RoundedRectangleBorder(
  //                                                                 borderRadius: BorderRadius.circular(0)),
  //                                                             elevation: 16,
  //                                                             child: Container(
  //                                                               padding: EdgeInsets.all(20),
  //                                                               // height:200.0,
  //                                                               // width: 400.0,
  //                                                               child: Column(
  //                                                                 mainAxisSize: MainAxisSize.min,
  //                                                                 children: <Widget>[
  //                                                                   // Row(
  //                                                                   //   mainAxisAlignment: MainAxisAlignment.end,
  //                                                                   //   children: [
  //                                                                   //
  //                                                                   //   ],
  //                                                                   // ),
  //                                                                   // Icon(
  //                                                                   //   Icons.check_circle_outline,
  //                                                                   //   color: Colors.black,
  //                                                                   // ),
  //                                                                   // SizedBox(height: 20),
  //                                                                   // GestureDetector(
  //                                                                   //   onTap: (){
  //                                                                   //     Navigator.pop(context);
  //                                                                   //   },
  //                                                                   //   child: Align(
  //                                                                   //     alignment: Alignment.topRight,
  //                                                                   //     child: Icon(
  //                                                                   //       Icons.close,
  //                                                                   //       color: Colors.black,
  //                                                                   //     ),
  //                                                                   //   ),
  //                                                                   // ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'Thank You!',
  //                                                                       style: TextStyle(
  //                                                                           color: Colors.black,
  //                                                                           fontSize: 20,
  //                                                                           fontFamily: 'regular',
  //                                                                           fontWeight: FontWeight.bold),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'The purchase is already made for this',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   // vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'recommendation ID:${orderid}',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'Code:${refid}',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   ElevatedButton(
  //                                                                     onPressed: () {
  //                                                                       Navigator.pop(context);
  //                                                                       Navigator.push(
  //                                                                         context,
  //                                                                         MaterialPageRoute(
  //                                                                             builder: (context) =>
  //                                                                                 ManageOrdersPage(
  //                                                                                   orderData:
  //                                                                                   res['data'] ?? {},
  //                                                                                   orderid: orderid
  //                                                                                       .toString(),
  //                                                                                 )),
  //                                                                       );
  //                                                                     },
  //                                                                     child: Padding(
  //                                                                       padding:
  //                                                                       const EdgeInsets.symmetric(
  //                                                                           horizontal: 25.0),
  //                                                                       child: Text('Ok'),
  //                                                                     ),
  //                                                                     style: ElevatedButton.styleFrom(
  //                                                                       shape: StadiumBorder(),
  //                                                                       primary: MyColors.primaryColor,
  //                                                                     ),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                             ),
  //                                                           );
  //                                                         },
  //                                                       );
  //                                                     }
  //
  //                                                     //res['status']==0  => checkout
  //                                                     //Detail page
  //                                                   }
  //                                                 }
  //
  //                                                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout()));
  //                                               },
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       )
  //
  //
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   // Navigator.pushNamed(context, SignInPage.id);
  //
  //                   boderRadius: 10,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //
  //                 child: RoundEdgedButton(
  //                   isSolid: false,
  //                   text: 'Iniciar sesión',
  //                   textColor: MyColors.whiteColor,
  //                   color: Color(0xFF13b8e8),
  //                   boderRadius: 10,
  //                   onTap: () {
  //                     Navigator.pushNamed(context, SignInPage.id);
  //                   },
  //                 ),
  //               ),
  //               vSizedBox,
  //
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  page0() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 0),
          //   child: Container(
          //
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //         image: DecorationImage(
          //             image: AssetImage(MyImages.welcomeScreen0),
          //             fit: BoxFit.fitWidth,
          //             alignment: Alignment.center)),
          //     height: 380,
          //     width: MediaQuery.of(context).size.width,
          //     // width: 100,
          //   ),
          // ),
          // Container(
          //   child: Column(
          //     children: [
          //
          //
          //     ],
          //   ),
          // )
          Expanded(
              flex:70,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 40),
                    child: Image.asset(MyImages.welcomeScreen1),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MainHeadingText(
                      text: 'Productos recomendados',
                      color: MyColors.primaryColor,
                      textAlign: TextAlign.center,
                      fontSize: 26,
                      fontFamily: 'bold',
                      height: 1.4,
                    ),
                  ),
                  vSizedBox,
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ParagraphText(
                      text: translate(
                          "Recibe las mejores recomen\n daciones  de tus amigos, \n conocidos y familiares"
                        // "Puedes realizar tus pedidos \n con tarjeta de credito  \n o depósito bancario"
                      ),
                      color: MyColors.welcomescreensubtextcolor,
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      fontFamily:'Roboto',
                      // fontWeight:FontWeight.w300 ,
                      height: 1.5,


                    ),
                  ),
                  // vSizedBox2,
                  // vSizedBox,
                  vSizedBox4,
                ],
              )),

          Expanded(
              flex: 30,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundEdgedButton(
                      isSolid: true,
                      text: 'Comenzar con código',
                      textColor: MyColors.whiteColor,
                      color: Color(0xFF00b7ff),

                      onTap: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
                          ),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {

                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    // height:300,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),

                                    ),

                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            // height:300,
                                            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                MainHeadingText(
                                                  text: 'Ingresa tu codigo de recomendación',
                                                  color: Color(0xFF5b5b5b),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 18,
                                                  // fontFamily: 'semibold',
                                                ),
                                                vSizedBox2,
                                                CustomTextField(
                                                  controller: codeController,
                                                  hintText: 'PQR12345',
                                                  textcolor: Color(0xFF828282),
                                                  textAlign: TextAlign.center,
                                                  borderColor: Color(0xFFd2d2d2),
                                                ),
                                                RoundEdgedButtonred(
                                                  text: 'Ver los productos',
                                                  color: Color(0xFF00a1e4),
                                                  onTap: () async {
                                                    print("data");
                                                    if (codeController.text == '') {
                                                      showSnackbar(context, 'Please Enter your code.');
                                                      print("i am in ifftjfj");
                                                    } else {
                                                      print("gsghghshg");
                                                      loadingShow(context);
                                                      print("gsgh");
                                                      var res1 = await Webservices.getData(
                                                          ApiUrls.getrecommend_bycode +
                                                              '?code=${codeController.text}');
                                                      var jsonResponse = convert.jsonDecode(res1.body);
                                                      log('Apiresponse................867.${jsonResponse['status']}');

                                                      var res = jsonResponse['data'];
                                                      // loadingHide(context);
                                                      //  print("Appiresponse"+res.body);
                                                      //  print('Apiresponse----$res');
                                                      //
                                                      // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
                                                      log('Apiresponse.................889.$res');
                                                      loadingHide(context);

                                                      if (jsonResponse['status'].toString() == '0') {
                                                        print('Invalid  code');
                                                        showSnackbar(context, 'Invalid code.');
                                                      } else if (jsonResponse['status'].toString() == '1') {
                                                        agentinfo = res['agent_info'];
                                                        customerinfo = res['customer_info'];
                                                        print('recomenid..${res['id']}');
                                                        id = res['id'];
                                                        print('Agentinfo..$agentinfo');
                                                        print('ref_id..${res['ref_id']}');
                                                        refid = res['ref_id'];
                                                        print('orderinfo..$Id');
                                                        date = res['created_at'];
                                                        print('orderinfo..$date');
                                                        products = res['products'];
                                                        print('products..$products');
                                                        print('status..........${res['status']}');
                                                        print('i am in checkout');

                                                        if (res['status'].toString() == '0') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Checkout(
                                                                      product: products,
                                                                      agent: agentinfo,
                                                                      customer: customerinfo,
                                                                      order_id: Id,
                                                                      date: date,
                                                                      reffid: refid,
                                                                      recomenid: id)));
                                                        } else {
                                                          orderid = res['order']!['id'].toString();
                                                          refid = res['ref_id'].toString();
                                                          print('orderid..........${orderid}');
                                                          await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                insetPadding: EdgeInsets.symmetric(
                                                                    horizontal: 32, vertical: 64),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                elevation: 16,
                                                                child: Container(
                                                                  padding: EdgeInsets.all(20),
                                                                  // height:200.0,
                                                                  // width: 400.0,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      // Row(
                                                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                                                      //   children: [
                                                                      //
                                                                      //   ],
                                                                      // ),
                                                                      // Icon(
                                                                      //   Icons.check_circle_outline,
                                                                      //   color: Colors.black,
                                                                      // ),
                                                                      // SizedBox(height: 20),
                                                                      // GestureDetector(
                                                                      //   onTap: (){
                                                                      //     Navigator.pop(context);
                                                                      //   },
                                                                      //   child: Align(
                                                                      //     alignment: Alignment.topRight,
                                                                      //     child: Icon(
                                                                      //       Icons.close,
                                                                      //       color: Colors.black,
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'Thank You!',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                              fontFamily: 'regular',
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'The purchase is already made for this',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'recommendation ID:${orderid}',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'Code:${refid}',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    ManageOrdersPage(
                                                                                      orderData:
                                                                                      res['data'] ?? {},
                                                                                      orderid: orderid
                                                                                          .toString(),
                                                                                    )),
                                                                          );
                                                                        },
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsets.symmetric(
                                                                              horizontal: 25.0),
                                                                          child: Text('Ok'),
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                          shape: StadiumBorder(),
                                                                          primary: MyColors.primaryColor,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }

                                                        //res['status']==0  => checkout
                                                        //Detail page
                                                      }
                                                    }

                                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout()));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )


                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      // Navigator.pushNamed(context, SignInPage.id);

                      boderRadius: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: RoundEdgedButton(
                      textColor: MyColors.whiteColor,
                      color: Color(0xFF00b7ff),
                      text: 'Iniciar sesión',
                      // textColor: MyColors.whiteColor,
                      // color: Color(0xFF13b8e8),
                      boderRadius: 10,
                      onTap: () {
                        Navigator.pushNamed(context, SignInPage.id);
                      },
                    ),
                  ),
                  vSizedBox,
                ],
              ))
        ],
      ),
    );
  }
  page1() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 0),
          //   child: Container(
          //
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //         image: DecorationImage(
          //             image: AssetImage(MyImages.welcomeScreen0),
          //             fit: BoxFit.fitWidth,
          //             alignment: Alignment.center)),
          //     height: 380,
          //     width: MediaQuery.of(context).size.width,
          //     // width: 100,
          //   ),
          // ),
          Expanded(
            flex:70,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 40),
                    child: Image.asset(MyImages.welcomeScreen0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MainHeadingText(
                      text: 'Pagos flexibles y seguros',
                      color: MyColors.primaryColor,
                      textAlign: TextAlign.center,
                      fontSize: 26,
                      fontFamily: 'bold',
                      height: 1.4,
                    ),
                  ),
                  vSizedBox,
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ParagraphText(
                      text: translate(
                          "Puedes realizar tus pedidos \n con tarjeta de credito  \n o depósito bancario"),
                      color: MyColors.welcomescreensubtextcolor,
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      fontFamily:'Roboto',
                      // fontWeight:FontWeight.w300 ,
                      height: 1.5,


                    ),
                  ),
                  vSizedBox4,
                  // vSizedBox4,
                ],
              )),
          Expanded(
              flex:30,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundEdgedButton(
                      isSolid: true,
                      text: 'Comenzar con código',
                      textColor: MyColors.whiteColor,
                      color: Color(0xFF00b7ff),

                      onTap: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
                          ),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {

                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    // height:300,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),

                                    ),

                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            // height:300,
                                            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                MainHeadingText(
                                                  text: 'Ingresa tu codigo de recomendación',
                                                  color: Color(0xFF5b5b5b),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 18,
                                                  // fontFamily: 'semibold',
                                                ),
                                                vSizedBox2,
                                                CustomTextField(
                                                  controller: codeController,
                                                  hintText: 'PQR12345',
                                                  textcolor: Color(0xFF828282),
                                                  textAlign: TextAlign.center,
                                                  borderColor: Color(0xFFd2d2d2),
                                                ),
                                                RoundEdgedButtonred(
                                                  text: 'Ver los productos',
                                                  color: Color(0xFF00a1e4),
                                                  onTap: () async {
                                                    print("data");
                                                    if (codeController.text == '') {
                                                      showSnackbar(context, 'Please Enter your code.');
                                                      print("i am in ifftjfj");
                                                    } else {
                                                      print("gsghghshg");
                                                      loadingShow(context);
                                                      print("gsgh");
                                                      var res1 = await Webservices.getData(
                                                          ApiUrls.getrecommend_bycode +
                                                              '?code=${codeController.text}');
                                                      var jsonResponse = convert.jsonDecode(res1.body);
                                                      log('Apiresponse................867.${jsonResponse['status']}');

                                                      var res = jsonResponse['data'];
                                                      // loadingHide(context);
                                                      //  print("Appiresponse"+res.body);
                                                      //  print('Apiresponse----$res');
                                                      //
                                                      // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
                                                      log('Apiresponse.................889.$res');
                                                      loadingHide(context);

                                                      if (jsonResponse['status'].toString() == '0') {
                                                        print('Invalid  code');
                                                        showSnackbar(context, 'Invalid code.');
                                                      } else if (jsonResponse['status'].toString() == '1') {
                                                        agentinfo = res['agent_info'];
                                                        customerinfo = res['customer_info'];
                                                        print('recomenid..${res['id']}');
                                                        id = res['id'];
                                                        print('Agentinfo..$agentinfo');
                                                        print('ref_id..${res['ref_id']}');
                                                        refid = res['ref_id'];
                                                        print('orderinfo..$Id');
                                                        date = res['created_at'];
                                                        print('orderinfo..$date');
                                                        products = res['products'];
                                                        print('products..$products');
                                                        print('status..........${res['status']}');
                                                        print('i am in checkout');

                                                        if (res['status'].toString() == '0') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Checkout(
                                                                      product: products,
                                                                      agent: agentinfo,
                                                                      customer: customerinfo,
                                                                      order_id: Id,
                                                                      date: date,
                                                                      reffid: refid,
                                                                      recomenid: id)));
                                                        } else {
                                                          orderid = res['order']!['id'].toString();
                                                          refid = res['ref_id'].toString();
                                                          print('orderid..........${orderid}');
                                                          await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                insetPadding: EdgeInsets.symmetric(
                                                                    horizontal: 32, vertical: 64),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                elevation: 16,
                                                                child: Container(
                                                                  padding: EdgeInsets.all(20),
                                                                  // height:200.0,
                                                                  // width: 400.0,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      // Row(
                                                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                                                      //   children: [
                                                                      //
                                                                      //   ],
                                                                      // ),
                                                                      // Icon(
                                                                      //   Icons.check_circle_outline,
                                                                      //   color: Colors.black,
                                                                      // ),
                                                                      // SizedBox(height: 20),
                                                                      // GestureDetector(
                                                                      //   onTap: (){
                                                                      //     Navigator.pop(context);
                                                                      //   },
                                                                      //   child: Align(
                                                                      //     alignment: Alignment.topRight,
                                                                      //     child: Icon(
                                                                      //       Icons.close,
                                                                      //       color: Colors.black,
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'Thank You!',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                              fontFamily: 'regular',
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'The purchase is already made for this',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'recommendation ID:${orderid}',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      Center(
                                                                        child: Text(
                                                                          'Code:${refid}',
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 15,
                                                                            fontFamily: 'regular',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      vSizedBox,
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    ManageOrdersPage(
                                                                                      orderData:
                                                                                      res['data'] ?? {},
                                                                                      orderid: orderid
                                                                                          .toString(),
                                                                                    )),
                                                                          );
                                                                        },
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsets.symmetric(
                                                                              horizontal: 25.0),
                                                                          child: Text('Ok'),
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                          shape: StadiumBorder(),
                                                                          primary: MyColors.primaryColor,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }

                                                        //res['status']==0  => checkout
                                                        //Detail page
                                                      }
                                                    }

                                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout()));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )


                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      // Navigator.pushNamed(context, SignInPage.id);

                      boderRadius: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: RoundEdgedButton(
                      textColor: MyColors.whiteColor,
                      color: Color(0xFF00b7ff),
                      text: 'Iniciar sesión',
                      // textColor: MyColors.whiteColor,
                      // color: Color(0xFF13b8e8),
                      boderRadius: 10,
                      onTap: () {
                        Navigator.pushNamed(context, SignInPage.id);
                      },
                    ),
                  ),
                  vSizedBox,
                ],
              )),
          // Container(
          //   child: Column(
          //     children: [
          //
          //
          //
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
  page2() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 70,
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 40),
                child: Image.asset(MyImages.welcomeScreen2),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MainHeadingText(
                  text: 'Su pedido asegurado',
                  color: MyColors.primaryColor,
                  textAlign: TextAlign.center,
                  fontSize: 26,
                  fontFamily: 'bold',
                  height: 1.4,
                ),
              ),
              vSizedBox,
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ParagraphText(
                  text: translate(
                      "Winao garantiza que  el  producto  \n llegue  a sus manos  con el   \n seguimiento de su pedido"),

                  color: MyColors.welcomescreensubtextcolor,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontFamily:'Roboto',
                  // fontWeight:FontWeight.w300 ,
                  height: 1.5,


                ),
              ),
              vSizedBox4,
            ],
          )),
          Expanded(
            flex: 30,
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundEdgedButton(
                  isSolid: true,
                  text: 'Comenzar con código',
                  textColor: MyColors.whiteColor,
                  color: Color(0xFF00b7ff),

                  onTap: () {
                    showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
                      ),
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {

                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // height:300,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),

                                ),

                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        // height:300,
                                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            MainHeadingText(
                                              text: 'Ingresa tu codigo de recomendación',
                                              color: Color(0xFF5b5b5b),
                                              textAlign: TextAlign.center,
                                              fontSize: 18,
                                              // fontFamily: 'semibold',
                                            ),
                                            vSizedBox2,
                                            CustomTextField(
                                              controller: codeController,
                                              hintText: 'PQR12345',
                                              textcolor: Color(0xFF828282),
                                              textAlign: TextAlign.center,
                                              borderColor: Color(0xFFd2d2d2),
                                            ),
                                            RoundEdgedButtonred(
                                              text: 'Ver los productos',
                                              color: Color(0xFF00a1e4),
                                              onTap: () async {
                                                print("data");
                                                if (codeController.text == '') {
                                                  showSnackbar(context, 'Please Enter your code.');
                                                  print("i am in ifftjfj");
                                                } else {
                                                  print("gsghghshg");
                                                  loadingShow(context);
                                                  print("gsgh");
                                                  var res1 = await Webservices.getData(
                                                      ApiUrls.getrecommend_bycode +
                                                          '?code=${codeController.text}');
                                                  var jsonResponse = convert.jsonDecode(res1.body);
                                                  log('Apiresponse................867.${jsonResponse['status']}');

                                                  var res = jsonResponse['data'];
                                                  // loadingHide(context);
                                                  //  print("Appiresponse"+res.body);
                                                  //  print('Apiresponse----$res');
                                                  //
                                                  // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
                                                  log('Apiresponse.................889.$res');
                                                  loadingHide(context);

                                                  if (jsonResponse['status'].toString() == '0') {
                                                    print('Invalid  code');
                                                    showSnackbar(context, 'Invalid code.');
                                                  } else if (jsonResponse['status'].toString() == '1') {
                                                    agentinfo = res['agent_info'];
                                                    customerinfo = res['customer_info'];
                                                    print('recomenid..${res['id']}');
                                                    id = res['id'];
                                                    print('Agentinfo..$agentinfo');
                                                    print('ref_id..${res['ref_id']}');
                                                    refid = res['ref_id'];
                                                    print('orderinfo..$Id');
                                                    date = res['created_at'];
                                                    print('orderinfo..$date');
                                                    products = res['products'];
                                                    print('products..$products');
                                                    print('status..........${res['status']}');
                                                    print('i am in checkout');

                                                    if (res['status'].toString() == '0') {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => Checkout(
                                                                  product: products,
                                                                  agent: agentinfo,
                                                                  customer: customerinfo,
                                                                  order_id: Id,
                                                                  date: date,
                                                                  reffid: refid,
                                                                  recomenid: id)));
                                                    } else {
                                                      orderid = res['order']!['id'].toString();
                                                      refid = res['ref_id'].toString();
                                                      print('orderid..........${orderid}');
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            insetPadding: EdgeInsets.symmetric(
                                                                horizontal: 32, vertical: 64),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(0)),
                                                            elevation: 16,
                                                            child: Container(
                                                              padding: EdgeInsets.all(20),
                                                              // height:200.0,
                                                              // width: 400.0,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  // Row(
                                                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                                                  //   children: [
                                                                  //
                                                                  //   ],
                                                                  // ),
                                                                  // Icon(
                                                                  //   Icons.check_circle_outline,
                                                                  //   color: Colors.black,
                                                                  // ),
                                                                  // SizedBox(height: 20),
                                                                  // GestureDetector(
                                                                  //   onTap: (){
                                                                  //     Navigator.pop(context);
                                                                  //   },
                                                                  //   child: Align(
                                                                  //     alignment: Alignment.topRight,
                                                                  //     child: Icon(
                                                                  //       Icons.close,
                                                                  //       color: Colors.black,
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                  vSizedBox,
                                                                  Center(
                                                                    child: Text(
                                                                      'Thank You!',
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 20,
                                                                          fontFamily: 'regular',
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  vSizedBox,
                                                                  Center(
                                                                    child: Text(
                                                                      'The purchase is already made for this',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 15,
                                                                        fontFamily: 'regular',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // vSizedBox,
                                                                  Center(
                                                                    child: Text(
                                                                      'recommendation ID:${orderid}',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 15,
                                                                        fontFamily: 'regular',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  vSizedBox,
                                                                  Center(
                                                                    child: Text(
                                                                      'Code:${refid}',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 15,
                                                                        fontFamily: 'regular',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  vSizedBox,
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ManageOrdersPage(
                                                                                  orderData:
                                                                                  res['data'] ?? {},
                                                                                  orderid: orderid
                                                                                      .toString(),
                                                                                )),
                                                                      );
                                                                    },
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets.symmetric(
                                                                          horizontal: 25.0),
                                                                      child: Text('Ok'),
                                                                    ),
                                                                    style: ElevatedButton.styleFrom(
                                                                      shape: StadiumBorder(),
                                                                      primary: MyColors.primaryColor,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    //res['status']==0  => checkout
                                                    //Detail page
                                                  }
                                                }

                                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout()));
                                              },
                                            ),
                                          ],
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  // Navigator.pushNamed(context, SignInPage.id);

                  boderRadius: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: RoundEdgedButton(
                  textColor: MyColors.whiteColor,
                  color: Color(0xFF00b7ff),
                  text: 'Iniciar sesión',
                  // textColor: MyColors.whiteColor,
                  // color: Color(0xFF13b8e8),
                  boderRadius: 10,
                  onTap: () {
                    Navigator.pushNamed(context, SignInPage.id);
                  },
                ),
              ),
              vSizedBox,
            ],
          )),
          // Padding(
          //   padding: EdgeInsets.only(left: 34,right:34,top: 40,bottom: 0),
          //   child: Container(
          //
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //         image: DecorationImage(
          //             image: AssetImage(MyImages.welcomeScreen0),
          //             fit: BoxFit.fitWidth,
          //             alignment: Alignment.center)),
          //     height: 380,
          //     width: MediaQuery.of(context).size.width,
          //     // width: 100,
          //   ),
          // ),
          // Container(
          //   child: Column(
          //     children: [
          //
          //       vSizedBox4,
          //
          //
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
  // page2() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(10),
  //           child: Container(
  //
  //             decoration: BoxDecoration(
  //               // color: Colors.red,
  //                 image: DecorationImage(
  //                     image: AssetImage(MyImages.welcomeScreen2),
  //                     fit: BoxFit.fitWidth,
  //                     alignment: Alignment.topCenter)),
  //             height: 380,
  //             width: MediaQuery.of(context).size.width,
  //             // width: 100,
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             children: [
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 16),
  //                 child: MainHeadingText(
  //                   text: 'Su pedido asegurado',
  //                   color: MyColors.bul,
  //                   textAlign: TextAlign.center,
  //                   fontSize: 28,
  //                   fontFamily: 'bold',
  //                   height: 1.4,
  //                 ),
  //               ),
  //               vSizedBox4,
  //               ParagraphText(
  //                 text: translate(
  //                     "Winao garantiza que el producto llegue a sus manos con el seguimiento de su pedido"),
  //                 color: MyColors.welcomescreensubtextcolor,
  //                 textAlign: TextAlign.center,
  //                 fontSize: 18,
  //               ),
  //               vSizedBox4,
  //               vSizedBox4,
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: RoundEdgedButton(
  //                   // isSolid: false,
  //
  //                   text: 'Comenzar con código',
  //                   textColor: MyColors.whiteColor,
  //                   color: Color(0xFF13b8e8),
  //
  //                   onTap: () {
  //                     showModalBottomSheet<void>(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
  //                       ),
  //                       backgroundColor: Colors.transparent,
  //                       context: context,
  //                       builder: (BuildContext context) {
  //
  //                         return Scaffold(
  //                           backgroundColor: Colors.transparent,
  //                           body: Column(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //                               Container(
  //                                 // height:300,
  //
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
  //
  //                                 ),
  //
  //                                 child: SingleChildScrollView(
  //                                   child: Column(
  //                                     mainAxisAlignment: MainAxisAlignment.center,
  //                                     // mainAxisSize: MainAxisSize.min,
  //                                     children: <Widget>[
  //                                       Container(
  //                                         // height:300,
  //                                         padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
  //                                         child: Column(
  //                                           crossAxisAlignment: CrossAxisAlignment.center,
  //                                           children: [
  //                                             MainHeadingText(
  //                                               text: 'Ingresa tu codigo de recomendación',
  //                                               color: Color(0xFF5b5b5b),
  //                                               textAlign: TextAlign.center,
  //                                               fontSize: 18,
  //                                               // fontFamily: 'semibold',
  //                                             ),
  //                                             vSizedBox2,
  //                                             CustomTextField(
  //                                               controller: codeController,
  //                                               hintText: 'PQR12345',
  //                                               textcolor: Color(0xFF828282),
  //                                               textAlign: TextAlign.center,
  //                                               borderColor: Color(0xFFd2d2d2),
  //                                             ),
  //                                             RoundEdgedButtonred(
  //                                               text: 'Ver los productos',
  //                                               color: Color(0xFF00a1e4),
  //                                               onTap: () async {
  //                                                 print("data");
  //                                                 if (codeController.text == '') {
  //                                                   showSnackbar(context, 'Please Enter your code.');
  //                                                   print("i am in ifftjfj");
  //                                                 } else {
  //                                                   print("gsghghshg");
  //                                                   loadingShow(context);
  //                                                   print("gsgh");
  //                                                   var res1 = await Webservices.getData(
  //                                                       ApiUrls.getrecommend_bycode +
  //                                                           '?code=${codeController.text}');
  //                                                   var jsonResponse = convert.jsonDecode(res1.body);
  //                                                   log('Apiresponse................867.${jsonResponse['status']}');
  //
  //                                                   var res = jsonResponse['data'];
  //                                                   // loadingHide(context);
  //                                                   //  print("Appiresponse"+res.body);
  //                                                   //  print('Apiresponse----$res');
  //                                                   //
  //                                                   // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
  //                                                   log('Apiresponse.................889.$res');
  //                                                   loadingHide(context);
  //
  //                                                   if (jsonResponse['status'].toString() == '0') {
  //                                                     print('Invalid  code');
  //                                                     showSnackbar(context, 'Invalid code.');
  //                                                   } else if (jsonResponse['status'].toString() == '1') {
  //                                                     agentinfo = res['agent_info'];
  //                                                     customerinfo = res['customer_info'];
  //                                                     print('recomenid..${res['id']}');
  //                                                     id = res['id'];
  //                                                     print('Agentinfo..$agentinfo');
  //                                                     print('ref_id..${res['ref_id']}');
  //                                                     refid = res['ref_id'];
  //                                                     print('orderinfo..$Id');
  //                                                     date = res['created_at'];
  //                                                     print('orderinfo..$date');
  //                                                     products = res['products'];
  //                                                     print('products..$products');
  //                                                     print('status..........${res['status']}');
  //                                                     print('i am in checkout');
  //
  //                                                     if (res['status'].toString() == '0') {
  //                                                       Navigator.push(
  //                                                           context,
  //                                                           MaterialPageRoute(
  //                                                               builder: (context) => Checkout(
  //                                                                   product: products,
  //                                                                   agent: agentinfo,
  //                                                                   customer: customerinfo,
  //                                                                   order_id: Id,
  //                                                                   date: date,
  //                                                                   reffid: refid,
  //                                                                   recomenid: id)));
  //                                                     } else {
  //                                                       orderid = res['order']!['id'].toString();
  //                                                       refid = res['ref_id'].toString();
  //                                                       print('orderid..........${orderid}');
  //                                                       await showDialog(
  //                                                         context: context,
  //                                                         builder: (context) {
  //                                                           return Dialog(
  //                                                             insetPadding: EdgeInsets.symmetric(
  //                                                                 horizontal: 32, vertical: 64),
  //                                                             shape: RoundedRectangleBorder(
  //                                                                 borderRadius: BorderRadius.circular(0)),
  //                                                             elevation: 16,
  //                                                             child: Container(
  //                                                               padding: EdgeInsets.all(20),
  //                                                               // height:200.0,
  //                                                               // width: 400.0,
  //                                                               child: Column(
  //                                                                 mainAxisSize: MainAxisSize.min,
  //                                                                 children: <Widget>[
  //                                                                   // Row(
  //                                                                   //   mainAxisAlignment: MainAxisAlignment.end,
  //                                                                   //   children: [
  //                                                                   //
  //                                                                   //   ],
  //                                                                   // ),
  //                                                                   // Icon(
  //                                                                   //   Icons.check_circle_outline,
  //                                                                   //   color: Colors.black,
  //                                                                   // ),
  //                                                                   // SizedBox(height: 20),
  //                                                                   // GestureDetector(
  //                                                                   //   onTap: (){
  //                                                                   //     Navigator.pop(context);
  //                                                                   //   },
  //                                                                   //   child: Align(
  //                                                                   //     alignment: Alignment.topRight,
  //                                                                   //     child: Icon(
  //                                                                   //       Icons.close,
  //                                                                   //       color: Colors.black,
  //                                                                   //     ),
  //                                                                   //   ),
  //                                                                   // ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'Thank You!',
  //                                                                       style: TextStyle(
  //                                                                           color: Colors.black,
  //                                                                           fontSize: 20,
  //                                                                           fontFamily: 'regular',
  //                                                                           fontWeight: FontWeight.bold),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'The purchase is already made for this',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   // vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'recommendation ID:${orderid}',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   Center(
  //                                                                     child: Text(
  //                                                                       'Code:${refid}',
  //                                                                       style: TextStyle(
  //                                                                         color: Colors.black,
  //                                                                         fontSize: 15,
  //                                                                         fontFamily: 'regular',
  //                                                                       ),
  //                                                                     ),
  //                                                                   ),
  //                                                                   vSizedBox,
  //                                                                   ElevatedButton(
  //                                                                     onPressed: () {
  //                                                                       Navigator.pop(context);
  //                                                                       Navigator.push(
  //                                                                         context,
  //                                                                         MaterialPageRoute(
  //                                                                             builder: (context) =>
  //                                                                                 ManageOrdersPage(
  //                                                                                   orderData:
  //                                                                                   res['data'] ?? {},
  //                                                                                   orderid: orderid
  //                                                                                       .toString(),
  //                                                                                 )),
  //                                                                       );
  //                                                                     },
  //                                                                     child: Padding(
  //                                                                       padding:
  //                                                                       const EdgeInsets.symmetric(
  //                                                                           horizontal: 25.0),
  //                                                                       child: Text('Ok'),
  //                                                                     ),
  //                                                                     style: ElevatedButton.styleFrom(
  //                                                                       shape: StadiumBorder(),
  //                                                                       primary: MyColors.primaryColor,
  //                                                                     ),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                             ),
  //                                                           );
  //                                                         },
  //                                                       );
  //                                                     }
  //
  //                                                     //res['status']==0  => checkout
  //                                                     //Detail page
  //                                                   }
  //                                                 }
  //
  //                                                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout()));
  //                                               },
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       )
  //
  //
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   // Navigator.pushNamed(context, SignInPage.id);
  //
  //                   boderRadius: 10,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //
  //                 child: RoundEdgedButton(
  //                   isSolid: false,
  //                   text: 'Iniciar sesión',
  //                   textColor: MyColors.whiteColor,
  //                   color: Color(0xFF13b8e8),
  //                   boderRadius: 10,
  //                   onTap: () {
  //                     Navigator.pushNamed(context, SignInPage.id);
  //                   },
  //                 ),
  //               ),
  //               vSizedBox,
  //
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                itemCount: 3,
                controller: controller,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return page0();
                    case 1:
                      return page1();
                    case 2:
                      return page2();
                    default:
                      return page0();
                  }
                },
              ),
              Positioned(
                bottom:MediaQuery.of(context).size.height*(30/100),
                // alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: controller, // PageController
                    count: 3,
                    effect: WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 15,
                        // activeDotColor: Colors.white,
                        // dotColor: Colors.white30
                        activeDotColor: MyColors.bul,
                        dotColor: MyColors
                            .welcomescreensubtextcolor), // your preferred effect
                    onDotClicked: (index) {}),
              ),
              // Positioned(
              //   bottom: 20,
              //   right: 32,
              //   child: GestureDetector(
              //     onTap: (){
              //       // Navigator.pushNamed(context, LoginPage.id);
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: MyColors.primaryColor,
              //           borderRadius: BorderRadius.circular(12)
              //       ),
              //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //       child: Icon(Icons.arrow_forward, color: Colors.white,),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
