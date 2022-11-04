import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/pages/detail.dart';
import 'package:winao_client_app/pages/myorder.dart';
// import 'package:winao_client_app/pages/myorder.dart';
// import 'package:winao_commission_app/constants/colors.dart';
// import 'package:winao_commission_app/constants/image_urls.dart';
// import 'package:winao_commission_app/pages/detail.dart';
// import 'package:winao_commission_app/pages/wallet.dart';
// import 'package:winao_commission_app/widgets/CustomTexts.dart';
// import 'package:winao_commission_app/widgets/appbar.dart';
// import 'package:winao_commission_app/widgets/horizontal_card.dart';

import '../constants/colors.dart';
import '../constants/global_keys.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
// import '../services/old_api_provider.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/loader.dart';
import '../widgets/notificationcard.dart';
import 'bottomnavigation.dart';
import 'checkout.dart';
import 'home.dart';
import 'manageorder.dart';
// import 'home.dart';
// import 'manageorder.dart';

class NotificationPage extends StatefulWidget {
  static const String id="noti";
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    getnotification();
    markasread();
    super.initState();
  }
  List list=[];
  String wallet_id='';
  getnotification()async{
    var id = await getCurrentUserId();
    loadingShow(context);
    var res = await Webservices.getList('${ApiUrls.get_notification}?user_id=$id');
    loadingHide(context);
    list=res;
    setState((){
      markasread();
    });
    print('listttt'+res.toString());
  }
  markasread()async{
    var id = await getCurrentUserId();
    var res = await Webservices.getList('${ApiUrls.markasreadotification}?user_id=$id');
    print('${res}');
  }
  clear_notifications()async{
    var id = await getCurrentUserId();
    var res = await Webservices.getMap('${ApiUrls.clearnotification}?user_id=$id');
    print("dfgdgfahsf"+res.toString());
    getnotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      // appBar: appBar(context: context,
      //     implyLeading:false,
      //
      // ),

      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: MainHeadingText(text: 'Notification', fontSize: 18, fontFamily: 'semibold',),
              ),
              if(list.length>0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child:GestureDetector(
                  onTap: ()async{
                    showDialog(context: context, builder: (context1) {
                      return AlertDialog(

                        title: Text('Clear All',),
                        content: Text('Are you sure, want to clear all notifications ?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await clear_notifications();
                                await getnotification();
                                Navigator.pop(context1);

                              }, child: Text('Clear All')),
                          TextButton(onPressed: () async {
                            Navigator.pop(context1);
                          }, child: Text('Cancel')
                          ),
                        ],
                      );
                    });                  },
                    child:MainHeadingText(text: 'Clear All', fontSize: 16, fontFamily: 'regular', color: MyColors.blackColor,)),
              ),
            ],
          ),
          SizedBox(height: 10,),

      Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i=0; i<list.length; i++)
            GestureDetector(
                      onTap: ()async{
                        if(list[i]['other']['screen']=='recommended'){
                          print('popping');
                          Navigator.pop(context);
                          // Navigator.popUntil(context, (route) => route.isFirst);
                          // MyGlobalKeys.tabBarKey.currentState?.onItemTapped(0);
                        }
                        if(list[i]['other']['screen']=='order'){
                          print('popping');
                          Navigator.push(
                            MyGlobalKeys.tabBarKey.currentContext!,
                            MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderid: '${list[i]['other']['order_id']}', orderData: {},)),
                          );
                        }

                        print('you tab on notification');
            //                 try{
            //   // if(MyGlobalKeys.tabBarKey2.currentState!=null)
            //   // wallet_id=list[i]['other']['id'];
            //   // if(list[i]['other']['user_type'].toString()=='1'){
            //     MyGlobalKeys.tabBarKey.currentState!.onItemTapped(0);
            //   // }
            //   // else if(list[i]['other']['user_type'].toString()=='2'){
            //   //   MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
            //   // }
            //
            // }catch(e){
            //   print('Error in catch block 342 $e');
            // }

                        // MyGlobalKeys.tabBarKey.currentState!.onItemTapped(0);
                        print('you tab on notification');
                        // if(list[i]['other']['screen']=='recommended'){
                        //   Navigator.push(
                        //     MyGlobalKeys.tabBarKey.currentContext!,
                        //     MaterialPageRoute(builder: (context) =>  Home()),
                        //   );
                        // }
                        //
                        // else if(list[i]['other']['screen']=='order'){
                        //   Navigator.push(
                        //     MyGlobalKeys.tabBarKey.currentContext!,
                        //     MaterialPageRoute(builder: (context) =>  MyorderPage()),
                        //   );
                        // }
                        // MyGlobalKeys.tabBarKey.currentState!.onItemTapped(0);

                        // Navigator.pushNamed(context, Detail_page.id);
                        // if(list[i]['other']!=false){
                        //   if(list[i]['other']['screen'].toString()=='order'){
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:list[i]['other']['order_id'].toString(),)),
                        //     );
                        //
                        //   }
                        //   else if(list[i]['other']['screen'].toString()=='withdrawal'){
                        //     Navigator.pop(context);
                        //     // MyGlobalKeys
                        //     try{
                        //       // if(MyGlobalKeys.tabBarKey2.currentState!=null)
                        //       wallet_id=list[i]['other']['id'];
                        //       // if(list[i]['other']['user_type'].toString()=='1'){
                        //       //   MyGlobalKeys.tabBarKey2.currentState!.onItemTapped(3);
                        //       // }
                        //       // else if(list[i]['other']['user_type'].toString()=='2'){
                        //       //   MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
                        //       // }
                        //
                        //     }catch(e){
                        //       print('Error in catch block 342 $e');
                        //     }
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(builder: (context) =>   WalletPage(id:list[i]['other']['id'],)),
                        //     // );
                        //   }
                        // }


                      },
                      child:  NotificationCard(data: list[i],)
                  ),
            if(list.length==0)
              Container(height:500,child:Center(child: Text('No data found.'),) ,)

            // NotificationCard(
            //   image: false, data: list[i],
            // )

          ],
            ),
      ),
        ],
      ),




    );
  }
}
