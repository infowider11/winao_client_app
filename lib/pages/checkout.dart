import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/billing.dart';
import 'package:winao_client_app/pages/detail.dart';
import 'package:winao_client_app/services/api_urls.dart';
import 'package:winao_client_app/services/webservices.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../constants/global_costants.dart';
import '../services/auth.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  static const String id = "checkout";
  final Map? code;
  final List? produts;
  final Map? agent;
  final Map? customer;
  final Map? order;
  final String? order_id;
  final String? date;
  final List? product;
  final String? reffid;
  final String? recomenid;

  Checkout({
    Key? key,
    this.code,
    this.produts,
    this.agent,
    this.customer,
    this.order,
    this.order_id,
    this.date,
    this.product,
    this.reffid,
    this.recomenid
  }) : super(key: key);

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  int qnty  = 0;
  int amount = 0;
  int discountamount = 0;
  int discount = 0;
  int total = 0;
  int Grandtotal = 0;
  int discountprice = 0;


  initiialzie(){
    log('data coming from api--55---'+widget.product.toString());
    widget.product?.forEach((element) {

      print('stok-----${element['stock_qty']}');
      if(element['stock_qty'].toString()!='0'){
        element['qty'] = int.parse((element['qty']??'0').toString()) + 1;
        addItem(item: element);

      }
    });
    setState((){});
  }


  List cart = [];

  addItem({
    required Map item,
  }){
    String id = item['id'];
    print('the cart is ${cart}');
    int tempCount = 0;
    for(int i = 0;i<cart.length;i++){
      if(cart[i]['id']==id){
        print('the selected item is ${cart[i]}');
        tempCount++;
        cart[i]['qty'] +=1;
      }
    }
    if(tempCount==0){
      Map tempItem = {
        'qty':1,
      };
      tempItem.addAll(item);
      cart.add(tempItem);


      // );
    }

    print('the cart is ${cart}');
    total = 0;
    Grandtotal=0;
    discountprice=0;
    for(int i = 0;i<cart.length;i++){
      // total += (int.parse(cart[i]['qty'].toString()) *
      //         int.parse(cart[i]['winao_price'].toString()))
      //     .toString();
      total += ((cart[i]['qty'] as int) * int.parse(cart[i]['winao_price'].toString()) );
      Grandtotal += ((cart[i]['qty'] as int) * int.parse(cart[i]['price'].toString()));
       discountprice = total-Grandtotal;
    }

    // Grandtotal =Total;
    print('Total..........${total}');
    setState((){});
  }

  removeItem({
    required Map item,
  }){
    String id = item['id'];
    print('the cart is ${cart}');
    int tempCount = 0;
    for(int i = 0;i<cart.length;i++){
      if(cart[i]['id']==id){
        print('the selected item is ${cart[i]}');
        tempCount--;
        cart[i]['qty'] -=1;
      }
    }
    if(tempCount==0){
      Map tempItem = {
        'qty':1,
      };
      tempItem.addAll(item);
      cart.add(tempItem);

    }

    print('the cart is ${cart}');
    total = 0;
    Grandtotal=0;
    discountprice=0;
    for(int i = 0;i<cart.length;i++){
      // total += (int.parse(cart[i]['qty'].toString()) *
      //         int.parse(cart[i]['winao_price'].toString()))
      //     .toString();
      total += ((cart[i]['qty'] as int) * int.parse(cart[i]['winao_price'].toString()) );
      Grandtotal += ((cart[i]['qty'] as int) * int.parse(cart[i]['price'].toString()));
      discountprice = total-Grandtotal;
    }

    // Grandtotal =Total;
    print('Total..........${total}');
    setState((){});
  }

  String privacycontent = '';




  markAsSeen()async{
    print('${widget.order_id}--seen--------order_id');

    var id = await getCurrentUserId();
    var res = await Webservices.getList('${ApiUrls.markasseen}?is_seen=1&recommended_id=${widget.order_id}');
    print('${res}');
  }
  void initState() {
    // TODO: implement initState
    markAsSeen();
    super.initState();

    initiialzie();

  }


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print('_counter...........${_counter}');
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    // var produts;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: appBar(
        context: context,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // for (var i = 0; i<productslist.length; i++)

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Details',
                            style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                          ),
                          vSizedBox,

                          Text(
                            '${widget.customer!['f_name'] + " " + widget.customer!['l_name']}',
                            style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                          ),
                          Text(
                            '${widget.customer!['email']}',
                            style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                          ),

                          // Text('Order ID:#${widget.order_id}', style: TextStyle(fontSize: 14, fontFamily: 'regular'),),
                          // Text(
                          //   'Order Date: ${DateFormat.yMd().format(DateTime.parse(widget.date.toString()))}', style: TextStyle(fontSize: 14, color: Color(0xFE999999), fontFamily: 'regular'),),
                          // Text('Order time: ${DateFormat.Hm().format(DateTime.parse(widget.date.toString()))}', style: TextStyle(fontSize: 14, color: Color(0xFE999999), fontFamily: 'regular'),),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Reffered Detail',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                          ),
                          vSizedBox,
                          Text(
                            '#${widget.reffid}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                          ),
                          Text(
                            'Agent Code:' +(widget.agent!['user_code']??'NA'),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                          ),
                          // Text(
                          //   widget.agent!['user_code']??'NA',
                          //   textAlign: TextAlign.right,
                          //   style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                          // ),
                          Text(
                            widget.agent!['f_name'] +
                                ' ' +
                                widget.agent!['l_name'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                          ),
                          Text(
                            widget.agent!['email'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFE999999),
                                fontFamily: 'regular'),
                          ),
                          Text(
                            widget.agent!['phone'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFE999999),
                                fontFamily: 'regular'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                vSizedBox4,
                Text(
                  'Recommended Products are :',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, fontFamily: 'regular',color: Color(0xff212121)),
                ),
                vSizedBox,
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.product!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          // _incrementCounter();
                          // Navigator.pushNamed(context, Detail_page.id,);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail_page(
                                    productdata: widget.product![index],
                                    agent_name:
                                        '${widget.agent!['f_name']} ${widget.agent!['l_name']}'),
                              ));
                          print("products details");
                          print(widget.product![index]);
                        },
                        child: HorizontalcardProduct(
                            data: widget.product![index],

                            addItem: (){

                              if(widget.product![index]['stock_qty'].toString()!='0'){
                                print('the cart is kdk ${widget.product![index]['stock_qty']}');
                                addItem(
                                  item: widget.product![index],
                                );
                                widget.product![index]['qty'] = int.parse((widget.product![index]['qty']??'0').toString()) + 1;
                                setState((){});
                              }

                            },

                            removeItem: (){
                              print('quantity..............${widget.product![index]['qty']}');
                              // for(var i=0;i<=cart.length;i++){
                              //   if( total>0 && Grandtotal>0 ){
                              // if(widget.product![index]['qty']>1){
                                removeItem(
                                  item: widget.product![index],
                                );
                                // }
                                // }
                                // if(widget.product![index]['qty']>1){
                                widget.product![index]['qty'] = int.parse((widget.product![index]['qty']??'0').toString()) - 1;
                                // }
                                setState((){});
                              // }


                            },

                            agent_name:
                                '${widget.agent!['f_name']} ${widget.agent!['l_name']}'
                        )
                    );
                  },
                ),
                vSizedBox2,
                // Padding(

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              "Subtotal :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.5),
                            )),
                        vSizedBox05,
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              "Discount :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.5),
                            )),
                        vSizedBox05,
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              "Total :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.5),
                            )),
                        vSizedBox05,
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              // widget.product![i]['winao_price']
                              "\$ ${Grandtotal}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )),
                        vSizedBox05,
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              "\-\$ ${discountprice}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )),
                        vSizedBox05,
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 10.0),
                            // alignment: Alignment.topRight,
                            child: Text(
                              "\$ ${total}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )),
                        vSizedBox05,


                      ],
                    ),
                  ],
                ),
                vSizedBox6,

                // ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              child: RoundEdgedButton(
                text: 'Checkout Now',
                color:total>0? Color(0xff004173): Color(0xff5a89b4),
                boderRadius: 10,
                textColor: Colors.white,

                onTap: () {
                  List newCart=[];
                  // log('sdggdg--------${widget.product![i]['is_newsletter']}');
                  // _incrementCounter();
                  // Navigator.pushNamed(context, BillingPage.id);
                  log('customer:------------555${cart[0]}');
                  for(int i=0;i<cart.length;i++){
                    if(cart[i]['qty']!=0){
                      print("qty 0 === $i");
                      newCart.add(cart[i]);

                    }
                  }
                  // setState(() {
                  //
                  // });
                  log('customer:------ankita------555${newCart.length}');

                  // return;//mizannn
                   if(total>0){

                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context) =>
                             BillingPage(

                               carts:newCart,ccustomer:widget.customer,aagent: widget.agent,recoid:widget.recomenid,
                               // is_newsletter:widget.product['is_newsletter'].toString()
                             )
                         )
                     );
                   }
                },
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),

        ],
      ),
    );
  }
}
