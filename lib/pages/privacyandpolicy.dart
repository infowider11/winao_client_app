import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/newloader.dart';
class privacy extends StatefulWidget {
  const privacy({Key? key}) : super(key: key);

  @override
  State<privacy> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  String privacycontent='';
  bool load=false;
  void initState() {
    // TODO: implement initState
    super.initState();
    privacy();


  }

  privacy() async{
    setState(() {
      load=true;
    });
    Map <String, dynamic> request = {
      // 'user_id':await getCurrentUserId(),
    };
    Map res = await Webservices.getMap(ApiUrls.privacy);
    print("privacy api response----" + res.toString());

    privacycontent = res['content'];
    print("Privacycontent----" + privacycontent);
    setState(() {
      load=false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Html(
            data:privacycontent
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
    );
  }
}
