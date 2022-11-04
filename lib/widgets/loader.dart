import 'package:flutter/material.dart';
import 'package:winao_client_app/widgets/ring.dart';


import '../constants/colors.dart';
late BuildContext dialogContext;
void loadingHide(context){
  Navigator.pop(dialogContext,true);
}

Future<dynamic> loadingShow(context){
  return  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      dialogContext = context;
      double h = MediaQuery.of(context).size.height;
      double w = MediaQuery.of(context).size.width;
      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.all(10),

          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
              clipBehavior: Clip.none,
              children:[
                Container(
                    width: double.infinity,
                    // height: 200,
                    child:
                    Padding(
                      padding:EdgeInsets.all(16),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                clipBehavior: Clip.none,



                                width:(MediaQuery.of(context).size.width - 70),
                                // padding:EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child:SpinKitRing(
                                  color: MyColors.primaryColor,
                                  size: 50.0,
                                )

                                ,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              ]
          )

      );
    },
  ).then((exit) {
    if (exit == null) return;

  });
}