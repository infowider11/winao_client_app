import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/billing.dart';
import 'package:winao_client_app/pages/home_without_login.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

class Thankyou extends StatefulWidget {
  static const String id="thankyou";
  const Thankyou({Key? key}) : super(key: key);

  @override
  _ThankyouState createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(15),

              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSizedBox4,
                  Image.asset('assets/images/right.png', height: 45,),
                  vSizedBox2,
                  MainHeadingText(text: 'Thank You!', fontSize: 30, fontFamily: 'bold',),
                  vSizedBox2,
                  Image.asset('assets/images/thank_border.png', height: 45,),
                  vSizedBox2,
                  MainHeadingText(
                    text: 'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore',
                    fontSize: 14, fontFamily: 'regular',textAlign: TextAlign.center,),
                    vSizedBox4,
                    vSizedBox4,
                    vSizedBox4,
                  Borderbutton(text: 'Home', onTap: (){
                    Navigator.pushNamed(context, HomeWithoutLogin.id);
                  },),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
