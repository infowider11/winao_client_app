import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/bottomnavigation.dart';
import 'package:winao_client_app/pages/forgot_password.dart';
import 'package:winao_client_app/pages/home.dart';
import 'package:winao_client_app/pages/home_without_login.dart';
import 'package:winao_client_app/pages/signup.dart';
import 'package:winao_client_app/services/firebasesetup.dart';
import 'package:winao_client_app/services/webservices.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../constants/global_costants.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
import 'package:http/http.dart' as http;

import 'checkout.dart';
import 'manageorder.dart';
import 'dart:convert' as convert;


class SignInPage extends StatefulWidget {
  static const String id="Signin";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
 List products = [];
 Map orderinfo={};
 String? Id;
 String? orderid;
 String? date;
 String? refid;
 String? id;
 TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  updatedevice()async{
    Map<String, dynamic> data = {
      'user_id':await getCurrentUserId(),
      'device_id':await FirebasePushNotifications.getToken(),
    };
    print('updatedevicedata----${data}');

    loadingShow(context);
    var res = await Webservices.postData(apiUrl: ApiUrls.updatedeviceid,
        body: data, context: context,showSuccessMessage: true);
    print('update device token----${res}');
    loadingHide(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: Comment this code
    // codeController.text = 'R67659';
    return Scaffold(
      // backgroundColor: MyColors.primaryColor,
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: ,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  decoration: BoxDecoration(
                      color: MyColors.signinback,
                      image: DecorationImage(
                          image: AssetImage(MyImages.signin),
                          fit: BoxFit.contain,
                          alignment: Alignment(0, -1.1),
                      ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 190)
                      ),
                      vSizedBox4,
                      MainHeadingText(
                        text: 'Welcome!',
                        color: MyColors.signintextcolor,
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        fontFamily: 'semibold',
                      ),
                      vSizedBox,
                      ParagraphText(
                        text: 'Login into your account!',
                        color: MyColors.signintextcolor,
                        textAlign: TextAlign.center,
                        fontSize: 16,
                        fontFamily: 'regular',
                      ),
                      vSizedBox4,
                      CustomTextField(
                        controller: emailController,
                        hintText: 'John Doe',
                        prefixIcon: 'assets/images/user.png',),
                      // vSizedBox,
                      CustomTextField(
                        obscureText: true,
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: 'assets/images/key.png',),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Forgotpassword.id);
                                },
                                child: Text('Forgot Password?', style: TextStyle(color: MyColors.signintextcolor, fontSize: 14),)
                            )
                          ],
                        ),
                      ),
                      RoundEdgedButton(text: 'Sign In',
                        textColor: MyColors.signintextcolor,
                        // isSolid: false,
                        // color: MyColors.signintextcolor,


                        onTap: () async {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (emailController.text == '') {
                            showSnackbar(context, 'Please Enter your Email.');
                          }
                          else if (!regex.hasMatch(emailController.text)) {
                            showSnackbar(context, 'Please Enter your valid email.');
                          }
                          else if (passwordController.text == '') {
                            showSnackbar(context, 'Please Enter your Password.');
                          }
                          else {
                            Map<String, dynamic> data = {
                              'email':emailController.text,
                              'password':passwordController.text,
                              'user_type':'3'
                            };
                            loadingShow(context);
                            var res = await Webservices.postData(apiUrl: ApiUrls.login,
                                body: data, context: context,showSuccessMessage: true);
                            loadingHide(context);
                            print("Api response"+res.toString());
                            if(res['status'].toString()=='1'){
                              updateUserDetails(res['data']);
                              updatedevice();
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              //     MyStatefulWidget(key: MyGlobalKeys.tabBarKey,)), (Route<dynamic> route) => false);
                              Navigator.pushNamed(context, MyStatefulWidget.id);
                            }
                          }
                          // Navigator.pushNamed(context, MyStatefulWidget.id);
                        },
                      ),
                      vSizedBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //
                      //   children: [
                      //     Text('New User? ', style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 14,
                      //     ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: (){
                      //         Navigator.pushNamed(context, Signup.id);
                      //       },
                      //       child:Text('Sign up', style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 14,
                      //           fontFamily: 'semibold'
                      //       ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainHeadingText(
                        text: 'Enter Recommended Code',
                        color: MyColors.blackColor,
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        fontFamily: 'semibold',
                      ),
                      vSizedBox2,
                      CustomTextField(controller: codeController, hintText: 'PQR12345',textAlign: TextAlign.center,),

                      RoundEdgedButtonred(text:'Enter', color: MyColors.signinback,
                        onTap: () async {
                        print("data");
                        if (codeController.text == '') {
                            showSnackbar(context, 'Please Enter your code.');
                            print("i am in ifftjfj");
                          }
                          else {
                            print("gsghghshg");
                            loadingShow(context);
                            print("gsgh");
                           var res1 = await Webservices.getData(ApiUrls.getrecommend_bycode+'?code=${codeController.text}');
                            var jsonResponse = convert.jsonDecode(res1.body);
                            log('Apiresponse................867.${jsonResponse['status']}');

                            var res=jsonResponse['data'];
                            // loadingHide(context);
                           //  print("Appiresponse"+res.body);
                           //  print('Apiresponse----$res');
                           //
                           // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
                           log('Apiresponse.................889.$res');
                           loadingHide(context);

                            if(jsonResponse['status'].toString() == '0'){
                              print('Invalid  code');
                              showSnackbar(context, 'Invalid code.');
                            }
                            else if(jsonResponse['status'].toString() == '1'){
                              agentinfo=res['agent_info'];
                              customerinfo=res['customer_info'];
                              print('recomenid..${res['id']}');
                              id=res['id'];
                              print('Agentinfo..$agentinfo');
                              print('ref_id..${res['ref_id']}');
                              refid=res['ref_id'];
                              print('orderinfo..$Id');
                              date=res['created_at'];
                              print('orderinfo..$date');
                              products=res['products'];
                              print('products..$products');
                              print('status..........${res['status']}');
                              print('i am in checkout');

                           if(res['status'].toString() == '0'){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:Id ,date:date,reffid:refid,recomenid:id)));
                           }
                           else{


                             orderid=res['order']!['id'].toString();
                             refid=res['ref_id'].toString();
                             print('orderid..........${orderid}');
                             await showDialog(
                               context: context,

                               builder: (context) {
                                 return Dialog(
                                   insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                                           child: Text('Thank You!',
                                             style:
                                             TextStyle(color: Colors.black, fontSize:20,
                                                 fontFamily: 'regular',fontWeight: FontWeight.bold),),
                                         ),
                                         vSizedBox,
                                         Center(
                                           child: Text('The purchase is already made for this',
                                             style:
                                             TextStyle(color: Colors.black, fontSize:15,
                                               fontFamily: 'regular',),),
                                         ),
                                         // vSizedBox,
                                         Center(
                                           child: Text('recommendation ID:${orderid}',
                                             style:
                                             TextStyle(color: Colors.black, fontSize:15,
                                               fontFamily: 'regular',),),
                                         ),
                                         vSizedBox,
                                         Center(
                                           child: Text('Code:${refid}',
                                             style:
                                             TextStyle(color: Colors.black, fontSize:15,
                                               fontFamily: 'regular',),),
                                         ),
                                         vSizedBox,
                                         ElevatedButton(

                                           onPressed: () {
                                             Navigator.pop(context);
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
                                             );
                                           },
                                           child: Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                             child: Text('Ok'),
                                           ),
                                           style: ElevatedButton.styleFrom(shape:StadiumBorder(),
                                             primary:MyColors.primaryColor,

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
        ],
      )


    );
  }
}



