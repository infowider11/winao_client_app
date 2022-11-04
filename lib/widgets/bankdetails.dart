import 'package:flutter/material.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';

import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
class bankdetails extends StatefulWidget {
  // final String? bankname;
  // final String?  Typeofaccoun;
  // final String?  AccountNumber;
  // final String?  Email;
  // final String? bank;
  // final String? AccountHolder;
  // final String? Ciudad;
  // final String? RUCNumber;
  final String? data;
  const bankdetails({Key? key,
    this.data
    // this.bankname,
    // this.bank,
    // this.Typeofaccoun,
    // this.AccountNumber,
    // this.Email,
    // this.AccountHolder,
    // this.Ciudad,
    // this.RUCNumber,


  }) : super(key: key);

  @override
  State<bankdetails> createState() => _bankdetailsState();
}

class _bankdetailsState extends State<bankdetails> {
  List<dynamic> adminbankdetails = [];
  String selectedIndex = '';
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getbankdetails();
    print('${widget.data}');
  }

  getbankdetails() async {
    var res = await Webservices.getList('${ApiUrls.adminbankdetails}');
for(var i=0;i<adminbankdetails.length;i++)
    // adminbankdetails = res['data'];
    print('getbankdetails...................$res');
    adminbankdetails= res;
    setState(() {  });
    print('adminbankdetails...................$adminbankdetails');

  }

  Widget build(BuildContext context) {
    return
      Container(
      child: Column(
        children: [
          for(var i=0;i<adminbankdetails.length;i++)
            if('${adminbankdetails[i]['id']}'==widget.data)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Bank Name :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['bank_name']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Type of account :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['type_of_account']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Account Number :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['account_no']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Email : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['email']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Account Holder :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['account_holder']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'Ciudad : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['ciudad']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( 'RUC Number :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  Text('${adminbankdetails[i]['ruc_no']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.blueGrey),)
                ],
              ),
              vSizedBox2,
              // for(var i=0;i<adminbankdetails.length;i++)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text( 'BANK IMAGES',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
              //     // NetworkImage("https://bluediamondresearch.com/WEB01/Winao/assets/uploads/20899560661652542196.png"),
              //     // Image.network("https://bluediamondresearch.com/WEB01/Winao/assets/uploads/20899560661652542196.png"),
              //     Image.network('${adminbankdetails[i]['image']}'),
              //   ],
              // ),
              vSizedBox2
            ],

          )
        ],
      ),
    );





  }
}
