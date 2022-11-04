import 'package:flutter/material.dart';

class DrawerButtons extends StatelessWidget {

  final String text;
  final Function() onTap;
  const DrawerButtons({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          Icon(Icons.arrow_forward_ios, size: 20,)
        ],
      ),
    );
  }
}
