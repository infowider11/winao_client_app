import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/checkout.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/horizontal_card.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

class Detail_page extends StatefulWidget {
  final Map productdata;
  final String? agent_name;
  static const String id="detail";
   Detail_page({Key? key,
     required this.agent_name,
    required this.productdata,

  }) : super(key: key);

  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  TextEditingController codeController = TextEditingController();
  List<dynamic> imgList=[] ;
  int _currentIndex = 0;


  @override
  initState() {
    // super.initState();
    // Add listeners to this class
    imgList = widget.productdata['images']??[];
    setState((){});
    log("Images........");
    log('${imgList}');

    // log(productdata['images']);

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar(context: context,),
      body: Container(
        child: ListView(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1,
                        initialPage: 0,
                        enlargeCenterPage: false,
                        disableCenter: true,
                        reverse: false,
                        enableInfiniteScroll: false,
                        // pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          log('page changed ');
                          setState(
                                () {
                              _currentIndex = index;
                            },
                          );
                        },
                      ),
                      /*

                        for(var i=0;i<widget.productdata!['images'].length;i++){
                        var img = widget.productdata!['images'][i];
                        img['image'];

                        }


                       */



                      items: imgList.map((dynamic img) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                                children: <Widget>[

                                  // new Expanded(
                                  //   child: new Image.asset(.3
                                  // SizedBox(height: 70),

                            Image(

                              image: NetworkImage(img['image'].toString(),),
                              height:400,
                            )]
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                        child: Container(
                          // height: 250,
                          margin: EdgeInsets.only(top: 24, left:  0),
                          child: Center(
                            child:  AnimatedSmoothIndicator(
                              activeIndex: _currentIndex,
                              count:  3,
                              effect: ExpandingDotsEffect(
                                // activeStrokeWidth: 2.6,
                                // activeDotScale: 1.3,
                                // maxVisibleDots: 5,
                                radius: 8,
                                spacing: 6,
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.white,
                                dotColor: Colors.white30,

                              ),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
                // Horizontalcarddetail(data:widget.productdata,agent_name:widget.agent_name),
                HorizontalcarddetailSupp(data:widget.productdata,agent_name:widget.agent_name),

                Divider(
                  height: 40,
                  thickness: 3,
                  color: Color(0xFFF2F4FF),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: MainHeadingText(
                    text: 'Description:', fontSize: 15, fontFamily: 'regular',color: Colors.blueAccent,fontWeight: FontWeight.bold,)
                ),

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  // child: ParagraphText(
                  //   text: 'The displays on the 14-inch and 16-inch'
                  //       ' MacBook Pro have rounded corners at the top.'
                  //       ' When measured as a standard rectangular shape, '
                  //       'the screens are 14.2 inches and 16.2 inches diagonally '
                  //       '(actual viewable area is less).\nTesting conducted by Apple in October 2020 using pre-production'
                  //       ' 13‑inch MacBook Pro systems with Apple M1 chip,'
                  //       ' as well as production 1.7GHz quad‑core Intel Core i7–based 13‑inch MacBook Pro systems.',
                  //   fontSize: 15,
                  //    fontFamily: 'regular',
                  // ),
                  child:
                    Html(
                      data:widget.productdata['description']??''
                    )
                  ),


                  // Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  //   child: Row(
                  //     children: [
                  //       MainHeadingText(text: 'Product Type:', fontSize: 13, fontFamily: 'regular', color: MyColors.grey,),
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  //        child: MainHeadingText(text: '${widget.productdata['product_type']}', fontSize: 13, fontFamily: 'regular',)
                  //       )
                  //     ],
                  //   ),
                  // ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //   child: Row(
                //     children: [
                //       MainHeadingText(text: 'Series:', fontSize: 13, fontFamily: 'regular', color: MyColors.grey,),
                //       Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                //           child: MainHeadingText(text: ' ${widget.productdata['product_type']}', fontSize: 13, fontFamily: 'regular',)
                //       )
                //     ],
                //   ),
                // ),
                //
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //   child: Row(
                //     children: [
                //       MainHeadingText(text: 'Color:', fontSize: 13, fontFamily: 'regular', color: MyColors.grey,),
                //       Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                //           child: MainHeadingText(text: 'Platinum Grey', fontSize: 13, fontFamily: 'regular',)
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //   child: Row(
                //     children: [
                //       MainHeadingText(text: 'Warranty:', fontSize: 13, fontFamily: 'regular', color: MyColors.grey,),
                //       Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                //           child: MainHeadingText(text: '1 Year Warranty Term', fontSize: 13, fontFamily: 'regular',)
                //       )
                //     ],
                //   ),
                // ),

               CustomDivider(),
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(MyImages.dashed),
                          fit: BoxFit.contain,
                          alignment: Alignment.topLeft
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.productdata['product_code']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'bold',
                          letterSpacing: 1
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
                vSizedBox,

                // Padding(
                // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                // child:RoundEdgedButtonred(
                //   text: 'Add to cart', color: MyColors.primaryColor,
                //   onTap: (){
                //     Navigator.pushNamed(context, Checkout.id);
                //   },
                // )
                // )



              ],
        ),
      ),
    );
  }
}
