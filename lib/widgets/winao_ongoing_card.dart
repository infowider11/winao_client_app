import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:intl/intl.dart';

class WinaoOngoingCard extends StatefulWidget {
  final Map data;
  const WinaoOngoingCard(this.data,{Key? key, }) : super(key: key);

  @override
  State<WinaoOngoingCard> createState() => _WinaoOngoingCardState();
}

class _WinaoOngoingCardState extends State<WinaoOngoingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff00a1e1)),
        borderRadius: BorderRadius.circular(20),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ParagraphText(text: 'OrderId: #${widget.data['order_uniqueid']}'),
                // ParagraphText(text: 'Order Date: ${widget.data['created']}'),
                hSizedBox,
                // ParagraphText(text: 'Payment Details :', fontWeight: FontWeight.bold,),
                ParagraphText(text: 'Payment By: ${widget.data['payment_method']}',),
                // ParagraphText(text: 'Order Date: ${widget.data['created']}'),
                ParagraphText(text: 'Order Date : ${DateFormat.yMMMd().format(DateTime.parse(widget.data['created']))}'),
                // ParagraphText(text: 'Transaction Id: ${widget.data['payment_id']}'),
                if(widget.data['order_status']=='1')
                ParagraphText(text: 'Payment Status: ',
                    color: Colors.black
                ),
                if(widget.data['order_status']=='1')
                ParagraphText(text: ' ${
                    (widget.data['payment_status']=='0'&&widget.data['receipt_status']=='1')?'Paid Waiting for Verification':
                    (widget.data['payment_status']=='0'&&widget.data['receipt_status']=='0')?'Waiting for payment':
                    (widget.data['payment_status']=='2'&&widget.data['receipt_status']=='2')?'Rejected':
                    'Paid'
                    // 'Order in way'
                    // 'Verified Payment Waiting for Shipping Or Local Pickup'
                }',
                    color: widget.data['payment_status']=='0'?Colors.red:Colors.orange
                ),
                // ParagraphText(text: 'Transaction Id: ${widget.data['payment_id']}'),
            // t('Payment Status: ${(Getorderdetails['payment_status']=='0'&& Getorderdetails['receipt_status']=='1')?'Paid Waiting for Verification':
            // (Getorderdetails['payment_status']=='0'&& Getorderdetails['receipt_status']=='0')?' Waiting for Payment':
            // (Getorderdetails['payment_status']=='2'&& Getorderdetails['receipt_status']=='2')?'Rejected(please Resubmit receipt)':
            // 'Verified Payment Waiting for Shipping Or Local Pickup'}',


              ],
            ),
          ),
          hSizedBox,
          vSizedBox,
          SubHeadingText(text: '\$${widget.data['grand_total']}', color: Colors.green,),
        ],
      ),
    );
  }
}
