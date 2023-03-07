import 'dart:developer';

import 'package:badges/badges.dart' as Badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/navigation.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/pages/wallet.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';
import 'package:winao_client_app/widgets/winao_ongoing_card.dart';

import '../constants/global_keys.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/newloader.dart';
import 'detail.dart';
import 'manageorder.dart';
import 'notification.dart';

class MyorderPage extends StatefulWidget {
  const MyorderPage({Key? key}) : super(key: key);

  @override
  _MyorderPageState createState() => _MyorderPageState();

}

class _MyorderPageState extends State<MyorderPage> {
  int selectedIndex = 1;


  bool load = false;
  List ongoingData = [];
  List cancelledData = [];
  List purchasedData = [];



  getMyUrgentData()async{
    print('dfklgdsfklgjnkldmgnjl');
    String userId = await getCurrentUserId();
    setState((){
      load=true;
    });
    var data = await Webservices.getMap(ApiUrls.onGoingUrl + '?user_id=$userId');
    ongoingData = data['orders'];
    var data1 = await Webservices.getMap(ApiUrls.cancelledUrl + '?user_id=$userId');
    cancelledData = data1['orders'];
    var data2 = await Webservices.getMap(ApiUrls.purchasedUrl + '?user_id=$userId');
    purchasedData = data2['orders'];
    log('The dattt a is ${ongoingData}');
    log('The dattt a is-----cancelledData------- ${cancelledData}');
    log('The dattt a is-----purchasedData------- ${purchasedData}');
    setState((){
      load=false;
    });
  }



  ongoingScreen({required BuildContext context}){
    return Container(
        // ongoingData.length==0
      margin: EdgeInsets.only(top: 65),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child:load?CustomLoader():ongoingData.length==0?Center(child: ParagraphText(text: 'No Data Found',),): ListView.builder(
        itemCount: ongoingData.length,
        itemBuilder: (context, index){
          return GestureDetector(
              onTap: () async{
                // Navigator.pushNamed(context, Detail_page.id);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:ongoingData[index]['id'].toString(),)),
                );

                getMyUrgentData();

              },
            child: WinaoOngoingCard(ongoingData[index]),
              // child:  Horizontalcardongoing(ongoingData[index])
          );

        },
      ),
    );
  }
  cancelledScreen({required BuildContext context}){
    return Container(

      margin: EdgeInsets.only(top: 65),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child:load?CustomLoader():cancelledData.length==0?Center(child: ParagraphText(text: 'No Data Found',),): ListView.builder(
        itemCount: cancelledData.length,
        itemBuilder: (context, index){
          return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:cancelledData[index]['id'].toString(),)),
                );
                // Navigator.pushNamed(context, Detail_page.id);
              },
            child: WinaoOngoingCard(cancelledData[index]),
              // child:  Horizontalcardcancel()
          );

        },
      ),
    );
  }
  purchasedScreen({required BuildContext context}){
    bool _hasBeenPressed = true;
    return Container(
      margin: EdgeInsets.only(top: 65),
      padding: EdgeInsets.symmetric(horizontal: 0),
     child:load?CustomLoader():purchasedData.length==0?Center(child: ParagraphText(text: 'No Data Found',),): ListView.builder(
        itemCount: purchasedData.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:purchasedData[index]['id'].toString(),)),
              );
              // Navigator.pushNamed(context, Detail_page.id);
            },
            child: WinaoOngoingCard(purchasedData[index]),
            // child:  Horizontalcardcancel()
          );

        },
      ),
      // child: ListView(
      //   children: [
      //     GestureDetector(
      //         onTap: (){
      //           Navigator.pushNamed(context, Detail_page.id);
      //         },
      //         child: Card(
      //           clipBehavior: Clip.antiAlias,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      //           ),
      //           elevation: 0,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //
      //               Expanded(
      //                 flex: 2,
      //                 child: Column(
      //
      //                   children: [
      //                     Container(
      //                       // height: 98,
      //                       color: Color(0xFFF7F7F7),
      //                       padding: EdgeInsets.all(10),
      //                       child: Image.asset('assets/images/product.png',
      //                         fit: BoxFit.fitWidth,
      //                         width: 105,
      //                         height: 98,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //
      //               Expanded(
      //                 flex: 5,
      //                 child: Column(
      //                   children: [
      //                     ListTile(
      //                       visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      //                       contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
      //
      //                       title: Padding(
      //                         padding: EdgeInsets.all(0),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Text('Price: 300',  style: TextStyle(
      //                                 color: Colors.black, fontFamily: 'semibold', fontSize: 13
      //                             ),
      //                             ),
      //
      //
      //                           ],
      //                         ),
      //                       ),
      //
      //                       subtitle: Text(
      //                         'Macbook Pro M1',
      //                         style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
      //                       ),
      //                     ),
      //
      //
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 10, right: 16, bottom: 5, top: 0),
      //                       child: Text(
      //                         '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
      //                         style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9),
      //                         maxLines: 2,
      //                       ),
      //                     ),
      //                     Row(
      //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         GestureDetector(
      //                           onTap: () {showDialog<void>(context: context, builder: (context) => dialograte);},
      //                           child: Container(
      //                             margin: EdgeInsets.only(left: 10, right: 4),
      //                             // width: MediaQuery.of(context).size.width,
      //                             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      //                             decoration: BoxDecoration(
      //                               color: _hasBeenPressed ? Colors.transparent: MyColors.primaryColor,
      //                               borderRadius: BorderRadius.circular(5),
      //                               border:Border.all(color: MyColors.primaryColor),
      //                             ),
      //                             child: Text(
      //                               'Rate Now',
      //                               textAlign: TextAlign.center,
      //                               style: TextStyle(
      //                                   color:MyColors.primaryColor,
      //                                   fontSize: 10,
      //                                   fontFamily: 'semibold'
      //                               ),
      //                             ),
      //                           ),
      //
      //                         ),
      //
      //                         GestureDetector(
      //                           onTap: (){
      //                             showDialog<void>(context: context, builder: (context) => dialog);
      //                           },
      //                           child: Container(
      //                             margin: EdgeInsets.only(left: 4, right: 4),
      //                             // width: MediaQuery.of(context).size.width,
      //                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //                             decoration: BoxDecoration(
      //                               color:MyColors.primaryColor,
      //                               // gradient: hasGradient?gradient ??
      //                               //     LinearGradient(
      //                               //       colors: <Color>[
      //                               //         Color(0xFF064964),
      //                               //         Color(0xFF73E4D9),
      //                               //       ],
      //                               //     ):null,
      //                               borderRadius: BorderRadius.circular(5),
      //                               border:Border.all(color: MyColors.primaryColor),
      //                             ),
      //                             child: Text(
      //                               'Cancel',
      //                               textAlign: TextAlign.center,
      //                               style: TextStyle(
      //                                   color:MyColors.whiteColor,
      //                                   fontSize: 8,
      //                                   fontFamily: 'semibold'
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     vSizedBox,
      //                   ],
      //                 ),
      //               ),
      //
      //             ],
      //           ),
      //         )
      //     ),
      //     GestureDetector(
      //         onTap: (){
      //           Navigator.pushNamed(context, Detail_page.id);
      //         },
      //         child: Card(
      //           clipBehavior: Clip.antiAlias,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      //           ),
      //           elevation: 0,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //
      //               Expanded(
      //                 flex: 2,
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       height: 240,
      //                       color: Color(0xFFF7F7F7),
      //                       padding: EdgeInsets.all(10),
      //                       child: Image.asset('assets/images/product.png',
      //                         fit: BoxFit.fitWidth,
      //                         width: 105,
      //                         height: 98,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //
      //               Expanded(
      //                 flex: 5,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     ListTile(
      //                       visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      //                       contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
      //
      //                       title: Padding(
      //                         padding: EdgeInsets.all(0),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Text('Price: 300',  style: TextStyle(
      //                                 color: Colors.black, fontFamily: 'semibold', fontSize: 13
      //                             ),
      //                             ),
      //
      //
      //                           ],
      //                         ),
      //                       ),
      //
      //                       subtitle: Text(
      //                         'Macbook Pro M1',
      //                         style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
      //                       ),
      //                     ),
      //
      //
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 10, right: 16, bottom: 5, top: 0),
      //                       child: Text(
      //                         '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
      //                         style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9),
      //                         maxLines: 2,
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //                       child: Text('Rating and Review', style: TextStyle(fontSize: 12, fontFamily: 'semibold'),),
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      //                       padding: EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         color: Color(0xFEF9F9F9),
      //                         borderRadius: BorderRadius.circular(8)
      //                       ),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Row(
      //                             children: [
      //                               Icon(Icons.star, size: 18, color: MyColors.primaryColor,),
      //                               Icon(Icons.star, size: 18, color: MyColors.primaryColor),
      //                               Icon(Icons.star, size: 18, color: MyColors.primaryColor),
      //                               Icon(Icons.star_border, size: 18, color: MyColors.primaryColor),
      //                               Icon(Icons.star_border, size: 18, color: MyColors.primaryColor),
      //                               hSizedBox,
      //                               Container(
      //                                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      //                                 decoration: BoxDecoration(
      //                                   color: MyColors.primaryColor,
      //                                   borderRadius: BorderRadius.circular(5)
      //                                 ),
      //                                 child: Text('3', style: TextStyle(fontFamily: 'semibold', color: Colors.white, fontSize: 12),),
      //                               )
      //                             ],
      //                           ),
      //                           Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      //                             style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                     vSizedBox,
      //                   ],
      //                 ),
      //               ),
      //
      //             ],
      //           ),
      //         )
      //     ),
      //
      //
      //   ],
      // ),
    );
  }

  final SimpleDialog dialograte = SimpleDialog(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    insetPadding: EdgeInsets.all(10),
    contentPadding: EdgeInsets.all(10),
    title: Text('Help us to serve you better!', textAlign: TextAlign.center,),
    children: [
      SimpleDialogItemrate(),
    ],
  );


  final SimpleDialog dialog = SimpleDialog(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    insetPadding: EdgeInsets.all(10),
    contentPadding: EdgeInsets.all(10),
    title: Text('Are you sure you want to cancel?', textAlign: TextAlign.center,),
    children: [
      SimpleDialogItem(),
    ],
  );

  @override
  @override
  void initState() {
    // TODO: implement initState
    getMyUrgentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('WINAO', style: TextStyle(fontSize: 16, fontFamily: 'bold', letterSpacing: 1),),
        actions: [


          Badge.Badge(
            badgeColor: Color(0xff00b7ff),

            showBadge:notificationnumber.toString()=='null'||notificationnumber.toString()=='0'?false:true ,
            position: Badge.BadgePosition.topEnd(top: 10, end: 6),
            // badgeColor: Colors.white,
            badgeContent:Text('${notificationnumber.toString()}',style: TextStyle(color: Colors.white,fontSize: 10)),
            child: IconButton(
              icon: Image.asset(MyImages.notification, height: 25, color: MyColors.whiteColor,),
              onPressed: () {
                Navigator.pushNamed(context, NotificationPage.id);
              },
            ),
          ),

          // IconButton(
          //   onPressed: (){
          //     Navigator.pushNamed(context, NotificationPage.id);
          //   },
          //   icon: Image.asset(MyImages.notification, height: 25,),
          // ),
        ],
        backgroundColor: Color(0xFF004173),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(
          length: 3,
          child: Builder(
            builder: (BuildContext context) => Stack(
              children: <Widget>[
                TabBarView(children: [
                  ongoingScreen(context: context),
                  cancelledScreen(context: context),
                  purchasedScreen(context: context),
                ]),
                Container(
                  margin: EdgeInsets.only(top:10),
                  child: IconTheme(
                    data: IconThemeData(
                      size: 135.0,
                    ),
                    child: TabBar(
                      unselectedLabelColor: Color(0xFF004173),
                      labelColor: MyColors.whiteColor,
                      indicatorColor: Color(0xff00b7ff),
                      indicator:  BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF13b8e8),

                      ),
                      // unselectedLabelStyle:,
                      tabs: [
                        Tab(
                          child: Container(
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:Border.all(color: Color(0xFF13b8e8),)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('On-Going', textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontSize: 11,
                                ),
                                ),
                              ],
                            ),

                          ),
                        ),
                        Tab(
                          // text: 'Cancelled',
                          child: Container(
                            width: 150,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:Border.all(
                                  color:Color(0xFF13b8e8),

                                )
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Completed', textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          // text: 'Purchased',
                          child: Container(
                            width: 150,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:Border.all(
                                  color: Color(0xFF13b8e8),

                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Cancelled', textAlign: TextAlign.center, style: TextStyle(fontSize: 11,),
                            ),
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SimpleDialogItem extends StatelessWidget {
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SimpleDialogOption(
      //
      // insetPadding: EdgeInsets.all(0),
      // contentPadding: EdgeInsets.all(0),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      // contentPadding: EdgeInsets.fromLTRB(0, 50, 0, 24),
      padding: EdgeInsets.all(10),
       child: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             MainHeadingText(text: 'Reason of Cancellation?', fontSize: 10, fontFamily: 'regular',),
             vSizedBox,
             CustomTextField(controller: codeController, hintText: 'Select Reason'),
             vSizedBox,
             MainHeadingText(text: 'Comment', fontSize: 10, fontFamily: 'regular',),
             vSizedBox,
             Container(
                 decoration: BoxDecoration(
                     color: MyColors.whiteColor,
                     border: Border.all(color: MyColors.primaryColor),
                     // border: Border,
                     borderRadius: BorderRadius.circular(30)),
                 padding: EdgeInsets.only(left: 10),
               child: TextField(
                 maxLines: 4,
                 decoration: InputDecoration(
                   hintText: 'Optional*',
                   border: InputBorder.none,
                 ),
               )
             ),
             vSizedBox2,
             RoundEdgedButtonred(text: 'Cancel Delivery', color: MyColors.primaryColor,)


           ],
         ),
       ),
      // onPressed: onPressed,

    );
  }
}


class SimpleDialogItemrate extends StatelessWidget {
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SimpleDialogOption(
      //
      // insetPadding: EdgeInsets.all(0),
      // contentPadding: EdgeInsets.all(0),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      // contentPadding: EdgeInsets.fromLTRB(0, 50, 0, 24),
      padding: EdgeInsets.all(10),
       child: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(
                   Icons.star_rounded, color: MyColors.primaryColor,
                 ),
                 Icon(
                   Icons.star_rounded,color: MyColors.primaryColor,
                 ),
                 Icon(
                   Icons.star_rounded,color: MyColors.primaryColor,
                 ),
                 Icon(
                   Icons.grade_outlined, color: MyColors.primaryColor,
                 ),
                 Icon(
                   Icons.grade_outlined, color: MyColors.primaryColor,
                 ),
               ],
             ),
             vSizedBox,
             MainHeadingText(text: 'What’s on your mind?', fontSize: 10, fontFamily: 'regular',),
             vSizedBox,
             Container(
                 decoration: BoxDecoration(
                     color: MyColors.whiteColor,
                     border: Border.all(color: MyColors.grey),
                     // border: Border,
                     borderRadius: BorderRadius.circular(10)),
                 padding: EdgeInsets.only(left: 10),
               child: TextField(
                 maxLines: 4,
                 decoration: InputDecoration(
                   hintText: 'Optional*',
                   border: InputBorder.none,
                 ),
               )
             ),
             vSizedBox2,
             RoundEdgedButtonred(text: 'Submit', color: MyColors.primaryColor,
             onTap: (){
               Navigator.pop(context, true);
             },
             )


           ],
         ),
       ),
      // onPressed: onPressed,

    );
  }
}