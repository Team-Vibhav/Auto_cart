import 'package:flutter/material.dart';
import 'controllers/item_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  BoughtItemList list = BoughtItemList();

  Razorpay razorpay;

  void initState() {
    super.initState();
    razorpay = Razorpay();
    print('inside init state');
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  double getAmount() {
    double totalAmount = list.getTotal() - list.getDiscount() + list.getTax();
    return totalAmount;
  }

  void dispose() {
    razorpay.clear();

    super.dispose();
  }

  void openCheckout() {
    print(getAmount());
    var options = {
      'key': 'rzp_test_16kdbxiz45grwP',
      'amount': '${getAmount() * 100}',
      'name': 'FBB Mall Official Account',
      'description': 'Payment for the Order',
      'prefill': {
        'contact': '7832081190',
        'email': 'vaishnavisood123@gmail.com',
        'external': {
          'wallets': ['paytm', 'amazonpay', 'paypal', 'phonepe'],
        }
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget getItemList() {
    List<Widget> displayList = [];
    for (int i = 0; i < list.boughtItemList.length; i++) {
      var newItem = Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(list.boughtItemList[i].name,
                style: GoogleFonts.lora(
                  fontSize: 17.0,
                  // fontWeight: FontWeight.w700,
                  color: Colors.black,
                  // Color(0xFF4D6C6C)
                )),
            Text('Size: ${list.boughtItemList[i].size}',
                style: GoogleFonts.lora(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  // Color(0xFF4D6C6C),
                )),
            Text('Rs. ${list.boughtItemList[i].price}',
                style: GoogleFonts.lora(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4D6C6C))),
          ],
        ),
      );
      displayList.add(newItem);
    }
    return Column(children: displayList);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Color(0xFF4D6C6C),
          title: Center(
            child: Text('Order Details',
                style: GoogleFonts.lora(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFffffff))),
          ),
          leading: null,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all((15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('My Cart',
                      style: GoogleFonts.lora(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4D6C6C))),
                ),
                getItemList(),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price Details',
                          style: GoogleFonts.lora(
                              fontSize: 27.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF4D6C6C))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total MRP',
                              style: GoogleFonts.lora(
                                  fontSize: 15.0, color: Colors.black)),
                          Text(
                            '${list.getTotal()}',
                            style: GoogleFonts.lora(
                                fontSize: 15.0, color: Color(0xFF4D6C6C)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount on MRP',
                              style: GoogleFonts.lora(
                                  fontSize: 15.0, color: Colors.black)),
                          Text('${list.getDiscount()}',
                              style: GoogleFonts.lora(
                                  fontSize: 15.0, color: Color(0xFF4D6C6C))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Tax:',
                              style: GoogleFonts.lora(
                                  fontSize: 15.0, color: Colors.black)),
                          Text('${list.getTax()}',
                              style: GoogleFonts.lora(
                                  fontSize: 15.0, color: Color(0xFF4D6C6C))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount:',
                              style: GoogleFonts.lora(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          Text('${getAmount()}',
                              style: GoogleFonts.lora(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4D6C6C))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            openCheckout();
          },
          child: Container(
            height: 60.0,
            child: BottomAppBar(
              child: Center(
                child: Text('Proceed to Payment',
                    style: GoogleFonts.lora(
                        fontSize: 27.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4D6C6C))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handlerPaymentError() {
    print('Pyament success');
    Fluttertoast.showToast(
        msg: "Payment Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void handlerPaymentSuccess() {
    print('Pyament Error');
    Fluttertoast.showToast(
        msg: "There was some error. Try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void handlerExternalWallet() {
    print('Payment External Error');
  }
}
