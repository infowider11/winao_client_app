import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';


import 'checkout.dart';
import 'manageorder.dart';
import 'dart:convert' as convert;

class SignInPage extends StatefulWidget {
  static const String id = "Signin";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}
final firebaseAuth = FirebaseAuth.instance;
final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
class _SignInPageState extends State<SignInPage> {

  List products = [];
  Map orderinfo = {};
  String? Id;
  String? orderid;
  String? date;
  String? refid;
  String? id;
  bool ef=false;
  bool ps=false;
  bool isObscure=true;
  bool isChecked=true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  updatedevice() async {
    Map<String, dynamic> data = {
      'user_id': await getCurrentUserId(),
      'device_id': await FirebasePushNotifications.getToken(),
    };
    print('updatedevicedata----${data}');

    loadingShow(context);
    var res = await Webservices.postData(
        apiUrl: ApiUrls.updatedeviceid,
        body: data,
        context: context,
        showSuccessMessage: true);
    print('update device token----${res}');
    loadingHide(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Comment this code
    // codeController.text = 'R67659';
    return Scaffold(
        backgroundColor: Color(0xFF004173),
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(

            children: [
              Container(
                // height: ,
                // width:250,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                // decoration: BoxDecoration(
                //   color: Color(0xFF004173),
                //   image: DecorationImage(
                //     image:
                //     AssetImage(
                //      'assets/images/logo-1..png',
                //
                //
                //     ),
                //     // fit: BoxFit.cover,
                //     alignment: Alignment(0, 0.5),
                //   ),
                // ),
                child: Column(
                  children: [
                    vSizedBox,
                    Image.asset('assets/images/logo-1..png'),
                    // Padding(padding: EdgeInsets.only(top: 190)),
                    vSizedBox,
                    MainHeadingText(
                      text: '¡Bienvenido!',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      fontFamily: 'semibold',
                    ),
                    vSizedBox,
                    ParagraphText(
                      text: 'Ingresa con tu login',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontFamily: 'regular',
                    ),
                    vSizedBox4,
                    // TextField(
                    //   style: TextStyle(color: Colors.white),
                    //
                    //   onChanged: (value) {},
                    //   controller: emailController,
                    //   // decoration: InputDecoration(hintText: "Email:",
                    //   //   hintStyle: TextStyle(color: Colors.white),
                    //   //
                    //   //   focusColor: Colors.white,
                    //   //   enabledBorder: UnderlineInputBorder(
                    //   //     borderSide: BorderSide(color: Colors.white),//<-- SEE HERE
                    //   //   ),
                    //   //   focusedBorder: UnderlineInputBorder(
                    //   //     borderSide: BorderSide(color: Colors.white),//<-- SEE HERE
                    //   //   ),
                    //   // ),
                    //
                    // ),
                    // vSizedBox2,
                    // TextField(
                    //   style: TextStyle(color: Colors.white),
                    //   onChanged: (value) {},
                    //   controller: passwordController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(hintText: "Contraseña:",
                    //   // hoverColor:Colors.white,
                    //     hintStyle: TextStyle(color: Colors.white),
                    //     focusColor: Colors.white,
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.white),//<-- SEE HERE
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.white),//<-- SEE HERE
                    //     ),
                    //   ),
                    // ),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      textcolor:Color(0xFF636363),
                      // prefixIcon: 'assets/images/user.png',
                      borderradius: 10,
                      borderColor: ef?Color(0xFF00b7ff):MyColors.primaryColor,
                      onTap: (){
                        ef=true;
                        ps=false;
                        setState(() {

                        });
                      },

                    ),
                    // vSizedBox,
                    CustomTextField(
                      obscureText: isObscure,
                      controller: passwordController,
                      hintText: 'Contraseña',
                      textcolor:Color(0xFF636363),
                      suffixIcon: isObscure?'assets/images/view.png':'assets/images/hidden.png',
                      borderradius: 10,
                      borderColor: ps?Color(0xFF00b7ff):MyColors.primaryColor,
                      onTap: (){
                        ef=false;
                        ps=true;
                        setState(() {

                        });

                      },
                        suffixAction:()async{
                          isObscure=!isObscure;
                          setState(() {

                          });
                        }
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:25,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Checkbox(value: isChecked, onChanged: (d)async{
                                      isChecked=!isChecked;
                                      setState(() {

                                      });
                                    },activeColor: Color(0xFF00b7ff),

                                      ),
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Keep me logged in',style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Forgotpassword.id);
                              },
                              child: Text(
                                'Olvidó su contraseña?',
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                    RoundEdgedButton(
                      text: 'Iniciar sesión',
                      textColor: Colors.white,
                      isSolid: true,
                      color: Color(0xFF00b7ff),
                      boderRadius: 10,

                      onTap: () async {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (emailController.text == '') {
                          showSnackbar(context, 'Please Enter your Email.');
                        } else if (!regex.hasMatch(emailController.text)) {
                          showSnackbar(
                              context, 'Please Enter your valid email.');
                        } else if (passwordController.text == '') {
                          showSnackbar(context, 'Please Enter your Password.');
                        } else {
                          Map<String, dynamic> data = {
                            'email': emailController.text,
                            'password': passwordController.text,
                            'user_type': '3'
                          };
                          loadingShow(context);
                          var res = await Webservices.postData(
                              apiUrl: ApiUrls.login,
                              body: data,
                              context: context,
                              showSuccessMessage: true);
                          loadingHide(context);
                          print("Api response" + res.toString());
                          if (res['status'].toString() == '1') {
                            updateUserDetails(res['data']);
                            updatedevice();

                            Navigator.pushNamed(context, MyStatefulWidget.id);
                            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            //     MyStatefulWidget(key: MyGlobalKeys.tabBarKey,)), (Route<dynamic> route) => false);
                          }
                        }
                        // Navigator.pushNamed(context, MyStatefulWidget.id);
                      },
                    ),
                    vSizedBox,


                    // Column(
                    //   children: [
                    //     GestureDetector(
                    //       onTap:_signInWithGoogle,
                    //       child: Container(
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(
                    //               color: MyColors.greyish,
                    //               style: BorderStyle.solid,
                    //               width: 1.0,
                    //             ),
                    //             color: MyColors.whitelight,
                    //             // border: Border.all(color: MyColors.primaryColor),
                    //             // border: Border,
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Padding(
                    //           padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                    //           child: Row(
                    //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Image.asset('assets/images/google.png',width: 20,height: 20,),
                    //               hSizedBox6,
                    //               Text('Continuar con Google')
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     vSizedBox,
                    //     GestureDetector(
                    //       onTap: ()async{
                    //
                    //         print("FaceBook");
                    //         // try {
                    //         //   final result =
                    //         //   await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
                    //         //   print("result-------------$result");
                    //         //
                    //         //   if (result.status == LoginStatus.success) {
                    //         //     final userData = await FacebookAuth.i.getUserData();
                    //         //     print("+userData+userData4+$userData");
                    //         //   }
                    //         // } catch (error) {
                    //         //   print(error);
                    //         // }
                    //         //
                    //
                    //
                    //       },
                    //       child: Container(
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(
                    //               color: MyColors.greyish,
                    //               style: BorderStyle.solid,
                    //               width: 1.0,
                    //             ),
                    //             color: MyColors.whitelight,
                    //             // border: Border.all(color: MyColors.primaryColor),
                    //             // border: Border,
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Padding(
                    //           padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                    //           child: Row(
                    //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Image.asset('assets/images/facebook.png',width: 20,height: 20,),
                    //               hSizedBox6,
                    //               Text('Continuar con Facebook')
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
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
                      text: 'O ingresa con tu codigo',
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      // fontFamily: 'semibold',
                    ),
                    vSizedBox2,
                    CustomTextField(

                      controller: codeController,
                      hintText: 'PQR12345',
                      textAlign: TextAlign.center,
                      borderradius: 10,
                      textcolor: Color(0xff636363).withOpacity(0.40),
                    ),
                    RoundEdgedButton(
                      boderRadius: 10,
                      textColor: Colors.white,
                      isSolid: true,
                      color: Color(0xFF00b7ff),
                      text: 'Enter',

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
      ],
    ));
  }
  addUserToFirebase(Map data) async{
    DocumentReference documentReferencer =
    _userCollection.doc();
    QuerySnapshot user  =await _userCollection.where("email", isEqualTo: data['email']).get();
    print('the user is ${user.docs.length}');

    print(user);
    if(user.docs.length==0){
      print("12345--------------------");
      await documentReferencer
          .set(data)
          .whenComplete(() => print("Notes item added to the database"))
          .catchError((e) => print(e));
    }
    print('user added');
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));

  }
  void _signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    print('signing in.............. $googleAccount');
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
      await googleAccount.authentication;
      final authResult = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );
      // return _userFromFirebase(authResult.user);
      print('the user data is ${authResult.user}');
      Map<String, dynamic> data = {
        'uid': authResult.user?.uid,
        'name':authResult.user?.displayName,
        'email':authResult.user?.email,
      };
      print(data);
      addUserToFirebase(data);
      var res = await Webservices.postData(apiUrl: ApiUrls.socialLoginCheck, body: {"email":authResult.user?.email}, context: context);
      log("res from google login----------$res");
      // if(res['status'].toString()=='0'){
      //   showSnackbar(context, res['message']);
      // }
      // else if(res['status'].toString()=='1'){
      //   updateUserDetails(res['data']);
      //   if(res['data']['user_type'].toString()=="1"){
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (BuildContext context) => Sup_bottom_nav(key: MyGlobalKeys.tabBarKey2)),
      //         ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
      //     );
      //   }
      //   else if(res['data']['user_type'].toString()=="2"){
      //     Navigator.pushNamedAndRemoveUntil(context, MyStatefulWidget.id, (route) => false);
      //   }
      // }
      // else if(res['status'].toString()=='2'){
      //   push(context: context, screen: Choostype(data:data));
      //   // Navigator.pushNamed(context, Choostype.id);
      //
      // }


    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong happened!!')));
    }
  }
}
