import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
// import '../services/old_api_provider.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/customtextfield.dart';
import '../widgets/loader.dart';
import '../widgets/round_edged_button.dart';
import '../widgets/showSnackbar.dart';
class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  TextEditingController codeController = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(),
        body:  Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: ,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(MyImages.signin),
                  //     fit: BoxFit.contain,
                  //     alignment: Alignment.topLeft
                  // ),
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 50)
                    ),
                    MainHeadingText(
                      text: 'Need Help Or Support ? Please fill this form \n OR Call us on : 91867464844',
                      color: MyColors.blackColor,
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      // fontFamily: 'bold',
                    ),
                    vSizedBox4,
                    vSizedBox,
                    // Image.asset(MyImages.splashScreen, height: 200,),
                    // Padding(
                    //     padding: EdgeInsets.only(top: 280)
                    // ),
                    // vSizedBox,
                    // ParagraphText(
                    //   text: 'Login into your account!',
                    //   color: MyColors.whiteColor,
                    //   textAlign: TextAlign.center,
                    //   fontSize: 16,
                    //   fontFamily: 'regular',
                    // ),
                    // vSizedBox4,
                    CustomTextField(controller: fullName, hintText: 'Your Full name',

                      // prefixIcon: 'assets/images/user.png',
                    ),
                    CustomTextField(controller: emailController, hintText: 'Email',

                      // prefixIcon: 'assets/images/email.png',
                    ),
                    // vSizedBox,
                    CustomTextField(controller: phone, hintText: 'Phone Number',
                   // keyboardType: TextInputType.number,
                   //    prefixIcon: 'assets/images/call.png',
                    ),
                    CustomTextField(controller: message, hintText: 'Message',
                      // obscureText: true,
                      // prefixIcon: 'assets/icons/gmail.png',
                      ),
                    vSizedBox2,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: RoundEdgedButtonred(text: 'Send Message',
                        color: MyColors.primaryColor,
                        onTap: () async {
                          String phonePattern = r'^(\+?\d{1,4}[\s-])?(?!0+\s+,?$)\d{10}\s*,?$';
                          RegExp pnumber=new RegExp(phonePattern);
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (fullName.text == '') {
                            showSnackbar(context, 'Please Enter your Name.');
                          }
                          else if (emailController.text == '') {
                            showSnackbar(context, 'Please Enter your Email.');
                          } else if (!regex.hasMatch(emailController.text)) {
                            showSnackbar(context,
                                'Please Enter your valid email.');
                          } else if (phone.text == '') {
                            showSnackbar(
                                context, 'Please Enter your phone number.');
                          } else if(!pnumber.hasMatch(phone.text)){
                            showSnackbar(context, 'Please Enter your valid phone Number.');
                          }
                          else if (message.text == '') {
                            showSnackbar(
                                context, 'Please Enter message.');
                          }

                          else {
                            Map<String, dynamic> data = {

                            'full_name':fullName.text,
                            'phone':phone.text,
                            'email':emailController.text,
                            'message':message.text,
                              'user_id':await getCurrentUserId()
                          // 'user_type':user_type
                            };
                            loadingShow(context);
                            var res = await Webservices.postData(
                                apiUrl: ApiUrls.Clientsupport,
                                body: data,
                                context: context,
                                showSuccessMessage: true);
                            loadingHide(context);
                            print("fghsdvfh" + res.toString());
                            if (res['status'].toString() == '1') {
                              Navigator.pop(context);
                            }
                          };


                          // Navigator.pushNamed(context, MyStatefulWidget.id);

                        }),
                    ),
                    // TextButton(
                    //     onPressed: (){
                    //       Navigator.pushNamed(context, Forgotpassword.id);
                    //     },
                    //     child: Text('Forgot Password?', style: TextStyle(color: MyColors.grey, fontSize: 18),)
                    // )

                  ],
                ),
              ),
            ),

          ],
        )


    );
  }
}
