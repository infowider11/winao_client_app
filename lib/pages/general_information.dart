import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';

import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/newloader.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({Key? key}) : super(key: key);

  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  String aboutuscontent='';
  bool load=false;

  void initState() {
    // TODO: implement initState
    super.initState();
    aboutus();


  }

  aboutus() async{
    setState(() {
      load=true;
    });
    Map <String, dynamic> request = {
      // 'user_id':await getCurrentUserId(),
    };
    Map res = await Webservices.getMap(ApiUrls.about);
    print("About api response----" + res.toString());

    aboutuscontent = res['content'];
    print("Aboutuscontent----" + aboutuscontent);
    setState(() {
      load=false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body:load?CustomLoader(): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Html(
              data:aboutuscontent
            // data:'<p>aboutuscontent<\/p>'
          ),

          // child: ListView(
          //   children: [
          //     MainHeadingText(text: 'ABOUT US', textAlign: TextAlign.center, fontFamily: 'semibold', fontSize: 24,),
          //     vSizedBox4,
          //     ParagraphText(text: ,
          //       fontSize: 14,
          //       fontFamily: 'regular',),
          //     vSizedBox4,
          //
          //   ],
          // ),
        ),
      ),
    );
  }
}
