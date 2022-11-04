import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/signup.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
class Forgotpassword extends StatefulWidget {
  static const String id="forgot";
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        body:  Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: ,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.signin),
                      fit: BoxFit.contain,
                      alignment: Alignment.topLeft
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 280)
                    ),
                    vSizedBox4,
                    MainHeadingText(
                      text: 'Forgot Password!',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      fontFamily: 'semibold',
                    ),
                    vSizedBox,
                    ParagraphText(
                      text: 'Don’t worry just enter the email address',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontFamily: 'regular',
                    ),
                    vSizedBox4,
                    CustomTextField(controller: emailController, hintText: 'johndoe@gmail.com', prefixIcon: 'assets/images/email.png',),

                    vSizedBox2,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: RoundEdgedButton(text: 'Send',
                        onTap: () async {
                          // Navigator.pushNamed(context, SignInPage.id);

                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (emailController.text == '') {
                            showSnackbar(context, 'Please Enter your Email.');
                          } else if (!regex.hasMatch(emailController.text)) {
                            showSnackbar(context, 'Please Enter your valid email.');
                          }

                          else {
                            Map<String, dynamic> data = {
                              'email':emailController.text,
                            };
                            loadingShow(context);
                            var res = await Webservices.postData(apiUrl: ApiUrls.forgot_password, body: data, context: context,showSuccessMessage: true);
                            loadingHide(context);
                            print("Api response"+res.toString());
                            if(res['status'].toString()=='1'){
                              Navigator.pop(context);
                            }
                          }

                        },
                      ),
                    ),


                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text('New User? ', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, Signup.id);
                        },
                        child:Text('Sign up', style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'semibold'
                        ),
                        ),
                      )


                    ],
                  ),
                )
            )
          ],
        )


    );
  }
}
