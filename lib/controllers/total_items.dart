import 'item.dart';

class ItemList {
  List<Item> itemList = [
    Item(name: 'Elegant and Warm Sweater', size: 'M', price: 1999, rfid: 1001),
    Item(name: 'Maroon Printed Shirt', size: '30', price: 599, rfid: 1002),
    Item(name: 'Navy Printed Shorts', size: 'L', price: 799, rfid: 1003),
    Item(name: 'White Solid Top', size: 'S', price: 999, rfid: 1004),
    Item(name: 'Blue Textured Trousers', size: 'L', price: 1999, rfid: 1005),
    Item(name: 'Black Solid Track Pants', size: '28', price: 999, rfid: 1006),
  ];
  void delete(String deleterfid) {
    itemList.removeWhere((item) => item.rfid == (deleterfid));
  }
}
