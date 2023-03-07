import 'dart:async';
import 'dart:developer';
import 'dart:convert' as convert;
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/pages/detail.dart';
import 'package:winao_client_app/pages/notification.dart';
import 'package:winao_client_app/pages/wallet.dart';
import 'package:winao_client_app/widgets/GOOGLEMAP.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/loader.dart';
import 'package:winao_client_app/widgets/side_drawer.dart';
import 'package:winao_client_app/widgets/vertical_card.dart';

import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/newloader.dart';
import 'map.dart';


class Home extends StatefulWidget {
  static const String id="home";
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List products = [];
  List recomendationproductdata =[];
  int  totalorders=0;
  int  pendingpaymentorders=0;
  int  pendingrevieworders=0;
  int  cancelorders=0;
  int  completedorders=0;
  String orderid ='';
  String fname="";
  String lname="";
  bool load=false;
  String notificationcount='';
  Map countnotification={};
  bool isExit=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification();
    ordercount();
    newrp();
    interval();
  }

  interval(){
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      notification();
      // log("Print after 5 seconds");
    });
    super.initState();
    setState((){});

  }

  notification() async {
    if(await isUserLoggedIn()){
      var user_id = await getCurrentUserId();
      var res = await Webservices.getData('${ApiUrls.interval_api}?user_id=${user_id}&m=1');
      log('countnotification---------------111-${res.body}');
      var jsonResponse = convert.jsonDecode(res.body);
      countnotification=jsonResponse;
      // log('countnotification----${countnotification}');
      // log('countnotification----${countnotification['unreadNotification']}');
      notificationnumber= countnotification['unreadNotification'];
      // print('notificationnumber----------${notificationnumber}');
      // setState((){});
    }

  }
  ordercount() async {
    var user_id=await getCurrentUserId();
    print('user_idddd.......${user_id}');
    var res = await Webservices.getMap('${ApiUrls.orderscount}?t=1&user_id=${user_id}&m=1');

    log('customercompletedorder....${res}');
    log('pending_payment_orders....${res['pending_payment_orders'].toString()}');

    pendingpaymentorders=int.parse(res['pending_payment_orders'].toString());

    log('pendingpaymentorders....${pendingpaymentorders}');

    pendingrevieworders=int.parse(res['pending_review_orders'].toString());
    log('pendingrevieworders....${pendingrevieworders}');


    cancelorders=int.parse(res['cancel_orders'].toString());
    log('cancelorders....${cancelorders}');

    completedorders=int.parse(res['completed_orders'].toString());
    log('completedorders....${completedorders}');

     totalorders = int.parse(res['total_orders'].toString());
    log('totalorders....${totalorders}');

    setState((){});
  }
  newrp() async {
    var user_id=await getCurrentUserId();
    print('user_idddd...555....${user_id}');
    setState((){
      load=true;
    });

    var res = await Webservices.getList('${ApiUrls.getcustomerrecommendation}?t=1&user_id=$user_id&m=1');
    setState((){
      load=false;
    });
    log('Getcustomerrecommendation....${res}');
    recomendationproductdata=res;
    log('recomendationproductdata.......${recomendationproductdata}');
    log('agentname....${res[0]['agent_info']['f_name']}');
    fname=res[0]['agent_info']['f_name'];
    lname=res[0]['agent_info']['l_name'];
    orderid=res[0]['id'].toString();
    log('orderid....${orderid}');
    products= res[0]['products'];
    // for(var i=0;i<products.length;i++){
    //   log('products....${res[i]['products'].toString()}');
    //   log('title....${res[i]['products']['title'].toString()}');
    //   log('description....${res[i]['products']['description'].toString()}');
    //   setState((){});
    //
    // }
    setState((){});

  }
  refresh(){
     newrp();
     setState((){});
  }




  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(context: context, builder: (context1){
          return AlertDialog(

            title: Text('Exit',),
            content: Text('Are you sure, want to Exit?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    // Navigator.pop(context1);
                    //
                    // isExit=true;
                    //         setState(() {
                    //
                    //         });
                    SystemNavigator.pop();
                  }, child: Text('Exit')),
              TextButton(onPressed: () async {

                Navigator.pop(context1);
                // isExit=false;
                // setState(() {
                //
                // });
              }, child: Text('cancel')
              ),
            ],
          );
        });
      if(isExit){
        return true;
      }
      else{
        return false;
      }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: SideDrawer(scaffoldKey: scaffoldKey,),
        appBar: AppBar(

          automaticallyImplyLeading: false,
          title: Text('WINAO', style: TextStyle(fontSize: 16, fontFamily: 'bold', letterSpacing: 1),),
          actions: [


            Badge.Badge(
              badgeColor: Color(0xff00b7ff),

              showBadge:notificationnumber.toString()=='null'||notificationnumber.toString()=='0'?false:true ,
              position:Badge.BadgePosition.topEnd(top: 10, end: 6),
              // badgeColor: Colors.white,
              badgeContent:Text('${notificationnumber.toString()}',style: TextStyle(color: Colors.white,fontSize: 10)),
              child: IconButton(
                icon: Image.asset(MyImages.notification, height: 25, color: MyColors.whiteColor,),
                onPressed: () async{
                 await Navigator.pushNamed(context, NotificationPage.id);
                  // Map data={};
                  // print("data------------${data['name']['name']}");
                 refresh();

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
          backgroundColor:Color(0xFF004173),
        ),
        body:load?CustomLoader(): Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,
                Row(

                  children: [
                    Expanded(
                      // flex: 12,
                      child: GestureDetector(
                        onTap: (){
                          print('lkdfjglkdfjgl');
                          MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                        },
                        child: Container(
                          height: 63,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            // color: Color(0xFF00b7ff),
                            //   color: Color(0xffd5d8da),
                            borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffbdbdbd))
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('Total Orders',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'light',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('${totalorders}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'bold',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                flex: 2,
                                child: Image.network('https://wincomis.com/assets/images/total-orders.png', height: 35,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      // flex: 10,
                      child: GestureDetector(
                        onTap: (){
                          print('lkdfjglkdfjgl');
                          MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                        },
                        child: Container(
                          height: 63,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              // color: Color(0xFF00b7ff),
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color:Color(0xffbdbdbd))
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: (){
                                      print('lkdfjglkdfjgl');
                                      MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('Pending Payment Orders',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'light',

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('${pendingpaymentorders}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'bold',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network('https://wincomis.com/assets/images/pending-payment-order.png', height: 30,),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(

                  children: [
                    Expanded(
                      // flex: 12,
                      child: GestureDetector(
                        onTap: (){
                          print('lkdfjglkdfjgl');
                          MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                        },
                        child: Container(
                          height: 63,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              // color: Color(0xFF00b7ff),
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color:Color(0xffbdbdbd))
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                  flex: 4,
                                  child: GestureDetector(
                                    onTap: (){
                                      print('lkdfjglkdfjgl');
                                      MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('Pending Review Orders',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'light',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('${pendingrevieworders}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'bold',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 2,
                                child: Image.network('https://wincomis.com/assets/images/pending-review.png', height: 30,),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      // flex: 10,
                      child:  GestureDetector(
                        onTap: (){
                          print('lkdfjglkdfjgl');
                          MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                        },
                        child: Container(
                          height: 63,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              // color: Color(0xFF00b7ff),
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xffbdbdbd))
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: (){
                                      print('lkdfjglkdfjgl');
                                      MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('Cancelled Orders',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'light',

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text('${cancelorders}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'bold',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network('https://wincomis.com/assets/images/canceller-orders.png', height: 30,),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // vSizedBox,
                SizedBox(height: 10,),
                Row(

                  children: [
                    Expanded(
                      // flex: 12,
                      child: GestureDetector(
                        onTap: (){
                          print('lkdfjglkdfjgl');
                          MyGlobalKeys.tabBarKey.currentState!.onItemTapped(2);
                        },
                        child: Container(
                          height: 63,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              // color: Color(0xFF00b7ff),
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xffbdbdbd))
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('Completed Orders',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'light',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('${completedorders}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'bold',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                flex: 2,
                                child: Image.network('https://wincomis.com/assets/images/completed-order.png', height: 30,),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      // flex: 10,
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        // decoration: BoxDecoration(
                        //   color: Color(0xFFFBD2D2),
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                        // child: Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 3,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.symmetric(horizontal: 10),
                        //               child: Text('Cancelled Orders',
                        //                 style: TextStyle(
                        //                   fontSize: 10,
                        //                   fontFamily: 'light',
                        //
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.symmetric(horizontal: 10),
                        //               child: Text('00',
                        //                 style: TextStyle(
                        //                   fontSize: 14,
                        //                   fontFamily: 'bold',
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         )
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Image.asset(MyImages.download, height: 30,),
                        //     ),
                        //
                        //   ],
                        // ),
                      ),
                    ),
                  ],
                ),
                vSizedBox,


                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 16),
                //   child: Text('Recommended Products', style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16,
                //   ),),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //         child:GestureDetector(
                //           onTap: (){
                //             Navigator.pushNamed(context, Detail_page.id);
                //           },
                //           child: Verticalcard(),
                //         ),
                //     ),
                //     Expanded(
                //       child:GestureDetector(
                //         onTap: (){
                //           Navigator.pushNamed(context, Detail_page.id);
                //         },
                //         child: Verticalcard(),
                //       ),
                //     ),
                //
                //   ],
                // ),
                // Divider(
                //   height: 40,
                //   thickness: 3,
                //   color: Color(0xFFF2F4FF),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Newly Recommended Orders', style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 16,
                  ),),
                ),
                Container(
                  child:recomendationproductdata.length==0?Container(height:100,child:
                  Center(child: ParagraphText(text:'No Recommended Orders',))): ListView.builder(
                    shrinkWrap: true,
                    physics:NeverScrollableScrollPhysics(),
                    itemCount:recomendationproductdata.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Detail_page.id,);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => Detail_page(productdata:recomendationproductdata[index], agent_name: '',)));
                        },
                        child:Horizontalcard(
                          orderdetailsdata:recomendationproductdata[index],
                            refresh: (){
                              refresh();
                              },
                        )
                      );

                    },
                  ),
                ),
                // TextButton(onPressed: (){
                //   Navigator.push<void>(
                //     context,
                //     MaterialPageRoute<void>(
                //       builder: (BuildContext context) => MapSample(),
                //     ),
                //   );
                // },
                //     child: Text('map'))

              ],
            ),
          ),
        ),
      ),
    );
  }

}
