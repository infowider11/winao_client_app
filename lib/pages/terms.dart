import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/appbar.dart';
import '../widgets/newloader.dart';
import '../widgets/showSnackbar.dart';

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
      appBar: appBar(context: context,title:'Terms and Conditions',titleColor: Colors.black),
      body:load?CustomLoader():SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Html(
              data:termscontent,
            onLinkTap: (url,a,b,c)async {
              print('the uuuu is $url');
              if(url!=null){
                // url.replaceAll('https://wincomis.com/', '');
                // url ='https://wincomis.com/'+ url;
                print('the uuuu is $url');
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw showSnackbar(context,'Page not found. ${url}');
                }
              }
            },
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
