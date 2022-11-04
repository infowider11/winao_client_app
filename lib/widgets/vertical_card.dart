import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/pages/checkout.dart';

class Verticalcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF7A7A7A), width: 1),
      ),

      elevation: 0,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 98,
                width: double.infinity,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.all(8),
                child: Image.asset('assets/images/box.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text('20% OFF', style: TextStyle(fontFamily: 'regular', fontSize: 8, color: MyColors.whiteColor),),
                ),
              )
            ],
          ),

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
            title: Text('Price: 300',  style: TextStyle(
                color: Colors.black, fontFamily: 'semibold', fontSize: 13
            ),),
            subtitle: Text(
              'Macbook Pro M1',
              style: TextStyle(color: Colors.black, fontFamily: 'semibold', fontSize: 15),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 16, bottom: 0, top: 0),
            child: Text(
              '96W USB‑C Power Adapter included as free upgrade with selection of M1 Pro with 10‑core CPU...',
              style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 10),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 0, top: 8 ),
            child: Row(
              children: [
                Image.asset(MyImages.time_card, height: 15,),
                SizedBox(width: 8,),
                Text('Offer Valid till: 7 Aug 2022', style: TextStyle(fontSize: 9),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 8 ),
            child: Row(
              children: [
                Image.asset(MyImages.user_card_image, height: 15,),
                SizedBox(width: 8,),
                Text('Reffered By: John Doe', style: TextStyle(fontSize: 9),)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Checkout.id);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add to cart', style: TextStyle(fontFamily: 'regular', color: Colors.white, fontSize: 10),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}