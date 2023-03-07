import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
class RoundEdgedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  final double? boderRadius;
  final Color? textColor;
  // final Gradient? gradient;
  final bool isSolid;

  const RoundEdgedButton(
      {Key? key,
        this.color = Colors.white,
      required this.text,
      this.onTap,
        this.horizontalMargin=0,
        this.boderRadius=30,
        this.textColor=MyColors.primaryColor,
        // required this.hasGradient,
      this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: 12),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(boderRadius!),
          border:isSolid?null: Border.all(color: color),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:isSolid? textColor:color,
            fontSize: 18,
            fontFamily: 'regular'
          ),
        ),
      ),
    );
  }
}


class RoundEdgedButtonred extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  final Color? textColor;
  // final Gradient? gradient;
  final bool isSolid;

  const RoundEdgedButtonred(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        this.textColor=MyColors.whiteColor,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border:isSolid?null: Border.all(color: color),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:isSolid? textColor:color,
              // color:isSolid? MyColors.whiteColor:color,
              fontSize: 18,
              fontFamily: 'semibold'
          ),
        ),
      ),
    );
  }
}



class TransparentButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  const TransparentButton(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border:isSolid?null: Border.all(color: color),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:color,
              fontSize: 18,
              fontFamily: 'semibold'
          ),
        ),
      ),
    );
  }
}

class Borderbutton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  const Borderbutton(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: MyColors.primaryColor),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 18,
              fontFamily: 'semibold'
          ),
        ),
      ),
    );
  }
}
