import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

class Referral_code extends StatefulWidget {
  static const String id = 'refferal_code';
  const Referral_code({Key? key}) : super(key: key);

  @override
  _Referral_codeState createState() => _Referral_codeState();
}

class _Referral_codeState extends State<Referral_code> {
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          vSizedBox2,
          Image.asset(MyImages.referral),
          vSizedBox2,
          MainHeadingText(
            text: 'Enter Referral Code',
            color: MyColors.primaryColor,
            textAlign: TextAlign.center,
            fontSize: 24,
            fontFamily: 'semibold',
          ),
          vSizedBox2,
          ParagraphText(
            text: 'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit',
            color: MyColors.blackColor,
            textAlign: TextAlign.center,
            fontSize: 16,
            fontFamily: 'regular',
          ),
          vSizedBox4,
          CustomTextField(controller: codeController, hintText: 'PQR12345',textAlign: TextAlign.center,),

          RoundEdgedButtonred(text:'Enter', color: MyColors.primaryColor,
            onTap: (){
              Navigator.pushNamed(context, SignInPage.id);
            },
          ),
          TextButton(
              onPressed: (){
                // Navigator.pushNamed(context, SignInPage.id);
              },
              child: Text('Skip', style: TextStyle(
                color: Color(0xFFA7A7A7),
                fontSize: 18,
                height: 0
              ),
              )
          )

        ],
      ),
    ),
    );
  }
}
