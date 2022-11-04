import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
static const String id="signup";
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        body:  ListView(
          children: [
            Container(
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
                      text: 'Sign up',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      fontFamily: 'semibold',
                    ),
                    vSizedBox,
                    ParagraphText(
                      text: 'Create your account!',
                      color: MyColors.whiteColor,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontFamily: 'regular',
                    ),
                    vSizedBox4,
                    CustomTextField(controller: codeController, hintText: 'John Doe', prefixIcon: 'assets/images/user.png',),
                    CustomTextField(controller: codeController, hintText: 'Email', prefixIcon: 'assets/images/email.png',),
                    // vSizedBox,
                    CustomTextField(controller: codeController, hintText: 'Mobile Number', prefixIcon: 'assets/images/call.png',),
                    CustomTextField(controller: codeController, hintText: 'Whatsap Number', prefixIcon: 'assets/images/dashicons_whatsapp.png',),
                    CustomTextField(controller: codeController, hintText: 'Password', prefixIcon: 'assets/images/key.png',),
                    CustomTextField(controller: codeController, hintText: 'Confirm Password', prefixIcon: 'assets/images/key.png',),
                    vSizedBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: RoundEdgedButton(text: 'Sign In',
                        onTap: (){
                          // Navigator.pushNamed(context, SignInPage.id);
                        },
                      ),
                    ),
                   ],
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('Already have an account?  ', style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, SignInPage.id);
                    },
                    child:Text('Sign in', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'semibold'
                    ),
                    ),
                  )


                ],
              ),
            )
          ],
        )


    );

  }
}
