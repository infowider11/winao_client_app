import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/services/api_urls.dart';
import 'package:winao_client_app/services/webservices.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';
import 'package:winao_client_app/pages/recommended_product.dart';

import '../constants/global_costants.dart';
import '../constants/global_keys.dart';
import '../pages/manageorder.dart';
import 'CustomTexts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'customtextfield.dart';
import 'package:intl/intl.dart';




final SimpleDialog dialog1 = SimpleDialog(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  insetPadding: EdgeInsets.all(10),
  contentPadding: EdgeInsets.all(0),
  title: Text('How much you want to extend\ndelivery time?', textAlign: TextAlign.center,),
  children: [
    SimpleDialogItem(),
  ],
);


enum SingingCharacter { lafayette, jefferson }

class SimpleDialogItem extends StatelessWidget {
  TextEditingController codeController = TextEditingController();

  SingingCharacter? _character = SingingCharacter.lafayette;


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
            vSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 65,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainHeadingText(text: 'FRI', fontSize: 10, fontFamily: 'semibold',color: Colors.white,),
                      MainHeadingText(text: '28 Apr', fontSize: 8, fontFamily: 'regular',color: Colors.white,),
                    ],
                  ),
                ),
                hSizedBox4,
                Container(
                  height: 35,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: MyColors.grey,
                      width: 2
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainHeadingText(text: 'SAT', fontSize: 10, fontFamily: 'semibold',color: MyColors.grey,),
                      MainHeadingText(text: '29 Apr', fontSize: 8, fontFamily: 'regular',color: MyColors.grey,),
                    ],
                  ),
                ),
                hSizedBox4,
                Container(
                  height: 35,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: MyColors.grey,
                      width: 2
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainHeadingText(text: 'SUN', fontSize: 10, fontFamily: 'semibold',color: MyColors.grey,),
                      MainHeadingText(text: '30 Apr', fontSize: 8, fontFamily: 'regular',color: MyColors.grey,),
                    ],
                  ),
                ),
              ],
            ),
            vSizedBox2,
            Column(
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('07:00 AM - 07:00 PM'),
              leading: Radio<SingingCharacter>(
                activeColor: MyColors.primaryColor,
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('10:00 AM - 10:00 PM'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.jefferson,
                activeColor: MyColors.primaryColor,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('11:00 AM - 11:00 PM'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.jefferson,
                activeColor: MyColors.primaryColor,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
          ],
        ),
            vSizedBox2,
            RoundEdgedButtonred(text: 'Save', color: MyColors.primaryColor,)

          ],
        ),
      ),
      // onPressed: onPressed,

    );
  }
}

class Horizontalcard extends StatefulWidget {
  final Function() refresh;
  final Map orderdetailsdata;
  Horizontalcard({Key? key,
required this.orderdetailsdata,
required this.refresh
  })
      : super(key: key);
  @override
  State<Horizontalcard> createState() => _HorizontalcardState();

}

class _HorizontalcardState extends State<Horizontalcard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('orderdata,,,,${widget.orderdetailsdata}');
    setState((){});
    // print('productslenths,,,,${widget.orderdetailsdata[0]['products'.length]}');

  }
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Expanded(
          //   flex: 2,
          //   child: Column(
          //
          //     children: [
          //
          //       Container(
          //         // height: 98,
          //         color: Color(0xFFF7F7F7),
          //         padding: EdgeInsets.all(10),
          //         child: Image.network(widget.productsdata![i]['images'][0]['image'],
          //           width: 150,
          //           height: 140,
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Expanded(
            // flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.orderdetailsdata['products'].length.toString()} Products on this Order', style: TextStyle(
                      color: Colors.black, fontFamily: 'semibold', fontSize: 13
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    'Recommended Id: ${widget.orderdetailsdata['id']}',
                    style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
                  ),
                  vSizedBox,
                  Text(
                    'Referrel Id : ${widget.orderdetailsdata['ref_id']}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12, height: 1.3),maxLines: 3,
                  ),
                  vSizedBox,
                  Text(
                    'Date : ${DateFormat.yMMMd().format(DateTime.parse(widget.orderdetailsdata['created_at'].toString()))}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12, height: 1.3),maxLines: 3,
                  ),
                  vSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Image.asset(MyImages.time_card, height: 15,),
                          //     SizedBox(width: 8,),
                          //     Text('Offer Valid till: 12/12/12', style: TextStyle(fontSize: 10),)
                          //   ],
                          // ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Image.asset(MyImages.user_card_image, height: 15,),
                              SizedBox(width: 8,),
                              Text('Reffered By :${widget.orderdetailsdata['agent_info']['f_name']+"  "+widget.orderdetailsdata['agent_info']['l_name']} ', style: TextStyle(fontSize: 10),)
                              // ${widget.firstname} ${widget.lastname}

                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: 80,
                          height:35,
                          decoration: BoxDecoration(
                            color: MyColors.homepagebuttoncolor,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: GestureDetector(
                            onTap: ()async {
                              print('order detal${widget.orderdetailsdata}');
                              // return;
                              // Navigator.pushNamed(context, Checkout.id);},
                              if(widget.orderdetailsdata['order_id'].toString() != '0'){
                                Navigator.push(
                                  MyGlobalKeys.tabBarKey.currentContext!,
                                  MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderid: widget.orderdetailsdata['order_id'].toString(), orderData: {},)),
                                );
                              } else {
                                await Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Checkout(product: widget
                                            .orderdetailsdata['products'],
                                            agent: widget
                                                .orderdetailsdata['agent_info'],
                                            customer: widget
                                                .orderdetailsdata['customer_info'],
                                            order_id: widget
                                                .orderdetailsdata['id'],
                                            date: 'date',
                                            reffid: widget.orderdetailsdata['ref_id'],
                                            recomenid: widget.orderdetailsdata['id'])));
                              }

                              print('refrshruned');
                              widget.refresh();
                              print('refrshruned2');

                              setState((){});
                            },
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('View Products', style: TextStyle(fontFamily: 'regular', color: Colors.white, fontSize: 10),)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalcardProduct extends StatefulWidget {
  final Map data;
  final String? agent_name;
  final Function() addItem;
  final Function() removeItem;
  String? qnty;
  // final Function() refresh;

   HorizontalcardProduct({Key? key,required
   this.data,
     this.agent_name,
     required this.addItem,
   required this.removeItem,
      this.qnty,
     // required this.refresh
   })
      : super(key: key);



  @override
  State<HorizontalcardProduct> createState() => _HorizontalcardProductState();
}

class _HorizontalcardProductState extends State<HorizontalcardProduct> {

  int cardprice=50;
  // int _counter = 0;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     print('_counter...........${widget.data['qty']}');
  //   });
  // }
  // void _decrementCounter() {
  //   setState(() {
  //     // if(_counter>0){
  //       _counter--;
  //     // }
  //     print('_counter...........${_counter}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [

                Container(
                  // height: 98,
                  color: Color(0xFFF7F7F7),
                  padding: EdgeInsets.all(10),
                  child: (widget.data!['images'].length == 0)?Image.network(widget.data!['image'],
                    width: 500,
                    height: 120,
                    fit: BoxFit.contain,
                  ):Image.network(widget.data!['images'][0]['image'],
                    width: 500,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyColors.primaryColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.data['stock_qty']}'=='0'?'Out of stock ':'Available', style: TextStyle(fontSize: 10, color: MyColors.whiteColor),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // Text('\$ ${cardprice*_counter}',  style: TextStyle(color: Colors.black,decoration: TextDecoration.lineThrough ,fontFamily: 'semibold', fontSize: 13),),
                          Text('\$ ${widget.data['price']}',  style: TextStyle(color: Colors.black,decoration: TextDecoration.lineThrough ,fontFamily: 'semibold', fontSize: 13),),
                          Text('\$ ${widget.data['winao_price']}',  style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 13),),
                        ],
                      ),

                      Text('Product Code: ${widget.data['product_code']}',  style: TextStyle(color: Colors.black, fontFamily: 'regular', fontSize: 10),),
                    ],
                  ),
                  SizedBox(height: 3,),

                  Text(
                    widget.data['title'],
                    style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
                  ),
                  // vSizedBox,
                  // Text(
                  //   Html(
                  //     data:data['description'],
                  //     // data:'<p>aboutuscontent<\/p>'
                  //   ),

                    // style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12, height: 1.3),maxLines: 3,
                  // ),

                  vSizedBox,


                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Image.asset(MyImages.time_card, height: 15,),
                          //     SizedBox(width: 8,),
                          //     Text('Offer Valid till: 7 Aug 2022', style: TextStyle(fontSize: 10),)
                          //   ],
                          // ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Image.asset(MyImages.user_card_image, height: 15,),
                              SizedBox(width: 8,),
                              Text('Reffered By : ${widget.agent_name}', style: TextStyle(fontSize: 10),)
                            ],
                          ),
                        ],
                      ),
                      // Container(
                      //   alignment: Alignment.topRight,
                      //     margin: new EdgeInsets.symmetric(vertical: 5.0),
                      //     child:GestureDetector(
                      //       onTap: (){Navigator.pushNamed(context, Checkout.id);},
                      //       child: Container(
                      //
                      //         width: 80,
                      //         height: 25,
                      //         decoration: BoxDecoration(
                      //             color: MyColors.primaryColor,
                      //             borderRadius: BorderRadius.circular(100)
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text('Add to cart', style: TextStyle(fontFamily: 'regular', color: Colors.white, fontSize: 10),)
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      // ),
                      Container(
                        alignment: Alignment.topRight,
                        child:Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,

                                    // onTap:
                                    // _counter<=0? () {widget.removeItem();_decrementCounter();} : null,
                                      onTap:int.parse(widget.data['qty']==null?'0':widget.data['qty'].toString())<=0?null:(){
                                        widget.removeItem();
                                      },
                              // onTap:null,
                                      child:  Icon(Icons.remove,color: Colors.white,),
                                  ),

                                  Text('${widget.data['qty']??'0'}',style: TextStyle(color: Colors.white),),
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: (){

                                          widget.addItem();
                                          // _incrementCounter();
                                          },
                                      child: Icon(Icons.add,color: Colors.white,)
                                  ),
                                ],
                              ),
                            )

                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class Horizontalcarddetail extends StatelessWidget {
  final Map data;
  final String? agent_name;
  Horizontalcarddetail({Key? key,required this.data,this.agent_name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        children: [

          // Expanded(
          //   flex: 2,
          //   child: Column(
          //
          //     children: [
          //       Container(
          //         // height: 98,
          //         color: Color(0xFFF7F7F7),
          //         padding: EdgeInsets.all(10),
          //         child: Image.asset('assets/images/product.png',
          //           fit: BoxFit.fitWidth,
          //           width: 105,
          //           height: 98,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Expanded(
            // flex: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Code: ${data['product_code']}', style: TextStyle(fontFamily: 'regular', fontSize: 10, color: Colors.black),),
                        vSizedBox,
                        Text('Price: \$${data['price']}',  style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 18),),
                        Text('${data['title']}', style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 24),),
                        vSizedBox,
                        // Row(
                        //   children: [
                        //     Image.asset(MyImages.time_card, height: 15,),
                        //     SizedBox(width: 8,),
                        //     Text('Offer Valid till: 7 Aug 2022', style: TextStyle(fontSize: 12),)
                        //   ],
                        // ),
                        vSizedBox,
                        Row(
                          children: [
                            Image.asset(MyImages.person, height: 15,),
                            SizedBox(width: 8,),
                            Text('Reffered By : ${agent_name}', style: TextStyle(fontSize: 12),)
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Text('${data['discount']}% OFF',textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white),)
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}



class Horizontalcardcheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(

              children: [
                Container(
                  // height: 98,
                  // color: Color(0xFFF7F7F7),
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/product.png',
                    fit: BoxFit.cover,
                    width: 105,
                    height: 98,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16, bottom: 0, top: 0),
                  child: Text(
                    'Product ID: PQR12345',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 14),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),

                  title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Text(
                          'Macbook Pro M1',
                          style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 20),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(right: 10),
                        //   width: 80,
                        //   decoration: BoxDecoration(
                        //     color: MyColors.primaryColor,
                        //     borderRadius: BorderRadius.circular(30),
                        //   ),
                        //   child: Padding(
                        //     padding: EdgeInsets.all(5),
                        //     child: Text('20% OFF',textAlign: TextAlign.center,
                        //       style: TextStyle(fontSize: 12, color: Colors.white),),
                        //   ),
                        // ),

                      ],
                    ),
                  ),

                  subtitle:  Text('Price: \$300',  style: TextStyle(
                      color: Colors.black, fontFamily: 'semibold', fontSize: 16, height: 1.3
                  ),
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(left: 10, bottom: 5, top: 5 ),
                //       child: Row(
                //         children: [
                //           Image.asset(MyImages.time_card, height: 15,),
                //           SizedBox(width: 8,),
                //           Text('Offer Valid till: 7 Aug 2022', style: TextStyle(fontSize: 12),)
                //         ],
                //       ),
                //     ),
                //     // Padding(
                //     //   padding: EdgeInsets.only(left: 10, bottom: 5, top: 5, right: 10 ),
                //     //   child: Row(
                //     //     children: [
                //     //       Image.asset(MyImages.user_card_image, height: 10,),
                //     //       SizedBox(width: 8,),
                //     //       Text('Reffered By: John Doe', style: TextStyle(fontSize: 7),)
                //     //     ],
                //     //   ),
                //     // ),
                //   ],
                // ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class Horizontalcardongoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  // height: 98,
                  color: Color(0xFFF7F7F7),
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/product.png',
                    fit: BoxFit.fitWidth,
                    width: 105,
                    height: 98,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                  title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Price: 300',  style: TextStyle(
                            color: Colors.black, fontFamily: 'semibold', fontSize: 13
                        ),
                        ),


                      ],
                    ),
                  ),

                  subtitle: Text(
                    'Macbook Pro M1',
                    style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16, bottom: 05, top: 0),
                  child: Text(
                    '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9),maxLines: 2,
                  ),
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 4),
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color:Colors.transparent,
                      // gradient: hasGradient?gradient ??
                      //     LinearGradient(
                      //       colors: <Color>[
                      //         Color(0xFF064964),
                      //         Color(0xFF73E4D9),
                      //       ],
                      //     ):null,
                      borderRadius: BorderRadius.circular(5),
                      border:Border.all(color: MyColors.primaryColor),
                    ),
                    child: Text(
                      'Mark as Recieved',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:MyColors.primaryColor,
                          fontSize: 8,
                          fontFamily: 'semibold'
                      ),
                    ),
                  ),
                ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color:MyColors.primaryColor,
                          // gradient: hasGradient?gradient ??
                          //     LinearGradient(
                          //       colors: <Color>[
                          //         Color(0xFF064964),
                          //         Color(0xFF73E4D9),
                          //       ],
                          //     ):null,
                          borderRadius: BorderRadius.circular(5),
                          border:Border.all(color: MyColors.primaryColor),
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:MyColors.whiteColor,
                              fontSize: 8,
                              fontFamily: 'semibold'
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<void>(context: context, builder: (context) => dialog1);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 0, right: 4),
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color:Colors.transparent,
                          // gradient: hasGradient?gradient ??
                          //     LinearGradient(
                          //       colors: <Color>[
                          //         Color(0xFF064964),
                          //         Color(0xFF73E4D9),
                          //       ],
                          //     ):null,
                          borderRadius: BorderRadius.circular(5),
                          // border:Border.all(color: MyColors.primaryColor),
                        ),
                        child: Text(
                          'Change Date?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:MyColors.blackColor,
                              fontSize: 8,
                              fontFamily: 'semibold'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class Horizontalcardcancel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(

              children: [
                Container(
                  // height: 98,
                  color: Color(0xFFF7F7F7),
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/product.png',
                    fit: BoxFit.fitWidth,
                    width: 105,
                    height: 98,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),

                  title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Price: 300',  style: TextStyle(
                            color: Colors.black, fontFamily: 'semibold', fontSize: 13
                        ),
                        ),


                      ],
                    ),
                  ),

                  subtitle: Text(
                    'Macbook Pro M1',
                    style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16, bottom: 05, top: 0),
                  child: Text(
                    '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9), maxLines: 2,
                  ),
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 4),
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color:MyColors.primaryColor,
                          // gradient: hasGradient?gradient ??
                          //     LinearGradient(
                          //       colors: <Color>[
                          //         Color(0xFF064964),
                          //         Color(0xFF73E4D9),
                          //       ],
                          //     ):null,
                          borderRadius: BorderRadius.circular(5),
                          border:Border.all(color: MyColors.primaryColor),
                        ),
                        child: Text(
                          'Delete',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:MyColors.whiteColor,
                              fontSize: 8,
                              fontFamily: 'semibold'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class Horizontalcardpurchaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(

              children: [
                Container(
                  // height: 98,
                  color: Color(0xFFF7F7F7),
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/product.png',
                    fit: BoxFit.fitWidth,
                    width: 105,
                    height: 98,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),

                  title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Price: 300',  style: TextStyle(
                            color: Colors.black, fontFamily: 'semibold', fontSize: 13
                        ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 50,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Rate Now',textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 6, color: Colors.white),),
                          ),
                        ),

                      ],
                    ),
                  ),

                  subtitle: Text(
                    'Macbook Pro M1',
                    style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16, bottom: 0, top: 0),
                  child: Text(
                    '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9),
                  ),
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 4),
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color:Colors.transparent,
                          // gradient: hasGradient?gradient ??
                          //     LinearGradient(
                          //       colors: <Color>[
                          //         Color(0xFF064964),
                          //         Color(0xFF73E4D9),
                          //       ],
                          //     ):null,
                          borderRadius: BorderRadius.circular(5),
                          border:Border.all(color: MyColors.primaryColor),
                        ),
                        child: Text(
                          'Mark as Recieved',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:MyColors.primaryColor,
                              fontSize: 8,
                              fontFamily: 'semibold'
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // showDialog<void>(context: context, builder: (context) => dialog;
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color:MyColors.primaryColor,
                          // gradient: hasGradient?gradient ??
                          //     LinearGradient(
                          //       colors: <Color>[
                          //         Color(0xFF064964),
                          //         Color(0xFF73E4D9),
                          //       ],
                          //     ):null,
                          borderRadius: BorderRadius.circular(5),
                          border:Border.all(color: MyColors.primaryColor),
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:MyColors.whiteColor,
                              fontSize: 8,
                              fontFamily: 'semibold'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}





class HorizontalcarddetailSupp extends StatelessWidget {
  final Map data;
  final String? agent_name;
  HorizontalcarddetailSupp({Key? key,required this.data,this.agent_name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            // flex: 5,
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                  title: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Product Code: ${data['product_code']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'semibold',
                              fontSize: 10),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/profile.png', width: 15),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                              textScaleFactor: 1,
                              text: TextSpan(
                                text: 'Qty: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                children:  <TextSpan>[
                                  TextSpan(
                                      text: '${data['stock_qty']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      ' ${data['title']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'semibold',
                          fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Price: \$${data['price']}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      hSizedBox2,
                      Text(
                        'Winao Price: \$${data['winao_price']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text('Product Rating'),
                      RatingBar(
                          itemSize:20,
                          ignoreGestures:true,
                          glow: true,
                          initialRating:double.parse(data['rating']),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(

                              full:  Icon(Icons.star, color: Colors.orange,),
                              half:  Icon(
                                Icons.star_half,
                                color: Colors.orange,
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Colors.orange,
                              )),
                          onRatingUpdate: (value) {
                            // setState(() {
                            //   // _ratingValue = value;
                            //   print('-----${_ratingValue}');
                            // });
                          }),

                    ],
                  ),
                ),
                vSizedBox2,

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            width: 20,
                          ),
                          hSizedBox,
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: 'Reffered By: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children:  <TextSpan>[
                                TextSpan(
                                    text: '${agent_name}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            width: 20,
                          ),
                          hSizedBox,

                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: 'Store Name: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children:  <TextSpan>[
                                for(var i=0;i<data['store_id'].length;i++)
                                TextSpan(
                                    text: '${data['store_id'][i]['store_name']}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            width: 20,
                          ),
                          hSizedBox,
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: 'Product Type: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children:  <TextSpan>[
                                TextSpan(
                                    text: '${data['product_type']}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/guarante.png',
                            width: 20,
                          ),
                          hSizedBox,
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: 'Product Warrenty Type: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children:  <TextSpan>[
                                TextSpan(
                                    text:data['warranty_type'],
                                    // '${data['warranty_month']}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if(data['warranty_month'].toString()!='0')
                      SizedBox(
                        height: 10,
                      ),
                      if(data['warranty_month'].toString()!='0')

                        Row(
                        children: [
                          Image.asset(
                            'assets/images/guarante.png',
                            width: 20,
                          ),
                          hSizedBox,
                          RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: 'Product Warranty Duration:',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children:  <TextSpan>[
                                TextSpan(
                                 text:data['warranty_month'].toString()!='0'?'${data['warranty_month']} month':'Without Warranty',

                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Horizontalcarddetail11 extends StatelessWidget {
  final Map data;
  final String? agent_name;
  Horizontalcarddetail11({Key? key,required this.data,this.agent_name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Row(
        children: [

          // Expanded(
          //   flex: 2,
          //   child: Column(
          //
          //     children: [
          //       Container(
          //         // height: 98,
          //         color: Color(0xFFF7F7F7),
          //         padding: EdgeInsets.all(10),
          //         child: Image.asset('assets/images/product.png',
          //           fit: BoxFit.fitWidth,
          //           width: 105,
          //           height: 98,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Expanded(
            // flex: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Code: ${data['product_code']}', style: TextStyle(fontFamily: 'regular', fontSize: 10, color: Colors.black),),
                        vSizedBox,
                        Text('Price: \$${data['price']}',  style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 18),),
                        Text('${data['title']}', style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 24),),
                        vSizedBox,
                        // Row(
                        //   children: [
                        //     Image.asset(MyImages.time_card, height: 15,),
                        //     SizedBox(width: 8,),
                        //     Text('Offer Valid till: 7 Aug 2022', style: TextStyle(fontSize: 12),)
                        //   ],
                        // ),
                        vSizedBox,
                        Row(
                          children: [
                            Image.asset(MyImages.person, height: 15,),
                            SizedBox(width: 8,),
                            Text('Reffered By : ${agent_name}', style: TextStyle(fontSize: 12),)
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Text('${data['discount']}% OFF',textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white),)
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}