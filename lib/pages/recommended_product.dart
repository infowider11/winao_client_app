import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/pages/detail.dart';
import 'package:winao_client_app/pages/notification.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/side_drawer.dart';
import 'package:winao_client_app/widgets/vertical_card.dart';

class RecommendedProduct extends StatefulWidget {
  static const String id="recommendedproduct";
  const RecommendedProduct({Key? key}) : super(key: key);

  @override
  _RecommendedProductState createState() => _RecommendedProductState();
}

class _RecommendedProductState extends State<RecommendedProduct> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: SideDrawer(scaffoldKey: scaffoldKey,),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('WINAO', style: TextStyle(fontSize: 16, fontFamily: 'bold', letterSpacing: 1),),
        actions: [
          // Icon(Icons.favorite),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, NotificationPage.id);
            },
            icon: Image.asset(MyImages.wallet, height: 25,),
          ),
          IconButton(

            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.pushNamed(context, NotificationPage.id);
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Recommended Products', style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index){
                  return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Detail_page.id);
                      },
                      child:  HorizontalcardProduct(addItem: () {  }, data:{}, removeItem: () {  },)
                  );
                },
              ),
                SizedBox(height: 20,)

            ],
          ),
        ),
      ),
    );
  }
}
