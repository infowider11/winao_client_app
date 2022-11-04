import 'package:flutter/material.dart';

import '../constants/colors.dart';
class adderss extends StatelessWidget {
  final bool isselected;
  final String text;
  const adderss({Key? key,
    required this.isselected,
    required this.text


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width:50,
      // height:200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Color(0xffdee2e6).withOpacity(0.5),
          border:isselected? Border.all(color:MyColors.primaryColor, width:1,):null),
      // margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      child: Text(text),



    );
  }
}


