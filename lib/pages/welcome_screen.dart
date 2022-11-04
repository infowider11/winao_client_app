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

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController controller = PageController();


  page0(){
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImages.welcomeScreen0),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter

                )
            ),
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: MainHeadingText(text: 'COMPRAR PRODUTOS RECOMENDADOS',
                    color: MyColors.bul,
                    textAlign: TextAlign.center,
                    fontSize: 28,
                    fontFamily: 'bold',
                    height: 1.4,
                  ),
                ),
                vSizedBox4,
                ParagraphText(
                  text: translate("Recibe las mejores recomendaciones de tus amigos corocidos y famil ares"),
                  color: MyColors.welcomescreensubtextcolor,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                ),
                vSizedBox4,

              ],
            ),
          ),
        )
      ],
    );
  }
  page1(){
    return Stack(
      children: [
        Container(
          // width: 50,
          height: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MyImages.welcomeScreen1),
                fit: BoxFit.cover,

              )
          ),
          // height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          bottom: 100,
          left: 16,
            right: 16,
          child: Container(
            child: Column(
              children: [
                MainHeadingText(text: translate("PAGOS FLEXIBLES Y SEGUROS"),
                  color: MyColors.bul,
                  textAlign: TextAlign.center,
                  fontSize: 28,
                  fontFamily: 'bold',
                  height: 1.4,
                ),
                vSizedBox4,
                ParagraphText(
                    text: translate("Puedes realizer tu pedido usando tarjeta do credito, paypal o mediante deposito a las cuentas de Winao"),
                  color: MyColors.welcomescreensubtextcolor,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                ),
                vSizedBox4,

              ],
            ),
          ),
        )
      ],
    );
  }
  page2(){
    return Stack(
      children: [
       
        Padding(
          padding: EdgeInsets.all(30),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImages.welcomeScreen2),
                  fit: BoxFit.cover,

                )
            ),
            // height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                MainHeadingText(
                text: 'ENTREGAS SEGURAS PAGO ASEGURADO',
                  color: MyColors.bul,
                  textAlign: TextAlign.center,
                  fontSize: 28,
                  fontFamily: 'bold',
                ),
                vSizedBox2,
                ParagraphText(
                  text: translate("Winao garantiza que el producto llegue a sus manos,damos seguimento hasta la recepcion de su pedido"),
                  color: MyColors.welcomescreensubtextcolor,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                  fontFamily: 'regular',
                ),
                vSizedBox2,
                
                RoundEdgedButton(
                  // isSolid: false,

                  text: 'Comenzar',
                  textColor: MyColors.whiteColor,
                  color: MyColors.welcomescreenbuttoncolor,
                onTap: (){
                  Navigator.pushNamed(context, SignInPage.id);
                },
                )

              ],
            ),
          ),
        )
      ],
    );
  }

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
                itemBuilder: (context, index){
                  switch(index){
                    case 0: return page0();
                    case 1: return page1();
                    case 2: return page2();
                    default: return page0();
                  }
                },
              ),
              Positioned(
                bottom: 20,
                // alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: controller,  // PageController
                    count: 3,
                    effect:  WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        // activeDotColor: Colors.white,
                        // dotColor: Colors.white30
                        activeDotColor: MyColors.bul,
                        dotColor: MyColors.welcomescreensubtextcolor

                    ),  // your preferred effect
                    onDotClicked: (index){

                    }
                ) ,
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
