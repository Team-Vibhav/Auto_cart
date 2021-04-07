import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'add_to_cart.dart';
import 'connected.dart';
import 'controllers/connections.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // String _address = "...";
  // String _name = "...";

  // Timer _discoverableTimeoutTimer;
  // int _discoverableTimeoutSecondsLeft = 0;

  // // BackgroundCollectingTask _collectingTask;

  // bool _autoAcceptPairingRequests = false;

  // void initState() {
  //   super.initState();

  //   // Get current state
  //   FlutterBluetoothSerial.instance.state.then((state) {
  //     setState(() {
  //       _bluetoothState = state;
  //     });
  //   });

  //   Future.doWhile(() async {
  //     // Wait if adapter not enabled
  //     if (await FlutterBluetoothSerial.instance.isEnabled) {
  //       return false;
  //     }
  //     await Future.delayed(Duration(milliseconds: 0xDD));
  //     return true;
  //   }).then((_) {
  //     // Update the address field
  //     FlutterBluetoothSerial.instance.address.then((address) {
  //       setState(() {
  //         _address = address;
  //       });
  //     });
  //   });

  //   FlutterBluetoothSerial.instance.name.then((name) {
  //     setState(() {
  //       _name = name;
  //     });
  //   });

  //   FlutterBluetoothSerial.instance
  //       .onStateChanged()
  //       .listen((BluetoothState state) {
  //     setState(() {
  //       _bluetoothState = state;

  //       // Discoverable mode is disabled when Bluetooth gets disabled
  //       _discoverableTimeoutTimer = null;
  //       _discoverableTimeoutSecondsLeft = 0;
  //     });
  //   });
  // }

  // void dispose() {
  //   FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
  //   // _collectingTask?.dispose();
  //   _discoverableTimeoutTimer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    const kHomeTextStyle = TextStyle(
      fontSize: 30.0,
    );

    //           ElevatedButton(
    //             onPressed: () {
    //               return
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              child: Center(
                child: Icon(
                  Icons.bluetooth_disabled,
                  size: 200.0,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        } else if (future.connectionState == ConnectionState.done) {
          // return MyHomePage(title: 'Flutter Demo Home Page');
          return Middle();
        } else {
          return Middle();
        }
      },
      // child: MyHomePage(title: 'Flutter Demo Home Page'),
    );

    // Navigator.pushNamed(context, '/qrcodescanner');

    // child: Text('Connect to Bluetooth'),
    // ),

    //               // to switch on or off the bluetooth of mobile
    //               SwitchListTile(
    //             title: const Text('Enable Bluetooth'),
    //             value: _bluetoothState.isEnabled,
    //             onChanged: (bool value) {
    //               // Do the request and update with the true value then
    //               future() async {
    //                 // async lambda seems to not working
    //                 if (value)
    //                   await FlutterBluetoothSerial.instance.requestEnable();
    //                 else
    //                   await FlutterBluetoothSerial.instance.requestDisable();
    //               }

    //               future().then((_) {
    //                 setState(() {});
    //               });
    //             },
    //           ),
    // //to open settings of bluetooth
    //           ListTile(
    //             title: const Text('Bluetooth status'),
    //             subtitle: Text(_bluetoothState.toString()),
    //             trailing: RaisedButton(
    //               child: const Text('Settings'),
    //               onPressed: () {
    //                 FlutterBluetoothSerial.instance.openSettings();
    //               },
    //             ),
    //           ),
    //           //to show local bluetooth adaptor name and address

    //           ListTile(
    //             title: const Text('Local adapter address'),
    //             subtitle: Text(_address),
    //           ),
    //           ListTile(
    //             title: const Text('Local adapter name'),
    //             subtitle: Text(_name),
    //             onLongPress: null,
    //           ),

    //           //to explore discovered devices
    //           ListTile(title: const Text('Devices discovery and connection')),
    //           SwitchListTile(
    //             title: const Text('Auto-try specific pin when pairing'),
    //             subtitle: const Text('Pin 1234'),
    //             value: _autoAcceptPairingRequests,
    //             onChanged: (bool value) {
    //               setState(() {
    //                 _autoAcceptPairingRequests = value;
    //               });
    //               if (value) {
    //                 FlutterBluetoothSerial.instance.setPairingRequestHandler(
    //                     (BluetoothPairingRequest request) {
    //                   print("Trying to auto-pair with Pin 1234");
    //                   if (request.pairingVariant == PairingVariant.Pin) {
    //                     return Future.value("1234");
    //                   }
    //                   return null;
    //                 });
    //               } else {
    //                 FlutterBluetoothSerial.instance
    //                     .setPairingRequestHandler(null);
    //               }
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    // );
  }
}

class Middle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Color(0xFFF5DFDC),
      //   body:
      //        SafeArea(
      //         child: Container(
      //           child: Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: [
      //                 Text('Welcome to FBB', style: kHomeTextStyle),
      //                 Text('Scan The QR Code provided on the cart to continue...'),
      //                 ElevatedButton(
      //                   onPressed: () {
      //                     Navigator.pushNamed(context, '/qrcodescanner');
      //                   },
      //                   child: Text('Open QR Code Scanner'),
      //                 ),
      body: SelectBondedDevicePage(
        onChatPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddToCart(server: device);
              },
            ),
          );
        },
      ),
    );
  }
}
