import 'dart:developer';

import 'package:badges/badges.dart' as Badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/pages/changepassword.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/pages/editprofile.dart';
import 'package:winao_client_app/pages/help.dart';
import 'package:winao_client_app/pages/notification_setting.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/pages/support.dart';
import 'package:winao_client_app/pages/wallet.dart';

import '../constants/global_costants.dart';
import '../constants/global_keys.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/customtextfield.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
import 'manageorder.dart';
import 'notification.dart';
import 'dart:convert' as convert;


class SettingsPage extends StatefulWidget {
  static const String id="settings";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List products = [];
  Map orderinfo={};
  String? Id;
  String? id;
  String? refid;
  String? date;
  String? orderid;
  @override
  TextEditingController codeController = TextEditingController();
  Widget build(BuildContext context) {
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
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => Transaction()
                // ));
              },
              leading: SizedBox(
                  height: 25.0,
                  width: 25.0, // fixed width and height
                  child: Image.asset('assets/icons/account.png')
              ),
              // contentPadding: EdgeInsets.all(0),

              title: Transform.translate(
                offset: const Offset(-20.0, 0.0),
                child:
                Text('Account Setting',
                  style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
              ),
              // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfile()
              ));
            },
            // leading: SizedBox(
            //     height: 25.0,
            //     width: 25.0, // fixed width and height
            //     child: Image.asset('assets/icons/account.png')
            // ),
            // contentPadding: EdgeInsets.all(0),

            title: Transform.translate(
              offset: const Offset(0.0, 0.0),
              child:
              Text('Edit Profile',
                style: TextStyle(color: Color(0XFF575757), fontSize: 16, fontFamily: 'regular'),),
            ),
            trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.grey,)
          ),
          ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ChangePassword()
                ));
              },
              // leading: SizedBox(
              //     height: 25.0,
              //     width: 25.0, // fixed width and height
              //     child: Image.asset('assets/icons/account.png')
              // ),
              // contentPadding: EdgeInsets.all(0),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Transform.translate(
                offset: const Offset(0.0, 0.0),
                child:
                Text('Change Password',
                  style: TextStyle(color: Color(0XFF575757), fontSize: 16, fontFamily: 'regular'),),
              ),
              trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.grey,)
          ),
          ListTile(
            onTap: ()async{
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => Transaction()
              // ));
              await showDialog(
                  context: context,
                  builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  elevation: 16,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height:220.0,
                    width: 100.0,
                    child: ListView(

                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Referral Code',style: TextStyle(color: Colors.black, fontSize:20, fontFamily: 'regular',fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomTextField(controller: codeController, hintText: 'Enter Referral Code',
                          borderColor: Color(0xff00b7ff),
                          borderradius: 15,),
                        vSizedBox2,
                        ElevatedButton(
                          onPressed: () async{
                            if (codeController.text == '') {
                              showSnackbar(context, 'Please Enter your code.');
                              print("i am in ifftjfj");
                            }
                            // else {
                            //   print("gsghghshg");
                            //   loadingShow(context);
                            //   print("gsgh");
                            //   var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?code=${codeController.text}');
                            //   log('Apiresponse..$res');
                            //   loadingHide(context);
                            //   agentinfo=res['agent_info'];
                            //   customerinfo=res['customer_info'];
                            //   // print('Agentinfo..$agentinfo');
                            //
                            //   Id=res['id'];
                            //   refid=res['ref_id'];
                            //   id=res['id'];
                            //   print('orderinfo..$Id');
                            //   date=res['created_at'];
                            //   print('orderinfo..$date');
                            //   products=res['products'];
                            //   print('products..$products');
                            //   print('status..........${res['status']}');
                            //   print('sms..........${res['message']}');
                            //
                            //
                            //   if(res['status'].toString() == '0'){
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:Id ,date:date,reffid:refid,recomenid:id)));
                            //   }
                            //   else{
                            //     orderid=res['order']['id'].toString();
                            //     refid=res['ref_id'].toString();
                            //     print('orderid..........${orderid}');
                            //     await showDialog(
                            //       context: context,
                            //
                            //       builder: (context) {
                            //         return Dialog(
                            //           insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            //           elevation: 16,
                            //           child: Container(
                            //             padding: EdgeInsets.all(20),
                            //             // height:200.0,
                            //             // width: 400.0,
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: <Widget>[
                            //                 // Row(
                            //                 //   mainAxisAlignment: MainAxisAlignment.end,
                            //                 //   children: [
                            //                 //
                            //                 //   ],
                            //                 // ),
                            //                 // Icon(
                            //                 //   Icons.check_circle_outline,
                            //                 //   color: Colors.black,
                            //                 // ),
                            //                 // SizedBox(height: 20),
                            //                 // GestureDetector(
                            //                 //   onTap: (){
                            //                 //     Navigator.pop(context);
                            //                 //   },
                            //                 //   child: Align(
                            //                 //     alignment: Alignment.topRight,
                            //                 //     child: Icon(
                            //                 //       Icons.close,
                            //                 //       color: Colors.black,
                            //                 //     ),
                            //                 //   ),
                            //                 // ),
                            //                 vSizedBox,
                            //                 Center(
                            //                   child: Text('Thank You!',
                            //                     style:
                            //                     TextStyle(color: Colors.black, fontSize:20,
                            //                         fontFamily: 'regular',fontWeight: FontWeight.bold),),
                            //                 ),
                            //                 vSizedBox,
                            //                 Center(
                            //                   child: Text('The purchase is already made for this',
                            //                     style:
                            //                     TextStyle(color: Colors.black, fontSize:15,
                            //                       fontFamily: 'regular',),),
                            //                 ),
                            //                 // vSizedBox,
                            //                 Center(
                            //                   child: Text('recommendation ID:${orderid}',
                            //                     style:
                            //                     TextStyle(color: Colors.black, fontSize:15,
                            //                       fontFamily: 'regular',),),
                            //                 ),
                            //                 vSizedBox,
                            //                 Center(
                            //                   child: Text('Code:${refid}',
                            //                     style:
                            //                     TextStyle(color: Colors.black, fontSize:15,
                            //                       fontFamily: 'regular',),),
                            //                 ),
                            //                 vSizedBox,
                            //                 ElevatedButton(
                            //
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                     Navigator.push(
                            //                       context,
                            //                       MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
                            //                     );
                            //                   },
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            //                     child: Text('Ok'),
                            //                   ),
                            //                   style: ElevatedButton.styleFrom(shape:StadiumBorder(),
                            //                     primary:MyColors.primaryColor,
                            //
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     );
                            //
                            //
                            //
                            //
                            //     // Navigator.push(
                            //     //   context,
                            //     //   MaterialPageRoute(builder: (context) => const ManageOrdersPage(orderData: {}, orderid:orderid ??'',)),
                            //     // );
                            //
                            //   }
                            //
                            //
                            //
                            //   // if(res['status']=='1'){
                            //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:Id ,date:date)));
                            //   // }
                            //   // else{
                            //   //   showSnackbar(context, res['message']);
                            //   // }
                            //
                            //   // var res1=res.body;
                            //   // (res[data])
                            //
                            //   // for (var i = 0; i<productslist.length; i++){
                            //   //
                            //   //   productdetails=productslist[i]['products'];
                            //   //   print('productdetails......$productdetails');
                            //   // }
                            //   // for (var j = 0; j<productslist[j]['products'].length; j++){
                            //   //   print('productdetails......$productdetails');
                            //   // }
                            //   // print("status"+res['status'].toString());
                            //   // if(res['status'].toString()=='1'){
                            //   //   // updateUserDetails(res['data']);
                            //   //   Navigator.pushNamed(context, MyStatefulWidget.id);
                            //   // }
                            // }
                            else {
                            print("gsghghshg");
                            loadingShow(context);
                            print("gsgh");
                            var res1 = await Webservices.getData(ApiUrls.getrecommend_bycode+'?code=${codeController.text}');
                            var jsonResponse = convert.jsonDecode(res1.body);
                            log('Apiresponse................867.${jsonResponse['status']}');

                            var res=jsonResponse['data'];
                            // loadingHide(context);
                            //  print("Appiresponse"+res.body);
                            //  print('Apiresponse----$res');
                            //
                            // var res = await Webservices.getMap(ApiUrls.getrecommend_bycode+'?ref_id=${codeController.text}');
                            log('Apiresponse.................889.$res');
                            loadingHide(context);

                            if(jsonResponse['status'].toString() == '0'){
                            print('Invalid  code');
                            showSnackbar(context, 'Invalid code.');
                            }
                            else if(jsonResponse['status'].toString() == '1'){
                            agentinfo=res['agent_info'];
                            customerinfo=res['customer_info'];
                            print('recomenid..${res['id']}');
                            id=res['id'];
                            print('Agentinfo..$agentinfo');
                            print('ref_id..${res['ref_id']}');
                            refid=res['ref_id'];
                            print('orderinfo..$Id');
                            date=res['created_at'];
                            print('orderinfo..$date');
                            products=res['products'];
                            print('products..$products');
                            print('status..........${res['status']}');
                            print('i am in checkout');

                            if(res['status'].toString() == '0'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout(product:products,agent:agentinfo,customer:customerinfo ,order_id:Id ,date:date,reffid:refid,recomenid:id)));
                            }
                            else{


                            orderid=res['order']!['id'].toString();
                            refid=res['ref_id'].toString();
                            print('orderid..........${orderid}');
                            await showDialog(
                            context: context,

                            builder: (context) {
                            return Dialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 16,
                            child: Container(
                            padding: EdgeInsets.all(20),
                            // height:200.0,
                            // width: 400.0,
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //
                            //   ],
                            // ),
                            // Icon(
                            //   Icons.check_circle_outline,
                            //   color: Colors.black,
                            // ),
                            // SizedBox(height: 20),
                            // GestureDetector(
                            //   onTap: (){
                            //     Navigator.pop(context);
                            //   },
                            //   child: Align(
                            //     alignment: Alignment.topRight,
                            //     child: Icon(
                            //       Icons.close,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),
                            vSizedBox,
                            Center(
                            child: Text('Thank You!',
                            style:
                            TextStyle(color: Colors.black, fontSize:20,
                            fontFamily: 'regular',fontWeight: FontWeight.bold),),
                            ),
                            vSizedBox,
                            Center(
                            child: Text('The purchase is already made for this',
                            style:
                            TextStyle(color: Colors.black, fontSize:15,
                            fontFamily: 'regular',),),
                            ),
                            // vSizedBox,
                            Center(
                            child: Text('recommendation ID:${orderid}',
                            style:
                            TextStyle(color: Colors.black, fontSize:15,
                            fontFamily: 'regular',),),
                            ),
                            vSizedBox,
                            Center(
                            child: Text('Code:${refid}',
                            style:
                            TextStyle(color: Colors.black, fontSize:15,
                            fontFamily: 'regular',),),
                            ),
                            vSizedBox,
                            ElevatedButton(

                            onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:res['data']??{} ,orderid:orderid.toString(),)),
                            );
                            },
                            child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Ok'),
                            ),
                            style: ElevatedButton.styleFrom(shape:StadiumBorder(),
                            primary:MyColors.primaryColor,

                            ),
                            )
                            ],
                            ),
                            ),
                            );
                            },
                            );


                            }

                            //res['status']==0  => checkout
                            //Detail page
                            }
                            }

                          },

                          child: Text('Enter'),
                          style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                            primary:Color(0xff004173),


                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              );
              },
            leading: SizedBox(
                height: 25.0,
                width: 25.0, // fixed width and height
                child: Image.asset('assets/icons/referral.png')
            ),
            // contentPadding: EdgeInsets.all(0),

            title: Transform.translate(
              offset: const Offset(-20.0, 0.0),
              child:
              Text('Enter Referral Code',
                style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
            ),
            // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          ),
          // ListTile(
          //   onTap: (){
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => NotificationSetting()
          //     ));
          //   },
          //   leading: SizedBox(
          //       height: 25.0,
          //       width: 25.0, // fixed width and height
          //       child: Image.asset('assets/icons/notification.png')
          //   ),
          //   // contentPadding: EdgeInsets.all(0),
          //
          //   title: Transform.translate(
          //     offset: const Offset(-20.0, 0.0),
          //     child:
          //     Text('Notification Setting',
          //       style: TextStyle(color:MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
          //   ),
          //   // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          // ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HelpPage()
              ));
            },
            leading: SizedBox(
                height: 25.0,
                width: 25.0, // fixed width and height
                child: Image.asset('assets/icons/help.png')
            ),
            // contentPadding: EdgeInsets.all(0),

            title: Transform.translate(
              offset: const Offset(-20.0, 0.0),
              child:
              Text('Help',
                style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
            ),
            // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SupportPage()
              ));
            },
            leading: SizedBox(
                height: 25.0,
                width: 25.0, // fixed width and height
                child: Image.asset('assets/icons/help.png')
            ),
            // contentPadding: EdgeInsets.all(0),

            title: Transform.translate(
              offset: const Offset(-20.0, 0.0),
              child:
              Text('Support',
                style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
            ),
            // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          ),
          ListTile(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SignInPage()
              // ));
              showDialog(context: context, builder: (context1){
                return AlertDialog(

                  title: Text('Logout',),
                  content: Text('Are you sure, want to logout?'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await logout();
                          // Navigator.of(context).pushReplacementNamed('/pre-login');
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              SignInPage()),
                                  (Route<dynamic> route) => false);
                        }, child: Text('logout')),
                    TextButton(onPressed: () async {

                      Navigator.pop(context1);
                    }, child: Text('cancel')
                    ),
                  ],
                );
              });
            },
            leading: SizedBox(
                height: 25.0,
                width: 25.0, // fixed width and height
                child: Image.asset('assets/icons/logout.png')
            ),
            // contentPadding: EdgeInsets.all(0),

            title: Transform.translate(
              offset: const Offset(-20.0, 0.0),
              child:
              Text('Logout',
                style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
            ),
            // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
          ),
        ],
      ),
    );
  }
}
