// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants/colors.dart';

class NotificationCard extends StatelessWidget {
  final bool image;
  final Map data;
  NotificationCard({
    Key? key,
    this.image = true,
    required this.data
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Color(0xFFF7F7F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // if (image)
            //   Expanded(
            //     flex: 2,
            //     child: Column(
            //       children: [
            //         Container(
            //           // height: 98,
            //           color: Color(0xFFF7F7F7),
            //           padding: EdgeInsets.all(0),
            //           child: Image.asset(
            //             'assets/images/product.png',
            //             fit: BoxFit.fitWidth,
            //             // width: 105,
            //             // height: 98,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 16, bottom: 5, top: 0),
                    child: Html(
                        data:data['message'],
                    ),
                    // Text(
                    //   '${data['message']}',
                    //   // 'The Client johndoe@gmail.com is booked Mac Pro M1 using your referral code and now to deliver.',
                    //   style: TextStyle(
                    //       color: MyColors.blackColor,
                    //       fontSize: 11,
                    //       fontFamily: '',
                    //       height: 1),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 16, bottom: 0, top: 0),
                    child: Text(
                      '${data['created_at']}',
                      style: TextStyle(color: MyColors.blackColor, fontSize: 9),
                    ),
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