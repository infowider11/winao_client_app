// import 'dart:developer';
// import 'dart:html';
// import 'dart:io';
//
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/bottomnavigation.dart';
import 'package:winao_client_app/pages/support.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/newloader.dart';

import '../constants/colors.dart';
import 'package:intl/intl.dart';

import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
// import '../widgets/CustomTexts.dart';
import '../widgets/customtextfield.dart';
import '../widgets/image.dart';
import '../widgets/image_picker.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
import '../widgets/star.dart';
import 'home.dart';
import 'myorder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart' as p;
// import 'package:open_file/open_file.dart';
class ManageOrdersPage extends StatefulWidget {
  final String orderid;
  // final String refid;
  final Map orderData;
  const ManageOrdersPage({
    Key? key,
    required this.orderData,
    required this.orderid,
  }) : super(key: key);

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  String dropdownvalue = '24hours';
  String accounttype = 'Ahhoros';

  // List of items in our dropdown menu
  var items = [
    '24hours',
    '36hours',
    '48hours',
    '72hours',
    '96hours',
  ];
  var items1 = [
    'Ahhoros',
    'o corriente',
  ];

  TextEditingController demoController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController accountnoController = TextEditingController();
  TextEditingController accountholderController = TextEditingController();
  TextEditingController cedularucController = TextEditingController();
  TextEditingController account_typeController = TextEditingController();

  TextEditingController idController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController extendtimeController = TextEditingController();
  bool load = true;
  String? fileExt;

  @override
  String orderdate = '';
  String recomendate = '';
  String paymentmethod = '';
  String paymentstatus = '';

  String address = '';
  String selectedindex = '';
  Map Getorderdetails = {};
  List<dynamic> adminbankdetails = [];
  String payerID = '';
  String paymentId = '';
  String? user_id;
  double? _ratingValue;
  String image2 = '';
  // bool load=false;
  File? image1;
  // List image1 = [];
  List product = [];
  Map data = {};
  Map userdetails = {};
  bool? userLoggedIn;
  int downloadStatus = 0;
  String? targetPath;
  double filesize = 00;

  void initState() {
    // TODO: implement initState
    print('the dacfta is ${widget.orderData}');
    print('orderidddd.... ${widget.orderid}');
    super.initState();
    getuserdetail();
    getorderdetails();
    getbankdetails();
    iserlogin();
    // markAsSeen();
  }
  markAsSeen(idd)async{
    print('${widget.orderid}--seen--------order_id${idd}');

    var id = await getCurrentUserId();
    var res = await Webservices.getList('${ApiUrls.markasseen}?is_seen=1&recommended_id=${idd}');
    print('${res}');
  }
  // PDF DOWNLOAD 2 FUNCTION

  pathfunction() {
    var _downloadsDirectory = getDownloadsDirectory();
  }

  downloadfolderpath() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    String downloadfolderpath = '';
    if (dir != null) {
      downloadfolderpath = dir.path;
      print(
          'downloadfolderpath---------${downloadfolderpath}'); //output: /storage/emulated/0/Download
      setState(() {
        //refresh UI
      });
    } else {
      print("No download folder found.");
    }
    return downloadfolderpath;
  }

  Future<String> getPathToDowload() async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // print('The path is');
    // print(appDocPath);

    List<Directory>? appDocDir = await getExternalStorageDirectories();
    print('appDocDir--------------${appDocDir!.length}');
    String appDocPath = appDocDir[0].path;
    print('appDocPath-----${appDocPath}');
    String appDocPathnew =
        appDocPath.toString().split('/Android')[0].toString();
    print('appDocPathnew---------${appDocPathnew}');
    return appDocPath;
  }

  Future<String> savePdfToStorage(
      String url, targetPath, targetFilename) async {
    //comment out the next two lines to prevent the device from getting
    // the image from the web in order to prove that the picture is
    // coming from the device instead of the web.

    // var targetPath = await getPathToDowload();

    var response = await get(Uri.parse(url)); // <--2

    print('the url is__________________________________$url');

    String path = await downloadfolderpath();
    // String path = '/storage/emulated/0/Download';

    var firstPath = targetPath;
    var filePathAndName = path + '/' + targetFilename;
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet

    // final taskId = await FlutterDownloader.enqueue(
    //     url:url,
    //     savedDir: path,
    //     showNotification: true, // show download progress in status bar (for Android)
    //     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    //     fileName: targetFilename
    // );
    await Directory(firstPath).create(recursive: true);
    //
    //
    // // <-- 1
    File file2 = new File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes);
    print(' the file name is $filePathAndName'); // <-- 3;
    return filePathAndName;
  }

  iserlogin() async {
    userLoggedIn = await isUserLoggedIn();
    print('userLoggedIn----------${userLoggedIn}');
  }

  getuserdetail() async {
    var user = await getUserDetails();
    userdetails = user;
    print('userdetails------${userdetails}');
    print('userdetails------${userdetails['image']}');
  }

  getorderdetails() async {
    setState(() {
      load = true;
    });
    var res = await Webservices.getMap(
        '${ApiUrls.orderdetails}?order_id=${widget.orderid}');
    // data=res['data'];
    paymentmethod = res['payment_method'];
    paymentstatus = res['payment_status'];
    print('payment methode------${paymentmethod}');
    print('payment methode------${res}');
    markAsSeen(res['recommendation']['id']);
    setState(() {
      load = false;
    });
    // print()
    var dis = 0;
    for (var i = 0; i < res['products'].length; i++) {
      dis = dis +
          (int.parse(res['products'][i]['product']['price']) -
                  int.parse(res['products'][i]['product']['winao_price'])) *
              int.parse(res['products'][i]['quantity'].toString());
      print('object ${dis}');
    }
    res['discountt'] = dis;

    Getorderdetails = res;
    print('Getorderdetails.....${Getorderdetails}');
    Getorderdetails['totall'] =
        double.parse(Getorderdetails['grand_total'].toString()) +
            double.parse(Getorderdetails['shipping_cost'].toString());
    Getorderdetails['grand_total_new'] =
        (dis + double.parse(Getorderdetails['grand_total'].toString())).toString();
    print('Getorderdetails..........${Getorderdetails['totall']}');
    print('createdate..........${res['created']}');
    orderdate = res['created'];
    recomendate = res['recommendation']['created_at'];
    product = res['products'];

    print('products..${product}');
    print('orderdate    858..${orderdate}');

    address = res['address'];
    print('address..${address}');
    setState(() {});
  }

  getbankdetails() async {
    var res = await Webservices.getList('${ApiUrls.adminbankdetails}');
    adminbankdetails = res;
    print('adminbankdetails...................$adminbankdetails');
  }

  onSuccessPaypal(Map params) async {
    try {
      loadingShow(context);
    } catch (e) {}

    Map<String, dynamic> data = {
      'trasnId': params['data']['cart'],
      'order_id': Getorderdetails['id'],
    };
    log('Dataforcheckout...........${data}');
    var res = await Webservices.postData(
        apiUrl: ApiUrls.updatepayment,
        body: data,
        context: context,
        showSuccessMessage: true);
    log('checkoutapires...........${res}');
    // print('checkoutapires...........${res['status'].toString()}');
    if (res['status'].toString() == '1') {
      // loadingHide(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyorderPage()));
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            elevation: 16,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 250.0,
              width: 100.0,
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Thank You!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  vSizedBox,
                  Center(
                    child: Text(
                      'Order Placed Successfully..!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'regular',
                      ),
                    ),
                  ),
                  vSizedBox,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: MyColors.primaryColor,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
    try {
      loadingHide(context);
    } catch (e) {}
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future _showImage_popup(
    BuildContext ctx,
  ) async {
    await showCupertinoModalPopup(
        context: ctx,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () async {
                        print('press1 cermera function');
                        image1 = await pickImage(false);
                        log('imageurl-------${image1}');
                        setState(() {});
                        log('image1----$image1');
                        setState(() {});
                        _close(ctx);
                      },
                      child: const Text('Take Camera')),
                  CupertinoActionSheetAction(
                      onPressed: () async {
                        // images = [];
                        print('ddd');
                        image1 = await pickImage(true);
                        setState(() {});
                        print('image----$image1');
                        Map<String, dynamic> data = {
                          'user_id': await getCurrentUserId(),
                          'order_id': Getorderdetails['order_uniqueid'],
                        };
                        Map<String, dynamic> files = {
                          // 'cover_image':image,
                        };

                        if (image1 != null) {
                          files["receipt_image"] = image1;
                        }
                        var jsonResponse =
                            await Webservices.postDataWithImageFunction(
                          body: data,
                          files: files,
                          context: context,
                          apiUrl: ApiUrls.edit_profile_image,
                        );
                        if (jsonResponse['status'].toString() == '1') {
                          // Navigator.pop(context);
                          updateUserDetails(jsonResponse['data']);
                          // await autofill();
                        }
                        setState(() {});
                        _close(ctx);
                      },
                      child: const Text('Gallery')),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => _close(ctx),
                  child: const Text('Close'),
                ),
              );
            }));
  }

  ongoingScreen({required BuildContext context, required Map bank}) {
    return Container(
      // ongoingData.length==0
      margin: EdgeInsets.only(top: 80),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bank Name :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['bank_name']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Type of account :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['type_of_account']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Account Number :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['account_no']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Email : ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['email']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Account Holder :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['account_holder']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ciudad : ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['ciudad']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'RUC Number :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    '${bank['ruc_no']}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueGrey),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:MyColors.primaryColor,
        title: Text(''),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyStatefulWidget(key: MyGlobalKeys.tabBarKey,)));
          }, icon: Icon(Icons.home))
        ],
      ),
      body: load
          ? CustomLoader()
          : Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${Getorderdetails['order_uniqueid']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold),
                  ),

                  // if(orderdate!='')
                  Text(
                    'Order Date : ${DateFormat.yMMMd().format(DateTime.parse(orderdate.toString()))}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),

                  // Text('Recommended Date : ${DateFormat.yMMMd().format(DateTime.parse(recomendate))}',
                  Text(
                    'Recommended Date : ${recomendate}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  vSizedBox2,

                  Text(
                    'Item Ordered :',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  vSizedBox,

                  for (var i = 0; i < product.length; i++)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          border: Border(
                              bottom: BorderSide(
                                  color: MyColors.greyColor, width: 1))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product[i]['product']['title'].toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$" +
                                    (double.parse(product[i]['product']
                                                    ['winao_price']
                                                .toString()) *
                                            int.parse(product[i]['quantity']))
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xff004173)),
                              ),
                            ],
                          ),
                          vSizedBox05,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: MyColors.greyColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              product[i]['product_status'].toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                            // paymentstatus=='1'?product[i]['product_status'].toString():'waiting for payment', style: TextStyle(fontSize: 14),
                          ),
                          vSizedBox2,
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Price: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.blackColor,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$' +
                                            product[i]['product']['price'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              hSizedBox2,
                              RichText(
                                text: TextSpan(
                                  text: 'Qty: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.blackColor,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: product[i]['quantity'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          vSizedBox05,

                          //---------ALL ACTIONS HERE-------------

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              if ((paymentstatus == '2' ||
                                      paymentstatus == '0') &&
                                  ((Getorderdetails['payment_method'] ==
                                          'Bank') &&
                                      (product[i]['status'].toString() == '1')))
                              //-----pending
                                Row(

                                  children: [
                                    Text('Payment Status :'),
                                    Text(
                                      'Pending',
                                      style:
                                          TextStyle(color: MyColors.redColor),
                                    )
                                  ],
                                ),
                              if (((paymentstatus == '1') &&
                                      (product[i]['ship_status'].toString() ==
                                          '1')) &&
                                  (product[i]['status'].toString() == '1') &&
                                  (userLoggedIn == true))
                              //------ I received the product
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context1) {
                                          return AlertDialog(
                                            title: Text(
                                              'Received',
                                            ),
                                            content: Text('Are you sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context1);
                                                    Map<String, dynamic> data =
                                                        {
                                                      // 'user_id':await getCurrentUserId(),
                                                      'item_id': product[i]
                                                          ['id'],
                                                      // 'seller_id':product[i]['seller_id'],
                                                      // 'product_id':product[i]['product_id'],
                                                      // 'rating':_ratingValue,
                                                      // 'message':feedbackController.text,
                                                    };
                                                    print('data----$data');
                                                    loadingShow(context);
                                                    var res = await Webservices
                                                        .postData(
                                                      body: data,
                                                      context: context,
                                                      apiUrl: ApiUrls
                                                          .markasdeliveredforcustomer,
                                                    );
                                                    log('markasdeliveredforcustomer--------' +
                                                        res.toString());
                                                    loadingHide(context);

                                                    if (res['status']
                                                            .toString() ==
                                                        '1') {
                                                      getorderdetails();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0)),
                                                              elevation: 16,
                                                              child: Container(
                                                                // padding: EdgeInsets.symmetric(horizontal:10),
                                                                height: 220,
                                                                // width: 360.0,
                                                                child: Column(
                                                                  children: [
                                                                    vSizedBox,
                                                                    vSizedBox,
                                                                    Text(
                                                                      'How was the product ?',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    vSizedBox,
                                                                    RatingBar(
                                                                        initialRating:
                                                                            0,
                                                                        direction:
                                                                            Axis
                                                                                .horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        ratingWidget: RatingWidget(
                                                                            full: const Icon(Icons.star, color: Colors.orange),
                                                                            half: const Icon(
                                                                              Icons.star_half,
                                                                              color: Colors.orange,
                                                                            ),
                                                                            empty: const Icon(
                                                                              Icons.star_outline,
                                                                              color: Colors.orange,
                                                                            )),
                                                                        onRatingUpdate: (value) {
                                                                          setState(
                                                                              () {
                                                                            _ratingValue =
                                                                                value;
                                                                            print('-----${_ratingValue}');
                                                                          });
                                                                        }),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              0),
                                                                      child:
                                                                          TextField(
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xff969BA0)),
                                                                        controller:
                                                                            feedbackController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintStyle: TextStyle(
                                                                              fontSize: 30.0,
                                                                              color: Color(0xff969BA0)),
                                                                          enabledBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 0.5, color: Color(0xff969BA0)),
                                                                          ),
                                                                          labelText:
                                                                              'Review (*)',
                                                                          labelStyle:
                                                                              new TextStyle(color: Color(0xff969BA0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    vSizedBox,
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          // padding: EdgeInsets.all(15),
                                                                          child:
                                                                              ElevatedButton(
                                                                            child:
                                                                                Text(
                                                                              "Submit",
                                                                              style: TextStyle(fontSize: 15),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              Map<String, dynamic> data = {
                                                                                'user_id': await getCurrentUserId(),
                                                                                'item_id': product[i]['id'].toString(),
                                                                                'seller_id': product[i]['seller_id'].toString(),
                                                                                'product_id': product[i]['product_id'].toString(),
                                                                                'rating': _ratingValue.toString(),
                                                                                'message': feedbackController.text,
                                                                              };
                                                                              print('data----$data');
                                                                              if (_ratingValue == '') {
                                                                                showSnackbar(context, 'Please Enter your feedback.');
                                                                              } else if (feedbackController.text == '') {
                                                                                showSnackbar(context, 'Please Enter your feedback.');
                                                                              }
                                                                              var res = await Webservices.postData(
                                                                                body: data,
                                                                                context: context,
                                                                                apiUrl: ApiUrls.submitrating,
                                                                              );
                                                                              log('markasdeliveredforcustomer--------' + res.toString());
                                                                              if (res['status'].toString() == '1') {
                                                                                getorderdetails();
                                                                                setState(() {});
                                                                                Navigator.pop(context);
                                                                                showSnackbar(context, 'Thank you for rating.');
                                                                              }
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: StadiumBorder(),
                                                                              primary: MyColors.primaryColor,
                                                                            ),

                                                                            // color: MyColors.primaryColor,
                                                                            // textColor:MyColors.whiteColor,
                                                                            // padding: EdgeInsets.all(10),
                                                                            // splashColor: Colors.grey,
                                                                          ),
                                                                        ),
                                                                        hSizedBox,
                                                                        Container(
                                                                          // padding: EdgeInsets.all(15),
                                                                          child:
                                                                              ElevatedButton(
                                                                            child:
                                                                                Text(
                                                                              "Close",
                                                                              style: TextStyle(fontSize: 15),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: StadiumBorder(),
                                                                              primary: MyColors.primaryColor,
                                                                            ),
                                                                            // color: MyColors.primaryColor,
                                                                            // textColor:MyColors.whiteColor,
                                                                            // padding: EdgeInsets.all(10),
                                                                            // splashColor: Colors.grey,
                                                                          ),
                                                                        ),
                                                                        // hSizedBox,
                                                                      ],
                                                                    ),
                                                                    // Container(
                                                                    //   // padding: EdgeInsets.all(15),
                                                                    //   child:RaisedButton(
                                                                    //     child: Text("Submit", style: TextStyle(fontSize: 15),),
                                                                    //     onPressed: () async{
                                                                    //       Map<String,dynamic> data ={
                                                                    //         'user_id':await getCurrentUserId(),
                                                                    //         'item_id':product[i]['id'].toString(),
                                                                    //         'seller_id':product[i]['seller_id'].toString(),
                                                                    //         'product_id':product[i]['product_id'].toString(),
                                                                    //         'rating':_ratingValue.toString(),
                                                                    //         'message':feedbackController.text,
                                                                    //       };
                                                                    //       print('data----$data');
                                                                    //       if(_ratingValue==''){
                                                                    //         showSnackbar(context, 'Please Enter your feedback.');
                                                                    //       }
                                                                    //       else if(feedbackController.text==''){
                                                                    //         showSnackbar(context, 'Please Enter your feedback.');
                                                                    //       }
                                                                    //       var res = await Webservices.postData(body: data, context: context,apiUrl: ApiUrls
                                                                    //           .submitrating,);
                                                                    //       log('markasdeliveredforcustomer--------'+res.toString());
                                                                    //       if(res['status'].toString()=='1'){
                                                                    //         getorderdetails();
                                                                    //         setState((){});
                                                                    //         Navigator.pop(context);
                                                                    //         showSnackbar(context, 'Thank you for rating.');
                                                                    //       }
                                                                    //
                                                                    //     },
                                                                    //     color: MyColors.primaryColor,
                                                                    //     textColor:MyColors.whiteColor,
                                                                    //     padding: EdgeInsets.all(10),
                                                                    //     splashColor: Colors.grey,
                                                                    //   ) ,
                                                                    // ),
                                                                    vSizedBox,
                                                                  ],
                                                                  // ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text('ok')),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context1);
                                                  },
                                                  child: Text('cancel')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: MyColors.whiteColor,
                                      border: Border.all(
                                          color: MyColors.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'I received the product',
                                      style: TextStyle(
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                ),
                              // hSizedBox,

                              if (paymentstatus == '1' &&
                                  (product[i]['status'].toString() == '1') &&
                                  (product[i]['ship_status'].toString() ==
                                      '0') &&
                                  (userLoggedIn == true))
                              //------ Cancle
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context1) {
                                          return AlertDialog(
                                            title: Text(
                                              'Cancel',
                                            ),
                                            content: Text('Are you sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    loadingShow(context);
                                                    var c =
                                                        '${ApiUrls.cancelitem}?item_id=${product[i]['id']}&user_id=${await getCurrentUserId()}';
                                                    print(
                                                        'this is url----' + c);
                                                    var res = await Webservices
                                                        .getMap(c);
                                                    var canorderapi = res;
                                                    loadingHide(context);
                                                    print(
                                                        'cancelorder-----${res}');
                                                    print(
                                                        'cancelorder-----${canorderapi}');
                                                    // print('cancelorder-----${res['status']}');
                                                    // print('cancelorder-----${res['message']}');
                                                    // if(res['status'].toString()=='1'){
                                                    getorderdetails();
                                                    Navigator.pop(context1);
                                                    setState(() {});
                                                    // }
                                                    // else{
                                                    //   showSnackbar(context, 'some this went wrong');
                                                    // }
                                                  },
                                                  child: Text('ok')),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context1);
                                                  },
                                                  child: Text('cancel')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: MyColors.whiteColor,
                                        border: Border.all(
                                            color: MyColors.primaryColor,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                ),

                              if (paymentstatus == '1' &&
                                  (product[i]['status'].toString() == '1') &&
                                  (product[i]['ship_status'].toString() ==
                                      '0') &&
                                  (userLoggedIn == true))
                                // hSizedBox,


                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2'))
                              // Delivered
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: MyColors.greenColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Delivered',
                                      style:
                                          TextStyle(color: MyColors.whiteColor),
                                    ),
                                  ),
                                ),

                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2'))
                                hSizedBox,

                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2') &&
                                  (product[i]['reviews'].toString() != '0'))
                              // viewviews button
                                GestureDetector(
                                  onTap: () {
                                    print('you press view reviews button');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          elevation: 16,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 250,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Rating",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    IconButton(
                                                      icon: new Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        /* Your code */
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                if (product[i]['reviews']
                                                        .toString() !=
                                                    '0')
                                                  Row(
                                                    children: [
                                                      // Text(
                                                      //   'Rating :',
                                                      //   style: TextStyle(
                                                      //     fontSize: 18,
                                                      //   ),
                                                      // ),
                                                      vSizedBox,
                                                      RatingBar(
                                                        itemSize: 25,
                                                          ignoreGestures: true,
                                                          initialRating: double
                                                              .parse(product[i][
                                                                      'reviews']
                                                                  ['rating']),
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ratingWidget:
                                                              RatingWidget(
                                                                  full: const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .orange),
                                                                  half:
                                                                      const Icon(
                                                                    Icons
                                                                        .star_half,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                  empty:
                                                                      const Icon(
                                                                    Icons
                                                                        .star_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                  )),
                                                          onRatingUpdate:
                                                              (value) {
                                                            setState(() {
                                                              _ratingValue =
                                                                  value;
                                                              print(
                                                                  '-----${_ratingValue}');
                                                            });
                                                          }),
                                                      if (product[i]['reviews']
                                                              .toString() !=
                                                          '0')
                                                        Text(
                                                          '${product[i]['reviews']['rating'].toString()}',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )
                                                    ],
                                                  ),
                                                vSizedBox,
                                                if (product[i]['reviews']
                                                        .toString() !=
                                                    '0')
                                                  Text(
                                                    'Review',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                if (product[i]['reviews']
                                                        .toString() !=
                                                    '0')
                                                  Row(
                                                    children: [
                                                      Container(
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    '${userdetails['image'].toString()}'),
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade800,
                                                            radius: 25,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10)),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "${Getorderdetails['customer']['f_name'].toString()} :",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          ParagraphText(
                                                            text: product[i][
                                                                        'reviews']
                                                                    ['message']
                                                                .toString(),
                                                          ),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      ),
                                                    ],
                                                  ),
                                                if (product[i]['reviews']
                                                        .toString() !=
                                                    '0')
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      14,
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                            color: MyColors
                                                                .primaryColor,
                                                          ),
                                                          child: Text(
                                                            'Close',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .whiteColor),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                              // ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Color(0xff00b7ff),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'See Review',
                                      style:
                                          TextStyle(color: MyColors.whiteColor),
                                    ),
                                  ),
                                ),

                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2') &&
                                  (product[i]['reviews'].toString() == '0') &&
                                  (userLoggedIn == true))
                                hSizedBox,

                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2') &&
                                  (product[i]['reviews'].toString() == '0') &&
                                  (userLoggedIn == true))
                              // write reviews button
                                GestureDetector(
                                  onTap: () {
                                    print('you press write reviews button');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          elevation: 16,
                                          child: Container(
                                            // padding: EdgeInsets.symmetric(horizontal:10),
                                            decoration: BoxDecoration(
                                                color: MyColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 250,
                                            // width: 360.0,
                                            child: Column(
                                              children: [
                                                vSizedBox,
                                                vSizedBox,
                                                Text(
                                                  'How was the product ?',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                vSizedBox,
                                                Text(
                                                  'Rate it (1 to 5)',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                vSizedBox,
                                                RatingBar(
                                                    initialRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    ratingWidget: RatingWidget(
                                                        full: const Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.orange),
                                                        half: const Icon(
                                                          Icons.star_half,
                                                          color: Colors.orange,
                                                        ),
                                                        empty: const Icon(
                                                          Icons.star_outline,
                                                          color: Colors.orange,
                                                        )),
                                                    onRatingUpdate: (value) {
                                                      setState(() {
                                                        _ratingValue = value;
                                                        print(
                                                            '-----${_ratingValue}');
                                                      });
                                                    }),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 0),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff969BA0)),
                                                    controller:
                                                        feedbackController,
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: 30.0,
                                                          color: Color(
                                                              0xff969BA0)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.5,
                                                            color: Color(
                                                                0xff969BA0)),
                                                      ),
                                                      labelText: 'Review (*)',
                                                      labelStyle: new TextStyle(
                                                          color: Color(
                                                              0xff969BA0)),
                                                    ),
                                                  ),
                                                ),
                                                vSizedBox,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      // padding: EdgeInsets.all(15),
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: ElevatedButton(
                                                        child: Text(
                                                          "Close",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              StadiumBorder(),
                                                          primary: MyColors
                                                              .primaryColor,
                                                        ),

                                                        // color: MyColors.primaryColor,
                                                        // textColor:MyColors.whiteColor,
                                                        // padding: EdgeInsets.all(10),
                                                        // splashColor: Colors.grey,
                                                      ),
                                                    ),
                                                    hSizedBox,
                                                    Container(
                                                      // padding: EdgeInsets.all(15),
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: ElevatedButton(
                                                        child: Text(
                                                          "Save as changes",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        onPressed: () async {
                                                          Map<String, dynamic>
                                                              data = {
                                                            'user_id':
                                                                await getCurrentUserId(),
                                                            'item_id':
                                                                product[i]['id']
                                                                    .toString(),
                                                            'seller_id': product[
                                                                        i][
                                                                    'seller_id']
                                                                .toString(),
                                                            'product_id': product[
                                                                        i][
                                                                    'product_id']
                                                                .toString(),
                                                            'rating':
                                                                _ratingValue
                                                                    .toString(),
                                                            'message':
                                                                feedbackController
                                                                    .text,
                                                          };
                                                          print(
                                                              'data----$data');
                                                          if (_ratingValue ==
                                                              '') {
                                                            showSnackbar(
                                                                context,
                                                                'Please Enter your feedback.');
                                                          } else if (feedbackController
                                                                  .text ==
                                                              '') {
                                                            showSnackbar(
                                                                context,
                                                                'Please Enter your feedback.');
                                                          } else if (_ratingValue !=
                                                                  '' &&
                                                              feedbackController
                                                                      .text !=
                                                                  '') {
                                                            loadingShow(
                                                                context);
                                                            var res =
                                                                await Webservices
                                                                    .postData(
                                                              body: data,
                                                              context: context,
                                                              apiUrl: ApiUrls
                                                                  .submitrating,
                                                            );
                                                            loadingHide(
                                                                context);
                                                            log('markasdeliveredforcustomer--------' +
                                                                res.toString());
                                                            if (res['status']
                                                                    .toString() ==
                                                                '1') {
                                                              getorderdetails();
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {});
                                                              showSnackbar(
                                                                  context,
                                                                  'Thank you for rating.');
                                                            }
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              StadiumBorder(),
                                                          primary: MyColors
                                                              .primaryColor,
                                                        ),
                                                        // color: MyColors.primaryColor,
                                                        // textColor:MyColors.whiteColor,
                                                        // padding: EdgeInsets.all(10),
                                                        // splashColor: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                vSizedBox,
                                              ],
                                              // ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: MyColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Write Review',
                                      style:
                                          TextStyle(color: MyColors.whiteColor),
                                    ),
                                  ),
                                ),
                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '2') &&
                                  (product[i]['reviews'].toString() == '0') &&
                                  (userLoggedIn == true))
                                hSizedBox,
                              // Cancelled and Cancelled_by
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if ((paymentstatus == '1') &&
                                      (product[i]['status'].toString() == '3'))
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: MyColors.redColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'Cancelled',
                                          style: TextStyle(
                                              color: MyColors.whiteColor),
                                        ),
                                      ),
                                    ),
                                  if ((paymentstatus == '1') &&
                                      (product[i]['status'].toString() == '3'))
                                    hSizedBox,
                                  if ((paymentstatus == '1') &&
                                      (product[i]['status'].toString() == '3'))
                                    Text(
                                        'Cancelled By : ${product[i]['cancelled_by'].toString() == 'false' ? 'Admin' : product[i]['cancelled_by']['user_type'].toString() == '1' ? 'Seller' : product[i]['cancelled_by']['user_type'].toString() == '3' ? 'Customer' : ''}'),
                                  // hSizedBox,
                                ],
                              ),

                              if (product[i]['refund_data'].toString() != '' &&
                                  Getorderdetails['payment_method'] == 'Bank')
                                if ((Getorderdetails['refund_status']
                                            .toString() ==
                                        '0') &&
                                    (product[i]['refund_data']['bank_name']
                                            .toString() ==
                                        'null') &&
                                    (product[i]['status'].toString() == '3') &&
                                    (Getorderdetails['payment_method'] ==
                                        'Bank'))
                                  // Provide Bank Details
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              elevation: 16,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                // height: MediaQuery.of(context).size.height,
                                                //   height: double.infinity,
                                                height: 390,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Bank Details',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    CustomTextField(
                                                      controller:
                                                          banknameController,
                                                      hintText: 'Bank Name',
                                                      borderColor: Color(0xff00b7ff),
                                                      borderradius: 15,
                                                    ),
                                                    CustomTextField(
                                                        controller:
                                                            accountnoController,
                                                        hintText:
                                                            'Account Number',
                                                      borderColor: Color(0xff00b7ff),
                                                      borderradius: 15,),
                                                    CustomTextField(
                                                        borderColor: Color(0xff00b7ff),
                                                        borderradius: 15,
                                                        controller:
                                                            accountholderController,
                                                        hintText:
                                                            'Account Holder'),
                                                    CustomTextField(
                                                        borderColor: Color(0xff00b7ff),
                                                        borderradius: 15,
                                                        controller:
                                                            cedularucController,
                                                        hintText:
                                                            'Cedula OR Ruc'),
                                                    Container(

                                                      // padding:EdgeInsets.all(10),
                                                      width: double.infinity,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                          // color:Colors.lightGreen, //background color of dropdown button
                                                          border: Border.all(
                                                              color: Color(0xff00b7ff),
                                                              width:
                                                                  1), //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15), //border raiuds of dropdown button
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: DropdownButton(
                                                            underline:
                                                                Container(),
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .grey,
                                                                fontSize: 15),
                                                            iconSize: 0.0,
                                                            dropdownColor:
                                                                Colors.white,
                                                            value: accounttype,
                                                            // icon: const Icon(Icons.keyboard_arrow_down),
                                                            items: items1.map(
                                                                (String
                                                                    items1) {
                                                              return DropdownMenuItem(
                                                                value: items1,
                                                                child: Text(
                                                                    items1),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                accounttype =
                                                                    newValue!;
                                                                print(
                                                                    'taphere-----${accounttype}');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            if (banknameController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Bankname.');
                                                            } else if (accountnoController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Account Number.');
                                                            } else if (accountholderController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your name.');
                                                            } else if (cedularucController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Cedula OR Ruc.');
                                                            } else if (accounttype
                                                                    .toString() ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Select your Accounttype.');
                                                            } else {
                                                              Map<String,
                                                                      dynamic>
                                                                  data = {
                                                                // "user_id": widget.ccustomer!['id'],
                                                                "bank_name":
                                                                    banknameController
                                                                        .text,
                                                                "account_no":
                                                                    accountnoController
                                                                        .text,
                                                                "account_holder":
                                                                    accountholderController
                                                                        .text,
                                                                "cedula_ruc":
                                                                    cedularucController
                                                                        .text,
                                                                "account_type":
                                                                    accounttype
                                                                        .toString(),
                                                                "order_id": product[
                                                                            i][
                                                                        'order_id']
                                                                    .toString(),
                                                                "product_id": product[i]
                                                                            [
                                                                            'product']
                                                                        ['id']
                                                                    .toString(),
                                                                // "order_id": widget.orderid.toString(),
                                                              };
                                                              log('Dataaddadderss...........${data}');
                                                              loadingShow(
                                                                  context);
                                                              var res = await Webservices.postData(
                                                                  apiUrl: ApiUrls
                                                                      .add_bank_for_refund,
                                                                  body: data,
                                                                  context:
                                                                      context,
                                                                  showSuccessMessage:
                                                                      true);
                                                              if (res['status']
                                                                      .toString() ==
                                                                  '1') {
                                                                getorderdetails();
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {});
                                                              }
                                                              print(
                                                                  "Apiresponse.................");
                                                              loadingHide(
                                                                  context);
                                                              print("Apiresponse............" +
                                                                  res.toString());
                                                            }
                                                          },
                                                          child: Text('Submit'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: Color(0xff004173),

                                                          ),
                                                        ),
                                                        hSizedBox,
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('close'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: MyColors
                                                                .redColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: const Text('Provide Bank Details',style: TextStyle(color: Color(0xff00b7ff)),),
                                  ),

                              if (product[i]['refund_data'].toString() != '' &&
                                  Getorderdetails['payment_method'] == 'Bank')
                                if ((product[i]['refund_data']['refund_status']
                                            .toString() ==
                                        '0') &&
                                    (product[i]['refund_data']['bank_name']
                                            .toString() !=
                                        'null') &&
                                    (product[i]['status'].toString() == '3') &&
                                    (Getorderdetails['payment_method'] ==
                                        'Bank'))
                                  // Your Refund Is Under process
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Text('Your Refund Is Under process'),
                                    ),
                                  ),

                              if (((product[i]['status'].toString() == '3')) &&
                                  (Getorderdetails['payment_method'] ==
                                      'Paypal'))

                                // Your Refund Is Completed
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: MyColors.greyColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text('Your Refund Is Completed'),
                                  ),
                                )
                            ],
                          ),

                          vSizedBox05,
                          if (product[i]['refund_data'].toString() != '' &&
                              Getorderdetails['payment_method'] == 'Bank')
                            if ((product[i]['refund_data']['refund_status']
                                        .toString() ==
                                    '2') &&
                                (product[i]['status'].toString() == '3'))
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: MyColors.greyColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    'Your bank details is rejected please reupload bank details.'),
                              ),
                          if (product[i]['refund_data'].toString() != '' &&
                              Getorderdetails['payment_method'] == 'Bank')
                            if ((product[i]['refund_data']['refund_status']
                                        .toString() ==
                                    '2') &&
                                (product[i]['status'].toString() == '3'))
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context1) {
                                            return AlertDialog(
                                              title: Text(
                                                'Reason',
                                              ),
                                              content: Text(
                                                  '${product[i]['refund_data']['reason'].toString()}'),
                                              actions: [
                                                GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      color:
                                                          MyColors.primaryColor,
                                                    ),
                                                    child: Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .whiteColor),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'View Reason',
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                          fontSize: 15),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              elevation: 16,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                // height: MediaQuery.of(context).size.height,
                                                //   height: double.infinity,
                                                height: 390,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Bank Details',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    CustomTextField(
                                                      controller:
                                                          banknameController,
                                                      hintText: 'Bank Name',
                                                    ),
                                                    CustomTextField(
                                                        controller:
                                                            accountnoController,
                                                        hintText:
                                                            'Account Number'),
                                                    CustomTextField(
                                                        controller:
                                                            accountholderController,
                                                        hintText:
                                                            'Account Holder'),
                                                    CustomTextField(
                                                        controller:
                                                            cedularucController,
                                                        hintText:
                                                            'Cedula OR Ruc'),
                                                    Container(
                                                      // padding:EdgeInsets.all(10),
                                                      width: double.infinity,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                          // color:Colors.lightGreen, //background color of dropdown button
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .primaryColor,
                                                              width:
                                                                  1), //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  30), //border raiuds of dropdown button
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: DropdownButton(
                                                            underline:
                                                                Container(),
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .grey,
                                                                fontSize: 15),
                                                            iconSize: 0.0,
                                                            dropdownColor:
                                                                Colors.white,
                                                            value: accounttype,
                                                            // icon: const Icon(Icons.keyboard_arrow_down),
                                                            items: items1.map(
                                                                (String
                                                                    items1) {
                                                              return DropdownMenuItem(
                                                                value: items1,
                                                                child: Text(
                                                                    items1),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                accounttype =
                                                                    newValue!;
                                                                print(
                                                                    'taphere-----${accounttype}');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            if (banknameController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Bankname.');
                                                            } else if (accountnoController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Account Number.');
                                                            } else if (accountholderController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your name.');
                                                            } else if (cedularucController
                                                                    .text ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Enter your Cedula OR Ruc.');
                                                            } else if (accounttype
                                                                    .toString() ==
                                                                '') {
                                                              showSnackbar(
                                                                  context,
                                                                  'Please Select your Accounttype.');
                                                            } else {
                                                              Map<String,
                                                                      dynamic>
                                                                  data = {
                                                                // "user_id": widget.ccustomer!['id'],
                                                                "bank_name":
                                                                    banknameController
                                                                        .text,
                                                                "account_no":
                                                                    accountnoController
                                                                        .text,
                                                                "account_holder":
                                                                    accountholderController
                                                                        .text,
                                                                "cedula_ruc":
                                                                    cedularucController
                                                                        .text,
                                                                "account_type":
                                                                    accounttype
                                                                        .toString(),
                                                                "order_id": product[
                                                                            i][
                                                                        'order_id']
                                                                    .toString(),
                                                                "product_id": product[i]
                                                                            [
                                                                            'product']
                                                                        ['id']
                                                                    .toString(),
                                                                // "order_id": widget.orderid.toString(),
                                                              };
                                                              log('Dataaddadderss...........${data}');
                                                              loadingShow(
                                                                  context);
                                                              var res = await Webservices.postData(
                                                                  apiUrl: ApiUrls
                                                                      .add_bank_for_refund,
                                                                  body: data,
                                                                  context:
                                                                      context,
                                                                  showSuccessMessage:
                                                                      true);
                                                              if (res['status']
                                                                      .toString() ==
                                                                  '1') {
                                                                getorderdetails();
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {});
                                                              }
                                                              print(
                                                                  "Apiresponse.................");
                                                              loadingHide(
                                                                  context);
                                                              print("Apiresponse............" +
                                                                  res.toString());
                                                            }
                                                          },
                                                          child: Text('Submit'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: MyColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        hSizedBox,
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('close'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: MyColors
                                                                .redColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: MyColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'Reupload Bank Details',
                                        style: TextStyle(
                                            color: MyColors.whiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          if (product[i]['refund_data'].toString() != '' &&
                              Getorderdetails['payment_method'] == 'Bank')
                            if ((product[i]['refund_data']['refund_status']
                                        .toString() ==
                                    '1') &&
                                (Getorderdetails['payment_method'] == 'Bank'))
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: MyColors.greyColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text('Your Refund Is Completed'),
                                  ),
                                  hSizedBox,
                                  InkWell(
                                      child: new Text(
                                        'View Proof',
                                        style: TextStyle(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blueAccent),
                                      ),
                                      onTap: () => launch(product[i]
                                              ['refund_data']['refund_receipt']
                                          .toString())),
                                ],
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '1') &&
                                  (product[i]['ship_status'].toString() ==
                                      '0') &&
                                  (userLoggedIn == true))
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            elevation: 16,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 200,
                                              // width: 360.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Extend Waiting Time",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      new IconButton(
                                                        icon: new Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          /* Your code */
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Extend time (hours)',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      // vSizedBox,
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        width: double.infinity,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            // color:Colors.lightGreen, //background color of dropdown button
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black38,
                                                                width:
                                                                    0.5), //border of dropdown button
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15), //border raiuds of dropdown button
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child:
                                                                DropdownButton(
                                                              underline:
                                                                  Container(),
                                                              iconSize: 0.0,
                                                              dropdownColor:
                                                                  Colors.white,
                                                              value:
                                                                  dropdownvalue,
                                                              // icon: const Icon(Icons.keyboard_arrow_down),
                                                              items: items.map(
                                                                  (String
                                                                      items) {
                                                                return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(
                                                                      items),
                                                                );
                                                              }).toList(),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue =
                                                                      newValue!;
                                                                  print(
                                                                      'taphere-----${dropdownvalue}');
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // vSizedBox,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          14,
                                                                      vertical:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                                color: MyColors
                                                                    .primaryColor,
                                                              ),
                                                              child: Text(
                                                                'Close',
                                                                style: TextStyle(
                                                                    color: MyColors
                                                                        .whiteColor),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          hSizedBox,
                                                          GestureDetector(
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            14,
                                                                        vertical:
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15)),
                                                                  color: MyColors
                                                                      .primaryColor,
                                                                ),
                                                                child: Text(
                                                                  'Save changes',
                                                                  style: TextStyle(
                                                                      color: MyColors
                                                                          .whiteColor),
                                                                ),
                                                              ),
                                                              onTap: () async {
                                                                // loadingShow(context);
                                                                Map<String,
                                                                        dynamic>
                                                                    data = {
                                                                  // 'ext_time':extendtimeController.text,
                                                                  'ext_time':
                                                                      dropdownvalue,
                                                                  'item_id': product[
                                                                              i]
                                                                          ['id']
                                                                      .toString(),
                                                                };
                                                                var res = await Webservices.postData(
                                                                    apiUrl: ApiUrls
                                                                        .extendtime,
                                                                    body: data,
                                                                    context:
                                                                        context,
                                                                    showSuccessMessage:
                                                                        false);

                                                                print(
                                                                    'apires-----${res}');
                                                                // if(res['sattus'].toString()==1){
                                                                Navigator.pop(
                                                                    context);
                                                                getorderdetails();
                                                                setState(() {});
                                                                // }
                                                                // loadingHide(context);
                                                              }),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                // ],
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: MyColors.primaryColor,
                                    ),
                                    child: Text(
                                      'Extend Waiting Time (current:${product[i]['extend_time'].toString()})',
                                      style:
                                          TextStyle(color: MyColors.whiteColor),
                                    ),
                                  ),
                                ),
                              if ((paymentstatus == '1') &&
                                  (product[i]['status'].toString() == '1') &&
                                  (product[i]['ship_status'].toString() ==
                                      '0') &&
                                  (userLoggedIn == true))
                              hSizedBox,
                              if (product[i]['ship_receipt'] != null)
                                GestureDetector(
                                  onTap: () async {
                                    DateTime now = DateTime.now();
                                    print('DateTime-------${now}');
                                    String fileurl = product[i]['ship_receipt'].toString();
                                    Map<Permission, PermissionStatus> statuses =
                                        await [
                                      Permission.storage,
                                      //add more permission to request here.
                                    ].request();

                                    if (statuses[Permission.storage]!
                                        .isGranted) {
                                      loadingShow(context);
                                      var dir = await DownloadsPathProvider
                                          .downloadsDirectory;
                                      if (dir != null) {
                                        final extension =
                                         p.extension(fileurl); // '.dart'
                                        print(
                                            'extension-----${'winaoreceipt'+extension}');
                                        var targetFileName =
                                            '/receipt_${'${product[i]['id'].toString()}'+extension+now.toString()}';
                                        String savename = targetFileName;

                                        String savePath =
                                            dir.path + '/receipt_${'${product[i]['id'].toString()}-${DateTime.now().millisecondsSinceEpoch.toString()}'+extension}';
                                        print('1111111');
                                        print(savePath);
                                        print("product[i]['ship_receipt'].toString()--------------------${product[i]['ship_receipt'].toString()}");
                                        // OpenFile.open(savePath);
                                        //output:  /storage/emulated/0/Download/banner.png
                                    // /storage/emulated/0/Download/receipt_86.pdf
                                        try {
                                          print("savePath----------8585-------------$savePath");
                                          await Dio()
                                              .download(fileurl, savePath,
                                                  onReceiveProgress:
                                                      (received, total) {
                                            if (total != -1) {
                                              //you can build progressbar feature too
                                            }
                                          });
                                          loadingHide(context);

                                          await showSnackbar(context,
                                              'Receipt downloaded in Downloads folder');
                                           // OpenFile.open(savePath);
                                        } on DioError catch (e) {
                                          print(e.message);
                                        }
                                      }
                                    } else {
                                      print("No permission to read and write.");
                                    }

                                    // print('loadingShow');
                                    // loadingShow(context);
                                    // var targetPath = await getPathToDowload();
                                    // String url = product[i]['ship_receipt'].toString();
                                    // // https://www.africau.edu/images/default/sample.pdf
                                    // // https://bluediamondresearch.com/WEB01/Winao/assets/UserProfile/no-image-icon-23485.png
                                    // final extension = p.extension(url); // '.dart'
                                    // print('extension-----${'winaoreceipt'+extension}');
                                    // var targetFileName='${'winaoreceipt'+extension}';
                                    // print('targetFileName............${targetFileName}');
                                    // print('download............');
                                    // await savePdfToStorage(url,targetPath, targetFileName);
                                    // // loadingHide(context);
                                    // print('loadingHide');
                                    // print('download1............');
                                    // loadingHide(context);
                                    // await showSnackbar(context, 'Receipt downloaded in Downloads folder');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xfff2f2f2),
                                      border: Border.all(
                                          color: Color(0xffeeeeee),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Ship Receipt',
                                      style: TextStyle(
                                          color:Color(0xff506066)),
                                    ),
                                  ),
                                ),
                              // TextButton(onPressed:() async {
                              //   print('loadingShow');
                              //   loadingShow(context);
                              //   var targetPath = await getPathToDowload();
                              //   var targetFileName = 'vivek.pdf';
                              //   print('download............');
                              //   await savePdfToStorage('https://bluediamondresearch.com/WEB01/Winao/assets/uploads/3877500021664456673.pdf',targetPath, targetFileName);
                              //    // loadingHide(context);
                              //   print('loadingHide');
                              //   print('download1............');
                              //   loadingHide(context);
                              //   await showSnackbar(context, 'Receipt download');
                              //   },
                              //     child: Text('View Shipping Guide')),
                            ],
                          ),
                          vSizedBox05,
                        ],
                      ),
                    ),
                  vSizedBox2,

                  Container(
                    decoration: new BoxDecoration(
                        color: Color(0xffdee2e6).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(0)),
                    // margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'regular',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$' +
                                  '${
                                    double.parse(
                                            Getorderdetails['grand_total_new'])
                                        .toStringAsFixed(2)
                                  }',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'regular',
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount(-)',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'regular',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$' + Getorderdetails['discountt'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'regular',
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'regular',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$' + Getorderdetails['shipping_cost'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'regular',
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'regular',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${double.parse(Getorderdetails['totall'].toString()).toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'regular',
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                      ],
                    ),
                  ),
                  vSizedBox,
                  Text(
                    'Order Information',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Getorderdetails['name']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['email']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['contact']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['city']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['zip']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['address']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['state']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    '${Getorderdetails['country']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  vSizedBox,
                  Divider(
                    thickness: 2,
                  ),
                  Text(
                    'Payment Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Method:${Getorderdetails['payment_method']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),
                  Text(
                    'Payment Status: ${(Getorderdetails['payment_status'] == '0' && Getorderdetails['receipt_status'] == '1') ? 'Paid Waiting for Verification' : (Getorderdetails['payment_status'] == '0' && Getorderdetails['receipt_status'] == '0') ? ' Waiting for Payment' : (Getorderdetails['payment_status'] == '2' && Getorderdetails['receipt_status'] == '2') ? 'Rejected(please Resubmit receipt)' : 'Verified Payment Waiting for Shipping Or Local Pickup'}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),

                  Text(
                    'Transaction Id : ${Getorderdetails['payment_id']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'regular',
                    ),
                  ),

                  // 3buttons------------
                 vSizedBox,
                  if (((paymentmethod == 'Bank') &&
                          Getorderdetails['payment_status'] != '1') &&
                      ((Getorderdetails['receipt_status'] != '3')))
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff00b7ff),
                                borderRadius: BorderRadius.circular(5)),
                            height: 30,

                            // margin: EdgeInsets.all(25),
                            child: TextButton(
                              child: Text(
                                'View Bank info',
                                style: TextStyle(
                                    fontSize: 12.0, color: MyColors.whiteColor),
                              ),
                              // color: Colors.blueAccent,
                              // textColor: Colors.white,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      elevation: 16,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 348,
                                        // width: 360.0,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child:
                                                      Text("Bank Information",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                          )),
                                                ),
                                                new IconButton(
                                                  icon: new Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    /* Your code */
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 300,
                                              width: 500,
                                              child: DefaultTabController(
                                                length: adminbankdetails.length,
                                                child: Builder(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Stack(
                                                    children: <Widget>[
                                                      TabBarView(children: [
                                                        for (var i = 0;
                                                            i <
                                                                adminbankdetails
                                                                    .length;
                                                            i++)
                                                          ongoingScreen(
                                                              context: context,
                                                              bank:
                                                                  adminbankdetails[
                                                                      i]),
                                                        // cancelledScreen(context: context),
                                                        // purchasedScreen(context: context),
                                                      ]),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        child: IconTheme(
                                                          data: IconThemeData(
                                                            size: 135.0,
                                                          ),
                                                          child: TabBar(
                                                            unselectedLabelColor:
                                                                Color(
                                                                    0xFFF00b7ff),
                                                            labelColor: MyColors
                                                                .whiteColor,
                                                            indicatorColor:
                                                            Color(0xff004173),
                                                            indicator:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:Color(0xff004173),
                                                            ),
                                                            // unselectedLabelStyle:,
                                                            tabs: [
                                                              for (var i = 0;
                                                                  i <
                                                                      adminbankdetails
                                                                          .length;
                                                                  i++)
                                                                Tab(
                                                                  child:
                                                                      Container(
                                                                    height: 55,
                                                                    width: 150,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(
                                                                              color: Color(0xff004173),
                                                                            )),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          adminbankdetails[i]
                                                                              [
                                                                              'bank_name'],
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          // ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        hSizedBox,
                        Container(
                          // margin: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              color:Color(0xff00b7ff),
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,

                          child: TextButton(
                            child: Text(
                              'Change Payment method',
                              style: TextStyle(
                                  fontSize: 12.0, color: MyColors.whiteColor),
                            ),
                            // color: Colors.orangeAccent,
                            // textColor: Colors.white,
                            onPressed: () async {
                              print('prasoon------paypal click--------');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => UsePaypal(
                                      sandboxMode: true,
                                      clientId:
                                          "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                      secretKey:
                                          "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                      returnURL:
                                          "https://samplesite.com/return",
                                      cancelURL:
                                          "https://samplesite.com/cancel",
                                      transactions: [
                                        {
                                          "amount": {
                                            "total": Getorderdetails['totall']
                                                .toString(),
                                            // "total": Grandtotal,
                                            "currency": "USD",
                                            "details": {
                                              "subtotal":
                                                  Getorderdetails['totall']
                                                      .toString(),
                                              "shipping": '0',
                                              "shipping_discount": '0'
                                            }
                                          },
                                          "description":
                                              "The payment transaction description.",
                                        }
                                      ],
                                      note:
                                          "Contact us for any questions on your order.",
                                      onSuccess: (Map params) async {
                                        print('hello world');
                                        print("onSuccess: $params");
                                        print("payerID: ${params['payerID']}");
                                        print(
                                            "paymentId: ${params['paymentId']}");

                                        payerID = params['payerID'];
                                        paymentId = params['paymentId'];

                                        onSuccessPaypal(params);
                                        // log('Apiresponsecubmitcheckout...........${res}');
                                        print('payment with paypal');
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                      },
                                      onCancel: (params) {
                                        print(
                                            'cancelled handling----: $params');
                                      }),
                                ),
                              );
                            },
                          ),
                        ),
                        hSizedBox,
                        // if(userLoggedIn==true&&(Getorderdetails['receipt_status'].toString()=='3'))
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff00b7ff),
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          // margin: EdgeInsets.all(25),
                          child: TextButton(
                            child: Text(
                              'Upload Reciept',
                              style: TextStyle(
                                  fontSize: 10.0, color: MyColors.whiteColor),
                            ),
                            // color: Colors.pinkAccent,
                            // textColor: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      elevation: 16,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 240,
                                        // width: 360.0,
                                        child: (Getorderdetails[
                                                        'payment_status'] ==
                                                    '0' &&
                                                Getorderdetails[
                                                        'receipt_status'] ==
                                                    '1')
                                            ? Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Text(
                                                            "Upload Receipt",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                      new IconButton(
                                                        icon: new Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          /* Your code */
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    child: Center(
                                                      child: Text(
                                                          'Your Payment Verification is Under Process',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {



                                                      print('hello world ...........1');
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                          'jpg',
                                                          'pdf',
                                                          'doc',
                                                          'png',
                                                        ],
                                                      );
                                                      print('hello world ...........2');

                                                      if (result != null) {
                                                        File file = File(result
                                                            .files.single.path
                                                            .toString());
                                                        print(
                                                            'sjfdjelectedimage---${file}');

                                                        var a =
                                                            file.lengthSync();
                                                        print(
                                                            'Length-----${a}');
                                                        var b = 1000000;
                                                        filesize = await a / b;
                                                        print(
                                                            'filesize--${filesize}');
                                                        image1 = file;
                                                        print(image1);
                                                        var res = file.path
                                                            .toString()
                                                            .split(
                                                                'file_picker/')[1]
                                                            .toString();
                                                        print("cjhfhjgj" +
                                                            res
                                                                .toString()
                                                                .split('.')[1]
                                                                .toString());
                                                        fileExt = res
                                                            .toString()
                                                            .split('.')[1]
                                                            .toString();

                                                        // images.add(file);
                                                        // print(images);
                                                        setState(() {});
                                                      }
                                                      else {
                                                        // User canceled the picker
                                                      }

                                                      // await _showImage_popup(context);
                                                      setState(() {});
                                                    },
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 16.0),
                                                        child: fileExt != 'pdf'
                                                            ? CustomCircularImage(
                                                                imageUrl:
                                                                    'assets/images/add-file.png',
                                                                image: image1,
                                                                height: 70,
                                                                fileType: image1 ==
                                                                        null
                                                                    ? CustomFileType
                                                                        .asset
                                                                    : CustomFileType
                                                                        .file,
                                                                width: 70,
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: MyColors
                                                                      .whitelight,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                // height: 140,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    130,
                                                                child: image1 !=
                                                                        null
                                                                    ? Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Text(image1 != null ? '${image1?.path.toString().split('file_picker/')[1].toString()}' : '')),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                image1 = null;
                                                                                fileExt = null;
                                                                                setState(() {});
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.close,
                                                                                color: Colors.red,
                                                                              )),
                                                                        ],
                                                                      )
                                                                    : Container(),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 16),
                                                    child: TextFormField(
                                                      controller: idController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelText:
                                                            'Transaction / Payment ID',
                                                      ),
                                                    ),
                                                  ),
                                                  // new IconButton(
                                                  //   icon: new Icon(Icons.close,color: Colors.black,),
                                                  //   onPressed: () { /* Your code */
                                                  //     Navigator.pop(context);
                                                  //   },
                                                  // ),
                                                  Container(
                                                    // padding: EdgeInsets.all(15),
                                                    child: ElevatedButton(
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      onPressed: () async {
                                                        print(
                                                            'fhfdhdfh--${image1}');

                                                        if (image1 == null) {
                                                          showSnackbar(context,
                                                              'Reciept field is required');
                                                        } else if (filesize >
                                                            5) {
                                                          showSnackbar(context,
                                                              'Please select file less then 5 Mb');
                                                        } else if (idController
                                                                .text ==
                                                            '') {
                                                          showSnackbar(context,
                                                              'Please enter Transaction Id/Paymnet ID');
                                                        } else {
                                                          Map<String, dynamic>
                                                              data = {
                                                            'user_id':
                                                                await getCurrentUserId(),
                                                            'order_id':
                                                                Getorderdetails[
                                                                    'id'],
                                                            'payment_id':
                                                                idController
                                                                    .text,
                                                            // 'receipt_image':image1,
                                                          };
                                                          print(
                                                              'data----$data');

                                                          // Map<String,dynamic>files = {
                                                          //   'receipt_image':image1,
                                                          //   // 'receipt_image':'ghrehrerehre',
                                                          // };
                                                          Map<String, dynamic>
                                                              files = {
                                                            // 'cover_image':image,
                                                          };
                                                          if (image1 != null) {
                                                            files["receipt_image"] =
                                                                image1;
                                                          }

                                                          print(
                                                              'files----$files');
                                                          log('the kjdsnhfsanbk ${files}');
                                                          var res =
                                                              await Webservices
                                                                  .postDataWithImageFunction(
                                                            body: data,
                                                            files: files,
                                                            context: context,
                                                            apiUrl: ApiUrls
                                                                .uploadreciept,
                                                          );
                                                          log('jsonResponse--------' +
                                                              res.toString());
                                                          log('jsonResponse--------' +
                                                              res['status']
                                                                  .toString());

                                                          if (res['status']
                                                                  .toString() ==
                                                              '1') {
                                                            log('getorderdetails---1');
                                                            getorderdetails();
                                                            log('getorderdetails---2');
                                                            Navigator.pop(
                                                                context);
                                                            log('getorderdetails---3');
                                                          }
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: StadiumBorder(),
                                                        primary: MyColors
                                                            .primaryColor,
                                                      ),
                                                      // color: MyColors.primaryColor,
                                                      // textColor:MyColors.whiteColor,
                                                      // padding: EdgeInsets.all(10),
                                                      // splashColor: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                                // ],
                                              ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  vSizedBox,
                  Divider(
                    thickness: 2,
                  ),
                  vSizedBox,

                  Container(
                    // padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      children: [
                        Text(
                          'If you need any support and help please click here',
                          style: TextStyle(fontSize: 16, fontFamily: 'regular'),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox,
                  Container(
                    // padding: EdgeInsets.all(15),
                    child: ElevatedButton(
                      child: Text(
                        "Ir a página de soporte",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SupportPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        // shape: StadiumBorder(),
                        primary: Color(0xFF004173),
                      ),
                      // color: MyColors.primaryColor,
                      // textColor:MyColors.whiteColor,
                      // padding: EdgeInsets.all(10),
                      // splashColor: Colors.grey,
                    ),
                  ),

                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: FloatingActionButton.extended(
                  //     backgroundColor: MyColors.primaryColor,
                  //     foregroundColor: Colors.white,
                  //     onPressed: () {
                  //       // Respond to button press
                  //     },
                  //     icon: Icon(Icons.arrow_back_ios),
                  //     label: Text('GO to Home'),
                  //   ),
                  // )

                ],
              ),
            ),
    );
  }
}
