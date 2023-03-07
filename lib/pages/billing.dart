import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:geocoding/geocoding.dart';
import 'package:webview_flutter_x5/webview_flutter.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/constants/navigation.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/packages/packages/lib/widget/search_widget.dart';
import 'package:winao_client_app/pages/bottomnavigation.dart';
import 'package:winao_client_app/pages/privacyandpolicy.dart';
import 'package:winao_client_app/pages/signin.dart';
import 'package:winao_client_app/pages/support.dart';
import 'package:winao_client_app/pages/terms.dart';
// import 'package:winao_client_app/pages/thankyou.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/GOOGLEMAP.dart';
import 'package:winao_client_app/widgets/address.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/bankdetails.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';
import 'dart:convert' as convert;
import '../constants/global_costants.dart';
import '../packages/packages/lib/utils/google_search/latlng.dart';
import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';
import 'checkout.dart';
import 'manageorder.dart';
bool isObscure=true;
bool isObscurePas=true;

class BillingPage extends StatefulWidget {
  static const String id = "billing";
  final List carts;
  final Map? aagent;
  final Map? ccustomer;
  final String? recoid;

  // final List carts1;
  const BillingPage({
    Key? key,
    required this.carts,
    this.ccustomer,
    this.aagent,
    this.recoid,
    // required this.carts1
  }) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  List<dynamic> adminbankdetails = [];
  List<dynamic> phoneCode = ['09'];
  List<dynamic> states = [];
  String? orderid;
  String? lat;
  String? phoneCodeType = '09';
  String? user_id;
  String? agent_id;
  String? payment;
  String? long;
  double shippingcost = 0;
  int subtotal = 0;
  int customerid = 0;
  int agentid = 0;
  int agentid1 = 0;

  int Grandtotal = 0;
  double sum = 0;
  bool _isVisible = false;
  bool _bankinfo = false;

  bool bank = false;
  bool _value = false;
  bool value = false;
  bool value1 = false;
  bool isDisabled = true;

  String selectedIndex = '';
  int? selectedIndexaddress;
  String payerID = '';
  String paymentId = '';

  List<dynamic> Addresslist = [];
  String Address = '';
  String city = '';
  String state = '';
  String country = '';
  String zip = '';
  String lng = '';
  String latt = '';
  bool rememberMe = true;
  bool load = false;
  String? newCity = null;
  List Cities = [];
  // String city = '';
  getCity() async {
    Cities = await Webservices.getList('${ApiUrls.get_cities}?all=1');
    setState(() {});
    log('res getall get_cities=----------------${Cities}');
  }

  void creditcardform() {
    setState(() {
      _isVisible = !_isVisible;
      print(_isVisible);
    });
  }

  void bankinfo() {
    setState(() {
      _bankinfo = !_bankinfo;
      print(_bankinfo);
    });
  }

  void bank1() {
    setState(() {
      bank = !bank;
      print(bank);
    });
  }

  void check() {
    setState(() {
      _value = !_value;
    });
  }

  TextEditingController codeController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reenterpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchlocationController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController newAddress = TextEditingController();

  onSuccessPaypal(Map params) async {
    try {
      loadingShow(context);
    } catch (e) {}
    var useridd;
    if (await isUserLoggedIn()) {
      useridd = await getCurrentUserId();
    } else {
      // useridd = user_id;
      useridd = widget.ccustomer!['id'];
    }
    Map<String, dynamic> data = {
      'trasnId': paymentId,
      'user_id': useridd,
      'agent_id': agent_id,
      'recommended_id': widget.recoid,
      'first_name': firstnameController.text,
      'last_name': lastnameController.text,
      'newsletter': value1 == true ? '1' : '0',
      // 'password': passwordController.text,
      'email': emailController.text,
      'phonecode': phonenoController.text,
      'phone': phonenoController.text,
      'address': Address,
      'country': country,
      'state': state,
      'city': city,
      'zip': zip,
      'lat': latt,
      'lng': lng,
      'shipping_cost': shippingcost.toString(),
      'total_amount': Grandtotal.toString(),
      // 'order_uniqueid':'fdasfdasfdasfa',
      'payment': payment,
      // 'seller_id':user_id,
      'special_instruction': specialController.text,

      "cartItems": convert.jsonEncode(widget.carts)
    };
    if (widget.ccustomer!['password_set'].toString() == '0') {
      data['password'] = passwordController.text;
    }

    log('Dataforcheckout...........${data}');

    // return;
    var res = await Webservices.postData(
        apiUrl: ApiUrls.submitcheckout,
        body: data,
        context: context,
        showSuccessMessage: true);
    log('checkoutapires...........${res}');
    print('order_id.............${res['order_id'].toString()}');
    orderid = res['order_id'].toString();

    print('sms.............${res['message'].toString()}');
    print('status.............${res['status'].toString()}');

    if (res['status'] == 1) {
      MyGlobalKeys.homepagekey.currentState?.refresh();
      // MyGlobalKeys.searchLocationKey.currentState?.updateTextField(address);

      // loadingHide(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ManageOrdersPage(
                  orderData: res['data'] ?? {}, orderid: orderid ?? '')));
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

  void initState() {
    super.initState();
    getCity();
    log("customer detail----------------525--------${widget.ccustomer}");

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    agent_id = widget.aagent!['id'];
    for (var i = 0; i < widget.carts.length; i++) {
      if (widget.carts[i]['user_id'].toString() != 'false') {
        log('cartdataorignal.......${widget.carts[i]['user_id'].toString()}');
        log('cartdataorignal.......${widget.carts[i]['store_id'].toString()}');
      }

      subtotal = ((widget.carts[i]['qty'] as int) *
          int.parse(widget.carts[i]['winao_price']));
      Grandtotal += subtotal;
      widget.carts[i]['subtotal'] = subtotal.toString();
      widget.carts[i]['options'] = {
        'recommended_to': widget.ccustomer!['id'],
        'recommended_by': widget.aagent!['id'],
        'recommended_id': widget.aagent!['id'],
        'seller': widget.carts[i]['user_id'],
        'store': widget.carts[i]['store_id'],
      };

      widget.carts[i].remove('description');
      widget.carts[i].remove('short_description');
      widget.carts[i].remove('images');
      widget.carts[i].remove('created_at');
      widget.carts[i].remove('updated_at');
      // widget.carts[i].remove('user_id');
      widget.carts[i].remove('discount');
      widget.carts[i].remove('agents');
      widget.carts[i].remove('rating');
      widget.carts[i].remove('agents_discount');
      widget.carts[i].remove('categories');
      widget.carts[i].remove('image');
      widget.carts[i].remove('status');
      // widget.carts[i].remove('price');
      widget.carts[i].remove('shipment');
      widget.carts[i].remove('product_code');
      // widget.carts[i].remove('store_id');
      widget.carts[i].remove('local');
      widget.carts[i].remove('national');
      widget.carts[i].remove('commission_type');
      widget.carts[i].remove('product_type');
      widget.carts[i].remove('subcategories');
      // widget.carts[i].remove('title');
      widget.carts[i].remove('provincial');
    }
    log('cartdata.......${widget.carts}');
    // for (var i = 0; i < widget.carts.length; i++) {
    //   log('cartdatafjf.......${widget.carts[i]['user_id']}');
    //   log('cartdatandfnhjhnd.......${widget.carts[i]['store_id']}');
    // }

    getbankdetails();
    firstnameController.text = widget.ccustomer!['f_name'];
    lastnameController.text = widget.ccustomer!['l_name'];
    emailController.text = widget.ccustomer!['email'];
    addressController.text = widget.ccustomer!['address'];
    phonenoController.text = widget.ccustomer!['phone'];
    getaddress(false);
  }

  getPhonecode() async {
    var res = await Webservices.getMap('${ApiUrls.getPhonecode}');

    phoneCode = res['phonecode'];
    print('phonecodephonecodephonecodephonecode' + res.toString());
  }

  getbankdetails() async {
    var res = await Webservices.getList('${ApiUrls.adminbankdetails}');

    // adminbankdetails = res['data'];
    print('getbankdetails...................$res');
    for (var i = 0; i < res.length; i++) {
      res[i]['visible'] = false;
    }
    adminbankdetails = res;
    setState(() {});
    print('adminbankdetails...................$adminbankdetails');
  }

  getaddress(isSelected) async {
    var user_id = await widget.ccustomer!['id'];
    var res = await Webservices.getList(
        '${ApiUrls.customeraddresses}?user_id=$user_id');

    for (var i = 0; i < res.length; i++) {
      // Address = res[i]['address'].toString();
      // city = res[i]['city'].toString();
      // state = res[i]['state'].toString();
      // country = res[i]['country'].toString();
      // zip = res[i]['zip'].toString();
      // latt = res[i]['lat'].toString();
      // lng = res[i]['lng'].toString();
      // country = res[i]['country'].toString();

      print('addressinloop.......${Address}');
    }
    // calculateshipping(0);
    setState(() {});
    for (var i = 0; i < res.length; i++) {
      res[i]['isSelected'] = false;
    }
    Addresslist = res;
    // log('Addresslist----------${Addresslist[0]['lat']}');
    log('Addresslist----------${Addresslist}');

    if(isSelected){
      selected(res[0]['id'],true);
    }
    // for (var i = 0; i < res.length; i++) {
    //   res[i]['isSelected'] = false;
    //   if(isSelected){
    //     selected(res[0]['id'],true);
    //   }
    //   if (i == res.length - 1) {
    //     // selected(res[0]['id'],true);
    //   }
    // }
  }

  selected(id, bool value) {

    for (var i = 0; i < Addresslist.length; i++) {
      Addresslist[i]['isSelected'] = false;
      if (id == Addresslist[i]['id']) {
        print("ankita ---------------$i");
        Addresslist[i]['isSelected'] = true;

        calculateshipping(i);
      }
    }
    setState(() {});
    // calculateshipping(0);

  }

  calculateshipping(i) async {
    print('calculateshipping-----------555');
    try {
      log('lng-----555${Addresslist[i]['lng']}');
    } catch (e) {
      log('errorrrrrrrrrrr----${e}');
    }

    setState(() {
      selectedIndexaddress = i;
    });
    log('cart----' + widget.carts.toString());
    for (int ii = 0; ii < widget.carts.length; ii++) {
      var c = [];
      for (int j = 0; j < widget.carts[ii]['options']['store'].length; j++) {
        c.add(widget.carts[ii]['options']['store'][j]['id']);
      }
      widget.carts[ii]['options']['store1'] = c.join(',');
      widget.carts[ii]['options']['seller1'] =
          widget.carts[ii]['user_id'].toString() == 'false'
              ? '0'
              : widget.carts[ii]['user_id']['id'].toString();
      widget.carts[ii]['options']['seller'] =
          widget.carts[ii]['options']['seller'].toString();
    }
    Map<String, dynamic> dataforcalculateshipping = {
      "lat": Addresslist[i]['lat'].toString(),
      "lng": Addresslist[i]['lng'].toString(),
      "city": Addresslist[i]['city'].toString(),
      "cartItems": convert.jsonEncode(widget.carts),
      "is_app": "1",
    };

    log('dataforcalculateshipping...........${dataforcalculateshipping}');
    loadingShow(context);
    var res = await Webservices.postData(
        apiUrl: ApiUrls.calculateshipping,
        body: dataforcalculateshipping,
        context: context,
        showSuccessMessage: false);

    log("calculateshippingApiresponse............" + res.toString());
    log("shipping_cost............" + res['shipping_cost'].toString());

    if (res['status'].toString() == '1') {
      shippingcost = double.parse(res['shipping_cost'].toString());
      loadingHide(context);
      if (res['is_available'] == 0) {
        shippingcost=0;
        await _showMyDialog();
        Addresslist[i]['isSelected'] = false;

      }
      sum = Grandtotal + shippingcost;
      load == false;
      setState(() {});
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Sorry! Product not available on this address'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text(
              'Products :',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            Container(
              decoration: new BoxDecoration(
                  color: Color(0xffdee2e6).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(0)),
              // margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(120.0),
                children: [
                  for (var i = 0; i < widget.carts.length; i++)
                    TableRow(
                        decoration: new BoxDecoration(
                            // color: Color(0xffb4acac),
                            borderRadius: BorderRadius.circular(0)),
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.carts![i]['title'].toString()}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff969BA0),
                                  ),
                                )
                              ]),
                          Column(children: [
                            Text(
                              '\$${widget.carts![i]['winao_price'].toString()}' +
                                  ' X ' +
                                  '${widget.carts![i]['qty'].toString()}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff969BA0),
                              ),
                            )
                          ]),
                          Column(children: [
                            Text(
                              '\$${widget.carts![i]['subtotal'].toString()}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff969BA0),
                              ),
                            )
                          ]),
                          vSizedBox4
                        ]),
                  TableRow(
                      decoration: new BoxDecoration(
                          // color: Color(0xffb4acac),
                          borderRadius: BorderRadius.circular(0)),
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff969BA0),
                                ),
                              )
                            ]),
                        Column(children: [
                          Text(
                            'Shipping :',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff969BA0),
                            ),
                          )
                        ]),
                        Column(children: [
                          Text(
                            // load==true?'loading....':
                            shippingcost == ''
                                ? 'Not calculate yet'
                                : '\$${shippingcost}',
                            // '\$${shippingcost}?"Not calculate yet"',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff969BA0),
                            ),
                          )
                        ]),
                        vSizedBox4
                      ]),
                  TableRow(
                      decoration: new BoxDecoration(
                          // color: Color(0xffb4acac),
                          borderRadius: BorderRadius.circular(0)),
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff969BA0),
                                ),
                              )
                            ]),
                        Column(children: [
                          Text(
                            'Total :',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff969BA0),
                            ),
                          )
                        ]),
                        Column(children: [
                          Text(
                            '\$${Grandtotal + shippingcost}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff969BA0),
                            ),
                          )
                        ]),
                        vSizedBox2
                      ]),
                ],
              ),
            ),
            vSizedBox,
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff004173),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyorderPage()
                  // ));
                },
                leading: Icon(
                  Icons.south_outlined,
                  color: Colors.white,
                ),
                // contentPadding: EdgeInsets.all(0),

                title: Transform.translate(
                  offset: const Offset(-20.0, 0.0),
                  child: Text(
                    'Add Billing Address',
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 14,
                        fontFamily: 'regular'),
                  ),
                ),
                // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
              ),
            ),
            vSizedBox,
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: firstnameController,
                      hintText: 'First Name',
                      enabled: false,
                      borderradius: 15,
                      borderColor: Color(0xff00b7ff),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: lastnameController,
                      hintText: 'last Name',
                      enabled: false,
                      borderradius: 15,
                      borderColor: Color(0xff00b7ff),
                    ),
                  ),
                ],
              ),
            ),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              enabled: false,
              borderradius: 15,
              borderColor: Color(0xff00b7ff),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: phonenoController,
                    // keyboardType: TextInputType.number,
                    hintText: 'Whatsapp Number',
                    borderradius: 15,
                    borderColor: Color(0xff00b7ff),
                    // prefixIcon: 'assets/images/dashicons_whatsapp.png',
                  ),
                )
              ],
            ),
            if (widget.ccustomer!['password_set'].toString() == '0')
              CustomTextField(
                  obscureText: isObscure,
                  borderradius: 15,
                  borderColor: Color(0xff00b7ff),
                  controller: passwordController,
                  suffixIcon: isObscure?'assets/images/view.png':'assets/images/hidden.png',
                  suffixAction: (){
                    setState(() {
                      isObscure=!isObscure;
                    });
                  },
                  hintText: 'Set Password'),
            vSizedBox,
            if (widget.ccustomer!['password_set'].toString() == '0')
              CustomTextField(
                  obscureText: isObscurePas,
                  borderradius: 15,
                  borderColor: Color(0xff00b7ff),
                  controller: reenterpasswordController,
                  suffixIcon: isObscurePas?'assets/images/view.png':'assets/images/hidden.png',
                  hintText: 'Re enter Password',
                suffixAction: (){
                    setState(() {
                      isObscurePas=!isObscurePas;
                    });
                },
              ),
            vSizedBox,
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff004173),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () async {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyorderPage()
                  // ));
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          elevation: 16,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 450.0,
                            width: 500.0,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Address',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
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

                                SizedBox(height: 20),
                                // Container(
                                //   // height: 48,
                                //   width: double.infinity,
                                //   // margin: EdgeInsets.symmetric(
                                //   //     horizontal:16 ,vertical:8 ),
                                //   decoration: BoxDecoration(
                                //       color: MyColors.whiteColor,
                                //       border: Border.all(
                                //           color: MyColors.primaryColor),
                                //       borderRadius: BorderRadius.circular(30)),
                                //   padding: EdgeInsets.only(
                                //       left: 10, right: 10, top: 5, bottom: 5),
                                //   child: SearchLocation(
                                //     controller:searchlocationController,
                                //     apiKey:
                                //         'AIzaSyABk-0Al27H9Ap_Rtti2t0ePxOLvl5QFzk',
                                //     onSelected: (value) async {
                                //       print('onselectedcalled');
                                //       var temp = await value.geolocation;
                                //       addressController.text = value.description;
                                //       print('addressControllercalue---------${value.description}');
                                //       LatLng l = temp!.coordinates;
                                //       String p = value.placeId;
                                //       print("value from country   ${value}");
                                //       print(
                                //           "value from country   ${l.longitude}");
                                //       print("value from place   ${p.toString()}");
                                //       // print("value from state   }");
                                //       print(
                                //           "value from city   ${value.description}");
                                //       // print("lat   ${l.latitude.toString()}");
                                //       // print("long   ${l.longitude.toString()}");
                                //       lat = l.latitude.toString();
                                //       long = l.longitude.toString();
                                //       print("latlocal   ${lat}");
                                //       print("longlocal   ${long}");
                                //       List<Placemark> placemarks =
                                //           await placemarkFromCoordinates(
                                //               l.latitude, l.longitude);
                                //       print(
                                //           "placemarks   ${placemarks[0].administrativeArea}");
                                //       searchlocationController.text=value.description;
                                //       countryController.text = placemarks[0].country.toString();
                                //       stateController.text = placemarks[0].administrativeArea.toString();
                                //       cityController.text = placemarks[0].locality.toString();
                                //       zipcodeController.text = placemarks[0].postalCode.toString();
                                //       },
                                //   ),
                                // ),
                                // SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: MyColors.whitelight,
                                    border: Border.all(
                                        color: MyColors.primaryColor),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 0,
                                    ),
                                    hint: Text('Select City'),
                                    isExpanded: true,
                                    value: newCity,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                    ),
                                    elevation: 16,

                                    alignment: Alignment.centerLeft,
                                    style: const TextStyle(color: Colors.black),

                                    onChanged: (String? newValue) async {
                                      newCity = newValue!;
                                      print('id' + newCity.toString());
                                      if (newCity != null) {
                                        List<Location> locations =
                                            await locationFromAddress(newCity!);
                                        print(
                                            "locations ---------${locations}");
                                        lat = locations[0].latitude.toString();
                                        long =
                                            locations[0].longitude.toString();
                                        List<Placemark> placemarks =
                                            await placemarkFromCoordinates(
                                                double.parse(lat.toString()),
                                                double.parse(long.toString()));
                                        countryController.text =
                                            placemarks[0].country.toString();
                                        stateController.text = placemarks[0]
                                            .administrativeArea
                                            .toString();
                                        cityController.text =
                                            placemarks[0].locality.toString();
                                        zipcodeController.text =
                                            placemarks[0].postalCode.toString();
                                        print(
                                            "placemarks--------------------${placemarks}");
                                      }
                                      setState(() {
                                        // getSubCategory(subCatType);
                                      });
                                    },

                                    items: Cities.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e['city_name'],
                                        child: Text(e['city_name']),
                                      );
                                    }).toList(),

                                    //     .map<DropdownMenuItem<String>>((String value) {
                                    //   return DropdownMenuItem<String>(
                                    //     value: value,
                                    //     child: Text(value),
                                    //   );
                                    // }).toList(),
                                  ),
                                ),
                                SizedBox(height: 10),

                                CustomTextField(
                                  controller: newAddress,
                                  // keyboardType: TextInputType.number,
                                  hintText: 'Address',
                                  // prefixIcon: 'assets/images/dashicons_whatsapp.png',
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () async {
                                        var placemarks = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MapSample(),
                                          ),
                                        );
                                        print(
                                            'placemarksdddddmizan------${placemarks} ss');
                                        print(
                                            'placemarksaddress------${placemarks['address']}');

                                        lat = placemarks['lat'].toString();
                                        print(
                                            'manish...................1');
                                        long = placemarks['long'].toString();
                                        print(
                                            'manish...................2');
                                        newAddress.text = placemarks['address'];
                                        print(
                                            'manish...................3');
                                        countryController.text =
                                            placemarks['country'];
                                        print(
                                            'manish...................4');
                                        stateController.text =
                                            placemarks['state'];
                                        print(
                                            'manish...................5');
                                        cityController.text =
                                            placemarks['city'];
                                        print(
                                            'manish...................6');
                                        zipcodeController.text =
                                            placemarks['pincode'];
                                        print(
                                            'manish...................7');
                                        print(
                                            'manish...................8-----------${zipcodeController.text}');
                                        // await MyGlobalKeys.searchLocationKey.currentState?.updateTextField(address);
                                      },
                                      child: Text('Choose from Map')),
                                ),
                                // hSizedBox2,
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: cityController,
                                          hintText: 'City',
                                          enabled: false,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: stateController,
                                          hintText: 'State / Provience',
                                          enabled: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomTextField(
                                  controller: countryController,
                                  hintText: 'Country',
                                  enabled: false,
                                ),
                                CustomTextField(
                                    controller: zipcodeController,
                                    hintText: 'Postal / Zip Code'),
                                hSizedBox2,
                                ElevatedButton(
                                  onPressed: () async {
                                    if (newAddress.text == '') {
                                      showSnackbar(context,
                                          'Please Enter your Address.');
                                    } else {
                                      Map<String, dynamic> data = {
                                        "user_id": widget.ccustomer!['id'],
                                        "lat": lat.toString(),
                                        "lng": long.toString(),
                                        // "lat": "0",// placemarks['address'],
                                        // "lng": "0", //placemarks['address'],
                                        "address": newAddress.text,
                                        "city": cityController.text,
                                        "state": stateController.text,
                                        "country": countryController.text,
                                        "zip": zipcodeController.text,

                                        // "cartItems": convert.jsonEncode(widget.carts)
                                      };
                                      loadingShow(context);
                                      log('Dataaddadderss...........${data}');
                                      var res = await Webservices.postData(
                                          apiUrl: ApiUrls.addcustomeraddress,
                                          body: data,
                                          context: context,
                                          showSuccessMessage: true);
                                      loadingHide(context);
                                      if (res['status'].toString() == '1') {
                                        Navigator.pop(context, true);
                                        newAddress.text = '';
                                        cityController.text = '';
                                        stateController.text = '';
                                        countryController.text = '';
                                        zipcodeController.text = '';
                                        setState(() {});
                                      }
                                      print("Apiresponse.................");

                                      print("Apiresponse............" +
                                          res.toString());
                                    }
                                  },
                                  child: Text('Add'),
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: MyColors.primaryColor,
                                  ),
                                ),
                                hSizedBox2,
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ).then((res) {
                    if (res == true) {
                      getaddress(true);
                    }
                  });
                },
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                // contentPadding: EdgeInsets.all(0),

                title: Transform.translate(
                  offset: const Offset(-20.0, 0.0),
                  child: Text(
                    'Add New Address',
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 14,
                        fontFamily: 'regular'),
                  ),
                ),
                // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
              ),
            ),
            vSizedBox,

            for (int i = 0; i < Addresslist.length; i++)
              Row(children: [
                Checkbox(
                  value: Addresslist[i]['isSelected'],
                  //    value:Addresslist[i]['isSelected']?true:false,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        // selectedIndexaddress =int.parse(Addresslist[i]['id'].toString());
                        if (value == true) {
                          selected(Addresslist[i]['id'], value);
                        }

                        // Addresslist[i]['isSelected']= value;
                        Addresslist[i]['isSelected'] = value;
                        // Addresslist=[];
                        print(value);
                      }
                    });
                  },
                  // value: this.value,
                  // onChanged: (value) {
                  //   setState(() {
                  //     this.value = value!;
                  //     print(value);
                  //   });
                  // },
                ),
                Expanded(
                    child: Text('${Addresslist[i]['address'].toString()}')),
                TextButton(
                    onPressed: () {},
                    child: IconButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context1) {
                              return AlertDialog(
                                title: Text(
                                  'Delete',
                                ),
                                content: Text('Are you sure, want to Delete?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        // Map<String ,dynamic> data={
                                        // 'user_id' : widget.ccustomer!['user_id'],
                                        //   'address_id' : Addresslist[i]['id'].toString(),
                                        // };

                                        // ?user_id=86&address_id=2
                                        var res = await Webservices.getData(
                                          '${ApiUrls.delete_address}?address_id=${Addresslist[i]['id'].toString()}&user_id=${Addresslist[i]['user_id'].toString()}',
                                        );
                                        var jsonResponse =
                                            convert.jsonDecode(res.body);

                                        if (jsonResponse['status'].toString() ==
                                            '1') {
                                          setState(() {
                                            getaddress(false);
                                          });
                                          Navigator.pop(context1);
                                          showSnackbar(
                                              context,
                                              jsonResponse['message']
                                                  .toString());
                                        } else {
                                          Navigator.pop(context1);
                                          showSnackbar(
                                              context,
                                              jsonResponse['message']
                                                  .toString());
                                        }
                                      },
                                      child: Text('Delete')),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context1);
                                      },
                                      child: Text('cancel')),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                    // Text('Delete')
                    )
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
            // for (int i = 0; i < Addresslist.length; i++)
            //   Container(
            //     margin: new EdgeInsets.all(10.0),
            //     child: GestureDetector(
            //       onTap: () async {
            //         setState(() {
            //           log('selectedIndexaddressa....${selectedIndexaddress}');
            //           selectedIndexaddress = i;
            //           log('selectedIndexaddress....${selectedIndexaddress}');
            //           log('id....${Addresslist[i]['id'].toString()}');
            //           log('latttttttt....${Addresslist[i]['lat'].toString()}');
            //           log('longggggg....${Addresslist[i]['lng'].toString()}');
            //         });
            //         print("adres selected");
            //         for(int ii=0;ii<widget.carts.length;ii++){
            //           log('checkmizan  cart length- ${widget.carts.length.toString()} - ${ii.toString()}');
            //           var c = [];
            //           for(int j=0;j<widget.carts[ii]['options']['store'].length;j++){
            //             c.add(widget.carts[ii]['options']['store'][j]['id']);
            //           }
            //           widget.carts[ii]['options']['store1']= c.join(',');
            //           // Map  m = convert.jsonDecode(widget.carts[i]['options']['seller']);
            //           // print("seller------"+m["id"].toString());
            //           // print('aaa ${ widget.carts[i]['options']['seller1']}');
            //           // print('bbb ${ widget.carts[i]['options']['seller']}');
            //           // print('ccc ${ widget.carts[i]['options']['seller'].runtimeType}');
            //
            //           log('checkmizan - ${widget.carts[ii]['options']['seller']}');
            //           widget.carts[ii]['options']['seller1'] = widget.carts[ii]['options']['seller'].toString()=='false'?'0': int.parse(widget.carts[ii]['options']['seller']['id']);
            //           // log('checkmizan1 - ${widget.carts[ii]['options']['seller']['id']}');
            //           widget.carts[ii]['options']['seller'] = widget.carts[ii]['options']['seller'].toString();
            //           // log('checkmizan2 - ${widget.carts[ii]['options']['seller1']}');
            //         }
            //         log('seller------'+widget.carts.toString());
            //
            //         Map<String, dynamic> dataforcalculateshipping = {
            //           "lat": Addresslist[i]['lat'].toString(),
            //           "lng": Addresslist[i]['lng'].toString(),
            //           "cartItems": convert.jsonEncode(widget.carts)
            //         };
            //         // loadingShow(context);
            //         log('dataforcalculateshipping...........${dataforcalculateshipping}');
            //         var res = await Webservices.postData(
            //             apiUrl: ApiUrls.calculateshipping,
            //             body: dataforcalculateshipping,
            //             context: context,
            //             showSuccessMessage: false);
            //         // loadingHide(context);
            //         log("calculateshippingApiresponse............" +
            //             res.toString());
            //         log("shippingcost............" +
            //             res['shipping_cost'].toString());
            //         shippingcost =
            //             double.parse(res['shipping_cost'].toString());
            //         log("shippingcostttttforuse............${shippingcost}");
            //
            //         if (res['status'].toString() == '1') {
            //           shippingcost =
            //               double.parse(res['shipping_cost'].toString());
            //           log(
            //               "shippingcostttttforuse............${shippingcost}");
            //           setState(() {
            //             shippingcost =
            //                 double.parse(res['shipping_cost'].toString());
            //             log(
            //                 "shippingcostttttforuse............${shippingcost}");
            //           });
            //           log("shippingcost............${shippingcost}");
            //           sum = Grandtotal+shippingcost;
            //           log('sum------${sum}');
            //         }
            //       },
            //       child: adderss(
            //           isselected: selectedIndexaddress == i,
            //           text: Addresslist[i]['address'].toString()),
            //     ),
            //   ),    // for (int i = 0; i < Addresslist.length; i++)
            //   Container(
            //     margin: new EdgeInsets.all(10.0),
            //     child: GestureDetector(
            //       onTap: () async {
            //         setState(() {
            //           log('selectedIndexaddressa....${selectedIndexaddress}');
            //           selectedIndexaddress = i;
            //           log('selectedIndexaddress....${selectedIndexaddress}');
            //           log('id....${Addresslist[i]['id'].toString()}');
            //           log('latttttttt....${Addresslist[i]['lat'].toString()}');
            //           log('longggggg....${Addresslist[i]['lng'].toString()}');
            //         });
            //         print("adres selected");
            //         for(int ii=0;ii<widget.carts.length;ii++){
            //           log('checkmizan  cart length- ${widget.carts.length.toString()} - ${ii.toString()}');
            //           var c = [];
            //           for(int j=0;j<widget.carts[ii]['options']['store'].length;j++){
            //             c.add(widget.carts[ii]['options']['store'][j]['id']);
            //           }
            //           widget.carts[ii]['options']['store1']= c.join(',');
            //           // Map  m = convert.jsonDecode(widget.carts[i]['options']['seller']);
            //           // print("seller------"+m["id"].toString());
            //           // print('aaa ${ widget.carts[i]['options']['seller1']}');
            //           // print('bbb ${ widget.carts[i]['options']['seller']}');
            //           // print('ccc ${ widget.carts[i]['options']['seller'].runtimeType}');
            //
            //           log('checkmizan - ${widget.carts[ii]['options']['seller']}');
            //           widget.carts[ii]['options']['seller1'] = widget.carts[ii]['options']['seller'].toString()=='false'?'0': int.parse(widget.carts[ii]['options']['seller']['id']);
            //           // log('checkmizan1 - ${widget.carts[ii]['options']['seller']['id']}');
            //           widget.carts[ii]['options']['seller'] = widget.carts[ii]['options']['seller'].toString();
            //           // log('checkmizan2 - ${widget.carts[ii]['options']['seller1']}');
            //         }
            //         log('seller------'+widget.carts.toString());
            //
            //         Map<String, dynamic> dataforcalculateshipping = {
            //           "lat": Addresslist[i]['lat'].toString(),
            //           "lng": Addresslist[i]['lng'].toString(),
            //           "cartItems": convert.jsonEncode(widget.carts)
            //         };
            //         // loadingShow(context);
            //         log('dataforcalculateshipping...........${dataforcalculateshipping}');
            //         var res = await Webservices.postData(
            //             apiUrl: ApiUrls.calculateshipping,
            //             body: dataforcalculateshipping,
            //             context: context,
            //             showSuccessMessage: false);
            //         // loadingHide(context);
            //         log("calculateshippingApiresponse............" +
            //             res.toString());
            //         log("shippingcost............" +
            //             res['shipping_cost'].toString());
            //         shippingcost =
            //             double.parse(res['shipping_cost'].toString());
            //         log("shippingcostttttforuse............${shippingcost}");
            //
            //         if (res['status'].toString() == '1') {
            //           shippingcost =
            //               double.parse(res['shipping_cost'].toString());
            //           log(
            //               "shippingcostttttforuse............${shippingcost}");
            //           setState(() {
            //             shippingcost =
            //                 double.parse(res['shipping_cost'].toString());
            //             log(
            //                 "shippingcostttttforuse............${shippingcost}");
            //           });
            //           log("shippingcost............${shippingcost}");
            //           sum = Grandtotal+shippingcost;
            //           log('sum------${sum}');
            //         }
            //       },
            //       child: adderss(
            //           isselected: selectedIndexaddress == i,
            //           text: Addresslist[i]['address'].toString()),
            //     ),
            //   ),
            vSizedBox2,

            CustomTextField(
              controller: specialController,
              hintText: 'Special Instructions',
              borderradius: 15,
              borderColor: Color(0xff00b7ff),
            ),
            Row(
              children: <Widget>[
                // SizedBox(
                //   width: 10,
                // ),
                Checkbox(
                  value: this.value,
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                      print(value);
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Read and Agree our  ',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xff969BA0),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms & Conditions ',
                          style: TextStyle(
                              fontSize: 17.0, color: Color(0xffF72B50)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        trems())),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy & Policy',
                          style: TextStyle(
                              fontSize: 17.0, color: Color(0xffF72B50)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        privacy())),
                        ),
                      ],
                    ),
                  ),
                )
                // Row(
                //   children: [
                //     Text(
                //       'Read and Agree our  ',
                //       style: TextStyle(
                //         fontSize: 17.0,
                //         color: Color(0xff969BA0),
                //       ),
                //     ),
                //
                //     TextButton(onPressed: (){
                //       Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (BuildContext context) => trems()
                //             ));
                //     }, child:  Text(
                //       'Terms & Conditions ',
                //       style:
                //       TextStyle(fontSize: 17.0, color: Color(0xffF72B50)),
                //     ),),
                //     Text(
                //       ' and ',
                //       style: TextStyle(
                //         fontSize: 17.0,
                //         color: Color(0xff969BA0),
                //       ),
                //     ),
                //     TextButton(onPressed: (){
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => trems()
                //       ));
                //     }, child:  Text(
                //       'Privacy & Policy ',
                //       style:
                //       TextStyle(fontSize: 17.0, color: Color(0xffF72B50)),
                //     ),),
                //   ],
                // ),
                //SizedBox
                //Text
                // SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                //Checkbox
              ], //<Widget>[]
            ),
            if (widget.ccustomer!['is_newsletter'].toString() == '0')
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Checkbox(
                    value: this.value1,
                    onChanged: (value1) {
                      setState(() {
                        this.value1 = value1!;
                        print(value1);
                      });
                    },
                  ), //SizedBox
                  Text(
                    'Subscribe me for newsletter ',
                    style: TextStyle(fontSize: 17.0, color: Color(0xff969BA0)),
                  ), //Text
                  SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  //Checkbox
                ], //<Widget>[]
              ),

            // RoundEdgedButtonred(text: 'Next', color: MyColors.primaryColor,),
            // vSizedBox2,
            // Container(
            //   decoration: BoxDecoration(
            //       color: MyColors.primaryColor,
            //       borderRadius: BorderRadius.circular(10)
            //   ),
            //   child: ListTile(
            //     onTap: (){
            //       // Navigator.of(context).push(MaterialPageRoute(
            //       //     builder: (BuildContext context) => MyorderPage()
            //       // ));
            //     },
            //     leading:Icon(
            //       Icons.south_outlined, color: Colors.white,
            //     ),
            //     // contentPadding: EdgeInsets.all(0),
            //
            //     title: Transform.translate(
            //       offset: const Offset(-20.0, 0.0),
            //       child:
            //       Text('Shipping Address',
            //         style: TextStyle(color: MyColors.whiteColor, fontSize: 14, fontFamily: 'regular'),),
            //     ),
            //     // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
            //   ),
            // ),
            // vSizedBox,
            // Container(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child:  CustomTextField(controller: firstnameController, hintText: 'First Name'),
            //       ),
            //       SizedBox(width: 10,),
            //       Expanded(
            //         child:  CustomTextField(controller: lastnameController, hintText: 'last Name'),
            //       ),
            //     ],
            //   ),
            // ),
            // vSizedBox,
            // CustomTextField(controller: addressController, hintText: 'Address'),
            // CustomTextField(controller: apartmentController, hintText: 'Apartment, Suite etc'),
            // Container(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child:  CustomTextField(controller: cityController, hintText: 'City'),
            //       ),
            //       SizedBox(width: 10,),
            //       Expanded(
            //         child:  CustomTextField(controller: stateController, hintText: 'State / Provience'),
            //       ),
            //     ],
            //   ),
            // ),
            // CustomTextField(controller: countryController, hintText: 'Country'),
            // CustomTextField(controller: zipcodeController, hintText: 'Postal / Zip Code'),
            // RoundEdgedButtonred(text: 'Next', color: MyColors.primaryColor,),
            vSizedBox2,
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff004173),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyorderPage()
                  // ));
                },
                leading: Icon(
                  Icons.south_outlined,
                  color: Colors.white,
                ),
                // contentPadding: EdgeInsets.all(0),

                title: Transform.translate(
                  offset: const Offset(-20.0, 0.0),
                  child: Text(
                    'Select Payment Method',
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 14,
                        fontFamily: 'regular'),
                  ),
                ),
                // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
              ),
            ),
            vSizedBox2,

            vSizedBox2,
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Image.asset('assets/images/credit-card.png', height: 15,),
                  //       Padding(padding: EdgeInsets.only(bottom: 5)),
                  //       MainHeadingText(text: 'Credit and Debit\nCard',textAlign: TextAlign.center, color: MyColors.primaryColor, fontSize: 8,fontFamily: 'regular',)
                  //     ],
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(
                  //         color: MyColors.primaryColor,
                  //         width: 2
                  //     ),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //   width: 80,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        payment = 'paypal';
                        selectedIndex = '';
                        _isVisible = false;
                        bank = false;
                        _bankinfo = false;
                        print('payment..........${payment}');
                        creditcardform();
                        // bank1();
                      });

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => UsePaypal(
                      //         sandboxMode: true,
                      //         clientId:
                      //         "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                      //         secretKey:
                      //         "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                      //         returnURL: "https://samplesite.com/return",
                      //         cancelURL: "https://samplesite.com/cancel",
                      //         transactions:  [
                      //           {
                      //             "amount": {
                      //               "total": Grandtotal.toString(),
                      //               "currency": "USD",
                      //               "details": {
                      //                 "subtotal": Grandtotal.toString(),
                      //                 "shipping": '0',
                      //                 "shipping_discount": 0
                      //               }
                      //             },
                      //             "description":
                      //             "The payment transaction description.",
                      //             // "payment_options": {
                      //             //   "allowed_payment_method":
                      //             //       "INSTANT_FUNDING_SOURCE"
                      //             // },
                      //             "item_list": {
                      //               "items": [
                      //                 {
                      //                   "name": "A demo product",
                      //                   "quantity": 1,
                      //                   "price": Grandtotal.toString(),
                      //                   "currency": "USD"
                      //                 }
                      //               ],
                      //
                      //               // shipping address is not required though
                      //               "shipping_address": {
                      //                 "recipient_name": "Jane Foster",
                      //                 "line1": "Travis County",
                      //                 "line2": "",
                      //                 "city": "Austin",
                      //                 "country_code": "US",
                      //                 "postal_code": "73301",
                      //                 "phone": "+00000000",
                      //                 "state": "Texas"
                      //               },
                      //             }
                      //           }
                      //         ],
                      //         note: "Contact us for any questions on your order.",
                      //         onSuccess: (Map params) async {
                      //           print('hello world');
                      //           print("onSuccess: $params");
                      //         },
                      //         onError: (error) {
                      //           print("onError: $error");
                      //         },
                      //         onCancel: (params) {
                      //           print('cancelled: $params');
                      //         }),
                      //   ),
                      // );
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/paypal1.png',
                            // color: payment == 'paypal'?MyColors.primaryColor:MyColors.greyish,
                            height: 50,
                          ),
                          // vSizedBox,
                          // MainHeadingText(
                          //   text: 'PayPal',
                          //   textAlign: TextAlign.center,
                          //   color: payment == 'paypal'?MyColors.primaryColor:MyColors.greyish,
                          //   fontSize: 8,
                          //   fontFamily: 'regular',
                          // )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: payment == 'paypal'
                            ? Border.all(color: MyColors.primaryColor, width: 2)
                            : Border.all(color: MyColors.greyish, width: 2),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      payment = 'bank';
                      setState(() {});
                      creditcardform();
                      bank1();
                      bankinfo();
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            // 'assets/images/bank.png',
                            'assets/images/bank1.jpg',
                            height: 50,
                            // color: payment == 'bank'?MyColors.primaryColor:MyColors.greyish,
                          ),
                          // vSizedBox,
                          // MainHeadingText(
                          //   text: 'Bank Transfer',
                          //   textAlign: TextAlign.center,
                          //   color: payment == 'bank'?MyColors.primaryColor:MyColors.greyish,
                          //   fontSize: 8,
                          //   fontFamily: 'regular',
                          // )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: payment == 'bank'
                            ? Border.all(color: MyColors.primaryColor, width: 2)
                            : Border.all(color: MyColors.greyish, width: 2),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: 80,
                    ),
                  ),

                  // Container(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Image.asset('assets/images/cash.png', height: 20,),
                  //       vSizedBox,
                  //       MainHeadingText(text: 'COD',textAlign: TextAlign.center, color: MyColors.greyish, fontSize: 8,fontFamily: 'regular',)
                  //     ],
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(
                  //         color: MyColors.greyish,
                  //         width: 2
                  //     ),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  //   width: 80,
                  // ),
                ],
              ),
            ),
            vSizedBox2,
            if (bank)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < adminbankdetails.length; i++)
                    // if('${adminbankdetails[i]['id']}'=='3')
                    Container(
                      decoration: BoxDecoration(
                          // color: MyColors.primaryColor,
                          border: adminbankdetails[i]['id'].toString() ==
                                  selectedIndex
                              ? Border.all(
                                  // color: _isVisible?: MyColors.primaryColor:null,
                                  color: MyColors.primaryColor,
                                  width: 2,
                                )
                              : null),
                      child: GestureDetector(
                        onTap: () {
                          print('hdh');
                          selectedIndex = adminbankdetails[i]['id'];
                          // payment = '' ;
                          print("selectedIndex........" +
                              selectedIndex.toString());
                          // print("visible"+adminbankdetails.toString());
                          // print("visible"+adminbankdetails[i]['visible'].toString());
                          // if(adminbankdetails[i]['visible'].toString()=='false')
                          // {
                          //   adminbankdetails[i]['visible']=true;
                          // }
                          // else{
                          //   adminbankdetails[i]['visible']=false;
                          // }
                          // print("visible1"+adminbankdetails[i]['visible'].toString());
                          setState(() {});
                        },
                        child: Image.network('${adminbankdetails[i]['image']}',
                            width: 60, height: 60, fit: BoxFit.fill),
                      ),
                    ),
                ],
              ),
            vSizedBox2,
            if (_bankinfo)
              Container(
                child: bankdetails(data: selectedIndex),
              ),

            // CustomTextField(controller: codeController, hintText: '4242 4242 4242 42'),
            // Container(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child:  CustomTextField(controller: codeController, hintText: 'Exp Date:'),
            //       ),
            //       SizedBox(width: 10,),
            //       Expanded(
            //         child:  CustomTextField(controller: codeController, hintText: 'CVV:'),
            //       ),
            //     ],
            //   ),
            // ),
            // CustomTextField(controller: codeController, hintText: 'Card Holder Name'),
            //
            // ParagraphText(text: 'Note: Payment with credits cards will have a surcharge of 10',
            //   textAlign: TextAlign.center,
            //   fontSize: 7,
            //   color: Color(0xFF7A7A7A),),
            // color: _isVisible ? Color(0xFF1D1E33) : Colors.blue,
            // RoundEdgedButton(text: 'check',onTap: ()async{
            //   var useridd;
            //   if (await isUserLoggedIn()) {
            //   useridd = await getCurrentUserId();
            //   print("No need to login--------$useridd");
            //   } else {
            //   // useridd = user_id;
            //   useridd = widget.ccustomer!['id'].toString();
            //   print("try to login--------$useridd");
            //       Map usersdata = await Webservices.getMap('${ApiUrls.getuserbyid}?user_id=$useridd');
            //       print('res-usersdata---${usersdata}');
            //       updateUserDetails(usersdata);
            //
            //   }
            // },),
            RoundEdgedButton(
              boderRadius: 15,
              textColor: Colors.white,
              text: 'CHECKOUT',
              color: selectedIndex != '' ||
                      payment == 'paypal' ||
                      shippingcost != 0
                  ? Color(0xff00b7ff)
                  : MyColors.greyish,
              onTap: () async {
                Address = '';
                city = '';
                state = '';
                country = '';
                zip = '';
                lng = '';
                latt = '';

                for (int i = 0; i < Addresslist.length; i++) {
                  if (Addresslist[i]['isSelected'] == true) {
                    Address = Addresslist[i]['address'].toString();
                    city = Addresslist[i]['city'].toString();
                    state = Addresslist[i]['state'].toString();
                    country = Addresslist[i]['country'].toString();
                    zip = Addresslist[i]['zip'].toString();
                    latt = Addresslist[i]['lat'].toString();
                    lng = Addresslist[i]['lng'].toString();
                    country = Addresslist[i]['country'].toString();
                  }
                }
                String pattern =
                    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$';
                RegExp regex = new RegExp(pattern);

                if (widget.ccustomer!['password_set'].toString() == '0' &&
                    passwordController.text == '') {
                  showSnackbar(context, 'Please Enter your Password.');
                } else if (!regex.hasMatch(passwordController.text) &&
                    widget.ccustomer!['password_set'].toString() == '0') {
                  showSnackbar(context,
                      'Password must have minimum letters one uppercase numbers and one special character.');
                } else if (passwordController.text !=
                    reenterpasswordController.text) {
                  showSnackbar(
                      context, 'Password and Confirm Password should be same.');
                } else if (selectedIndexaddress == null ||
                    selectedIndexaddress == '' ||
                    Address == '') {
                  showSnackbar(context, 'Please Enter your Delivery Address.');
                } else if (value == false) {
                  showSnackbar(context, 'Please Accept Terms & Conditions');
                } else if (payment == null) {
                  showSnackbar(context, 'Please select payment method');
                } else if (payment == 'paypal') {
                  print('prasoon------paypal click--------');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              // "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                              "Aao36icN-9lT4ueBmET4KDvZBw6haWtk1jtMdYvkfhIF3JiByzx8nB-18a5_WPFlPEpgI90GX2X0f4cV",
                          secretKey:
                              // "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                              "EKXaVthCUXqzu_6nSn-gxLVyO6j9tv9A0fsXzb7yGqyQnMCXL6RwSCESio1UYtjs9AzgMclXtE9RXP2X",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: [
                            {
                              "amount": {
                                "total": sum,
                                // "total": Grandtotal,
                                "currency": "USD",
                                "details": {
                                  "subtotal": sum,
                                  "shipping": '0',
                                  "shipping_discount": '0'
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) {
                            print('hello world');
                            log("onSuccess: $params");
                            // paymentId = params['paymentId'];
                            // paymentId = params['token'];
                            // paymentId = params['token'];
                            paymentId = params['data']['transactions'][0]
                                ['related_resources'][0]['sale']['id'];
                            onSuccessPaypal(params);
                            print('payment with paypal');
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled handling----: $params');
                          }),
                    ),
                  );
                } else if (selectedIndex == '1' ||
                    selectedIndex == '2' ||
                    selectedIndex == '3') {
                  String useridd;
                  if (await isUserLoggedIn()) {
                    useridd = await getCurrentUserId();
                  } else {
                    // useridd = user_id;
                    useridd = widget.ccustomer!['id'].toString();
                  }
                  Map<String, dynamic> data = {
                    // "bANKID":selectedIndex,
                    // 'trasnId':'',
                    'user_id': useridd,
                    'agent_id': agent_id,
                    'recommended_id': widget.recoid,
                    'first_name': firstnameController.text,
                    'last_name': lastnameController.text,
                    'newsletter': value1 == true ? '1' : '0',

                    'email': emailController.text,
                    'phonecode': phonenoController.text,
                    'phone': phonenoController.text,
                    'address': Address,
                    'country': country,
                    'state': state,
                    'city': city,
                    'zip': zip,
                    'lat': latt,
                    'lng': lng,
                    'shipping_cost': shippingcost.toString(),
                    'total_amount': Grandtotal.toString(),
                    // 'order_uniqueid':'fdasfdasfdasfa',
                    'payment': payment,
                    // 'seller_id':user_id,
                    'special_instruction': specialController.text,
                    'bank': selectedIndex,
                    "cartItems": convert.jsonEncode(widget.carts)
                  };
                  if (widget.ccustomer!['password_set'].toString() == '0') {
                    data['password'] = passwordController.text;
                  }

                  // loadingShow(context);
                  log('Dataforcheckout...........${data}');

                  loadingShow(context);
                  var res = await Webservices.postData(
                      apiUrl: ApiUrls.submitcheckout,
                      body: data,
                      context: context,
                      showSuccessMessage: true);
                  print('checkoutapires.............${res}');
                  print('order_id.............${res['order_id'].toString()}');
                  orderid = res['order_id'].toString();
                  if (res['status'] == 1) {
                    loadingHide(context);
                    ///auto login
                    // if(!await isUserLoggedIn()){
                    //
                    //   Map <String, dynamic> request = {
                    //     'user_id':widget.ccustomer!['id'].toString(),
                    //   };
                    //   Map usersdata = await Webservices.getMap(ApiUrls.getuserbyid,request:request);
                    //   print('res-usersdata---${usersdata}');
                    //   updateUserDetails(usersdata);
                    // }

                    // updatedevice();

                    // Navigator.pushNamed(context, MyStatefulWidget.id);

                    ///
                    if (await isUserLoggedIn()) {
                      useridd = await getCurrentUserId();
                      print("No need to login--------$useridd");
                    } else {
                      // useridd = user_id;
                      useridd = widget.ccustomer!['id'].toString();
                      print("try to login--------$useridd");
                      Map usersdata = await Webservices.getMap('${ApiUrls.getuserbyid}?user_id=$useridd');
                      print('res-usersdata---${usersdata}');
                      updateUserDetails(usersdata);

                    }
                    // if(await isUserLoggedIn()){
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ManageOrdersPage(
                    //               orderData: res['data'] ?? {},
                    //               orderid: orderid ?? '')));
                    // }
                    // else{
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          ManageOrdersPage(
                              orderData: res['data'] ?? {},
                              orderid: orderid ?? '')),
                              (Route<dynamic> route) => false);
                    // }



                    // newrp();
                    setState(() {});

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
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
                                    // push(context: context, screen: MyStatefulWidget(key: MyGlobalKeys.tabBarKey,));
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

                  log('Apiresponsecubmitcheckout...........${res}');
                }
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'If you need any support and help please click here',
                      style: TextStyle(fontSize: 16, fontFamily: 'regular'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                    primary: Color(0xff004173),

                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                // color: MyColors.primaryColor,
                // textColor: MyColors.whiteColor,
                // padding: EdgeInsets.all(0),
                // splashColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildName({ required String name, required double score}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(height: 12),
  //         Container(height: 2, color: Colors.redAccent),
  //         SizedBox(height: 12),
  //         Row(
  //           children: <Widget>[
  //
  //             SizedBox(width: 12),
  //             Text(name),
  //             Spacer(),
  //             Container(
  //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
  //               child: Text("${score}"),
  //               decoration: BoxDecoration(
  //                 color: Colors.yellow[900],
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
