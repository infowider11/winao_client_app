import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/newloader.dart';

class trems extends StatefulWidget {
  const trems({Key? key}) : super(key: key);

  @override
  State<trems> createState() => _tremsState();
}

class _tremsState extends State<trems> {
  @override
  String termscontent='';
  bool load=false;

  void initState() {
    // TODO: implement initState
    super.initState();
    terms();


  }

  terms() async{
    setState(() {
      load=true;
    });
    Map <String, dynamic> request = {
      // 'user_id':await getCurrentUserId(),
    };

    Map res = await Webservices.getMap(ApiUrls.terms);

    print("terms api response----" + res.toString());

    termscontent = res['content'];
    print("Termscontent----" + termscontent);
    setState(() {
      load=false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body:load?CustomLoader():Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Html(
            data:termscontent
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
