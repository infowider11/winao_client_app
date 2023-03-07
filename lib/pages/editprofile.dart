
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/image_urls.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/image.dart';
import '../widgets/image_picker.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';

class EditProfile extends StatefulWidget {
  static const String id = "editprofile";

  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
 String image1='';
  bool load=false;
  File? image;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    // get_user_detail();
    autofill();

  }
  autofill()async{
    var user= await getUserDetails();
    print('1234556'+user.toString());
    firstnameController.text=user['f_name'];
    lastnameController.text=user['l_name'];
    emailController.text=user['email'];
    image1 = user['image'];

    setState(() {
      print('sert-------------------------');

    });
  }

  get_user_detail() async{
    setState(() {
      // load=true;
    });
    Map <String, dynamic> request = {
      'user_id':await getCurrentUserId(),
    };
    Map res = await Webservices.getMap(ApiUrls.getuserbyid,request:request);
    print('res----$res');
  }

  void _showImage_popup(BuildContext ctx,) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: () async {
                  image = await pickImage(false);
                  print('image----$image');
                  Map<String,dynamic> data ={
                    'user_id':await getCurrentUserId()
                  };
                  Map<String,dynamic>files = {
                    // 'cover_image':image,
                  };


                  if(image!=null){
                    files["image"]=image;
                  }
                  var jsonResponse = await Webservices.postDataWithImageFunction(body: data, files: files,context: context,apiUrl: ApiUrls
                      .edit_profile_image,);
                  print('object 123456'+jsonResponse.toString());
                  if(jsonResponse['status'].toString()=='1'){
                    updateUserDetails(jsonResponse['data']);
                    await autofill();
                    // Navigator.pop(context);
                  }
                  setState(() {
                  });
                  _close(ctx);
                },
                child: const Text('Take Camera')),
            CupertinoActionSheetAction(
                onPressed: () async {
                  // images = [];
                  print('ddd');
                  image = await pickImage(true);
                  print('image----$image');
                  Map<String,dynamic> data ={
                    'user_id':await getCurrentUserId()
                  };
                  Map<String,dynamic>files = {
                    // 'cover_image':image,
                  };


                  if(image!=null){
                    files["image"]=image;

                  }
                  var jsonResponse = await Webservices.postDataWithImageFunction(body: data, files: files,context: context,apiUrl: ApiUrls
                      .edit_profile_image,);
                  if(jsonResponse['status'].toString()=='1'){
                    // Navigator.pop(context);
                    updateUserDetails(jsonResponse['data']);
                    await autofill();
                  }
                  setState(() {

                  });
                  _close(ctx);
                },
                child: const Text('Gallery')),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => _close(ctx),
            child: const Text('Close'),
          ),
        ));
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainHeadingText(
                    text: 'Edit Profile',
                    color: MyColors.blackColor,
                    textAlign: TextAlign.left,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                  vSizedBox4,

                  // GestureDetector(
                  //   onTap: (){
                  //     _showImage_popup(context);
                  //
                  //   },
                  //   child: Center(
                  //     child: Container(
                  //       height: 100,
                  //       width: 100,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(50),
                  //           image:image!=null?
                  //               DecorationImage(
                  //                 image: FileImage(
                  //                   image!
                  //                 ),
                  //                 fit: BoxFit.cover,
                  //               ):
                  //           DecorationImage(
                  //             // image:image,
                  //             image:AssetImage(
                  //               MyImages.profile,
                  //             ),
                  //             fit: BoxFit.cover,
                  //           ),
                  //       ),
                  //       // child: Image.asset(MyImages.profile),
                  //
                  //
                  //
                  //     ),
                  //   ),
                  // ),
                  // vSizedBox,
                  // GestureDetector(
                  //   onTap: (){
                  //     _showImage_popup(context);
                  //   },
                  //   child: Center(
                  //     child: MainHeadingText(
                  //       text: 'Change Image',
                  //       textAlign: TextAlign.center,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // vSizedBox,
                  GestureDetector(
                    onTap:  () async {
                      _showImage_popup(context);
                    },
                    child: Center(
                      child: CustomCircularImage(
                        imageUrl:image1,
                        image: image,
                        height: 95,
                        fileType: image==null?CustomFileType.network:CustomFileType.file,
                        width: 95,

                      ),
                    ),
                  ),
                  vSizedBox,
                  GestureDetector(
                    onTap: (){
                      _showImage_popup(context);
                    },
                    child: Center(
                      child: MainHeadingText(
                        text: 'Change Image',
                        textAlign: TextAlign.center,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  vSizedBox,

                  CustomTextField(
                    controller: firstnameController,
                    hintText: 'first name',
                    prefixIcon: 'assets/images/user.png',
                    borderColor: Color(0xffd9d9d9),
                    borderradius: 15,
                  ),
                  CustomTextField(
                    controller: lastnameController,
                    hintText: 'last name',
                    prefixIcon: 'assets/images/user.png',
                    borderColor: Color(0xffd9d9d9),
                    borderradius: 15,
                  ),
                  CustomTextField(
                    controller: emailController,
                    enabled: false,
                    hintText: 'johndoe@gmail.com',
                    prefixIcon: 'assets/images/email.png',
                    borderColor: Color(0xffd9d9d9),
                    borderradius: 15,
                  ),
                  vSizedBox,
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RoundEdgedButton(
                  text: 'Update',
                  color:Color(0xff004173),
                  textColor: Colors.white,
                  boderRadius: 15,
                  onTap: () async {
                    // Navigator.pushNamed(context, SignInPage.id);

                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (firstnameController.text == '') {
                      showSnackbar(context, 'Please Enter your Firstname.');
                    }
                    else if (lastnameController.text == '') {
                      showSnackbar(context, 'Please Enter your Lastname.');
                    }
                    else if (emailController.text == '') {
                      showSnackbar(context, 'Please Enter your Email.');
                    }
                    else if (!regex.hasMatch(emailController.text)) {
                      showSnackbar(context, 'Please Enter your valid email.');
                    }
                    else {
                      Map<String, dynamic> data = {
                        // "user_id":user_data!['id'],
                        'user_id':await getCurrentUserId(),
                        'f_name': firstnameController.text,
                        'l_name': lastnameController.text,
                        // 'phone':'12333',
                        // 'address':'',
                        // 'bio':'',
                      };
                      print("data sent for edit profile"+data.toString());
                      loadingShow(context);

                      var res = await Webservices.postData(
                          apiUrl: ApiUrls.edit_profile,
                          body: data,
                          context: context,
                          showSuccessMessage: true);
                      loadingHide(context);
                      print("Api response" + res.toString());
                      if (res['status'].toString() == '1') {
                        // updateUserDetails(res);
                        updateUserDetails(res['data']);
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              )),

        ],
      ),
    );
  }
}
