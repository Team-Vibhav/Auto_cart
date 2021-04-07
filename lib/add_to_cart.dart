import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';
import 'controllers/item.dart';
import 'controllers/item_list.dart';
import 'controllers/total_items.dart';

class AddToCart extends StatefulWidget {
  final BluetoothDevice server;

  const AddToCart({this.server});
  @override
  _AddToCartState createState() => _AddToCartState();
}

ItemList list = ItemList();
final streamcontroller = StreamController<int>();

class _AddToCartState extends State<AddToCart> {
  BoughtItemList boughtList = BoughtItemList();
  ScrollController controller;
  List<Item> list1 = [];
  void dispose() {
    streamcontroller.close();
    super.dispose();
  }

  // var stream = RfidCreator().stream.map((i) => list
  //     .itemList[list.itemList.indexWhere((element) => (element.rfid == i))]);
  Stream<int> getStream() {
    Duration interval = Duration(seconds: 2);
    Stream<int> stream = Stream<int>.periodic(interval, transform);
    stream = stream.take(4);
    return stream;
  }

  int transform(value) {
    value += 1001;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4D6C6C),
          title: Center(
            child: Text('Your Cart',
                style: GoogleFonts.lora(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFffffff))),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pop;
              }),
        ),
        body: StreamBuilder(
          stream: getStream().map((i) => list.itemList[
              list.itemList.indexWhere((element) => (element.rfid == i))]),
          // RfidCreator().stream.map((i) => list.itemList[
          //     list.itemList.indexWhere((element) => (element.rfid == i))]),
          builder: (context, AsyncSnapshot<Item> snapshot) {
            Widget showing;
            if (snapshot.connectionState == ConnectionState.waiting) {
              showing = Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity);
            }
            if (snapshot.connectionState == ConnectionState.active) {
              list1.add(snapshot.data);

              showing = ListView.builder(
                itemCount: list1.length,
                itemBuilder: (context, int index) {
                  return ItemCard(
                      name: list1[index].name,
                      size: list1[index].size,
                      price: list1[index].price);
                },
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              showing = ListView.builder(
                itemCount: list1.length,
                itemBuilder: (context, int index) {
                  return ItemCard(
                      name: list1[index].name,
                      size: list1[index].size,
                      price: list1[index].price);
                },
              );
            }

            return showing != null
                ? showing
                : Container(
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity);
            ;
          },
        ),

        // controller: controller,
        //   builder: (BuildContext context, int index) {
        //     return ItemCard(
        //         name: list.itemList[index].name,
        //         size: list.itemList[index].size,
        //         price: list.itemList[index].price);
        //   },
        //   itemCount: list.itemList.length,
        // ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/paymentpage');
          },
          child: Container(
            height: 60.0,
            child: BottomAppBar(
              child: Center(
                child: Text('End Shopping',
                    style: GoogleFonts.lora(
                        fontSize: 27.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4D6C6C))),
              ),
            ),
          ),
        ),
      ),

      // child: Container(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding:
      //             const EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             IconButton(
      //                 icon: Icon(Icons.arrow_back),
      //                 onPressed: () {
      //                   Navigator.pop;
      //                 }),
      //             Text('Your Cart'),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String name;
  final String size;
  final int price;
  ItemCard({this.name, this.size, this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFdae5e5),
        ),
        height: 100,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              name,
              style:
                  GoogleFonts.lora(fontSize: 17.0, fontWeight: FontWeight.w700),
            ),
            Text(
              'Size: $size',
              style:
                  GoogleFonts.lora(fontSize: 17.0, fontWeight: FontWeight.w700),
            ),
            Text(
              'Price: $price',
              style: GoogleFonts.lora(
                color: Color(0xFF4D6C6C),
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RfidCreator {
  ItemList list = ItemList();
  List<int> rfidList = List.generate(6, (i) => i + 1001);
  int getRfid() {
    Random rndm = Random();
    return rfidList[rndm.nextInt(6)];
  }

  RfidCreator() {
    Timer.periodic(Duration(seconds: 2), (t) {
      int _rfid = getRfid();
      streamcontroller.sink.add(_rfid);
    });
  }
  Stream<int> get stream => streamcontroller.stream;
}
