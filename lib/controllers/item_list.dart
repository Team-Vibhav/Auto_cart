// import 'item.dart';
import 'dart:async';
import 'dart:math';
import 'item.dart';
import 'total_items.dart';

class BoughtItemList {
  List<Item> boughtItemList = [
    Item(name: 'Elegant and Warm Sweater', size: 'M', price: 1999, rfid: 1001),
    Item(name: 'Maroon Printed Shirt', size: '30', price: 599, rfid: 1002),
    Item(name: 'Navy Printed Shorts', size: 'L', price: 799, rfid: 1003),
  ];

  void addItem(Item item) async {
    Item newItem = Item(
        name: '${item.name}',
        size: '${item.size}',
        rfid: item.rfid,
        price: item.price);
    boughtItemList.add(newItem);
    print('Bought item list ${newItem.name}');
    print('Bought item list ${item.rfid}');
    print('Bought item list ${boughtItemList[0].name}');
    print('Bought item list $boughtItemList');
  }

// List<int> rfidList = [rndm.nextInt(6)+1001, ];

  double getTotal() {
    double total = 0;
    print('${boughtItemList[0].name}');
    print('${boughtItemList.length}');
    for (int i = 0; i < boughtItemList.length; i++) {
      total += boughtItemList[i].price;
    }
    print('total :$total');
    return total;
  }

  double getDiscount() {
    return 0.0;
  }

  double getTax() {
    return 0.0;
  }
}
