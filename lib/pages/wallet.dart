import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/checkout.dart';
// import 'package:winao_client_app/pages/withdrawamount.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';
import 'package:winao_client_app/widgets/side_drawer.dart';

import 'notification.dart';

class WalletPage extends StatefulWidget {
  static const String id="wallet";
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: SideDrawer(scaffoldKey: scaffoldKey,),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('WINAO', style: TextStyle(fontSize: 16, fontFamily: 'bold', letterSpacing: 1),),
        actions: [
          // Icon(Icons.favorite),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, WalletPage.id);
            },
            icon: Image.asset(MyImages.wallet, height: 25,),
          ),
          IconButton(

            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.pushNamed(context, Checkout.id);
            },
            icon: Image.asset(MyImages.cart, height: 25,),
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, NotificationPage.id);
            },
            icon: Image.asset(MyImages.notification, height: 25,),
          ),
        ],
        backgroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 110,
              padding: EdgeInsets.only(left: 24, top: 0, right: 24),
              margin: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Color(0xFFE5E6FF)
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 24, bottom: 10, left: 16, right: 16),
                          child: Text(
                            'Wallet Balance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Poppins-Medium'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 16, right: 16),
                          child: Text(
                            "\$1200.00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontFamily: 'bold',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                          top: 20, bottom: 0, left: 40, right: 40),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(100)
                            ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text('Withdraw Amount', style: TextStyle(color: Colors.white, fontFamily: 'bold', fontSize: 14),)
                             ],
                           ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
                child: MainHeadingText(text: 'Transactions List',textAlign: TextAlign.left, fontSize: 16,color: MyColors.blackColor, fontFamily: 'semibold',)
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFf7f7f7),
                  // border: Border(
                  //     bottom: BorderSide(color: Colors.grey.shade300)
                  // )
              ),
              // margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return GestureDetector(
                          onTap: (){
                            // Navigator.pushNamed(context, RecommandationDetailPage.id);
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(text: '1.', color: MyColors.blackColor, fontFamily: 'bold', fontSize: 15,),
                                      hSizedBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Added to wallet', style: TextStyle(fontSize: 16, fontFamily: 'medium'),),
                                          Text('24 jan 2022 10:00 AM', style: TextStyle(fontSize: 10, color: Color(0xFE7A7A7A), fontFamily: 'regular'),)
                                        ],
                                      ),

                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ParagraphText(text: '+\$100', color: MyColors.greenColor,fontSize: 15, fontFamily: 'semibold',),
                                      Text('Balance: \$1100', style: TextStyle(fontSize: 10, color: Color(0xFE7A7A7A), fontFamily: 'regular'),)
                                    ],
                                  )
                                ],
                              ),
                              vSizedBox2
                              // Divider(height: 20,)
                            ],
                          ),
                      );

                    },
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
