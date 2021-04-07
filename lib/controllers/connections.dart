import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'device.dart';

class SelectBondedDevicePage extends StatefulWidget {
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool checkAvailability;
  final Function onChatPage;

  const SelectBondedDevicePage(
      {this.checkAvailability = true, @required this.onChatPage});

  @override
  _SelectBondedDevicePage createState() => new _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = [];
  _DeviceWithAvailability singleDevice;

  // Availability
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _isDiscovering;

  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
        for (int i = 0; i < devices.length; i++) {
          if (devices[i].device.address == 'B3:E5:E6:1C:5C:7C') {
            singleDevice = devices[i];
            print(singleDevice.device.address);
          }
        }
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

// _discoveryStreamSubscription.onDone(() {
//       setState(() {
//         _isDiscovering = false;
//       });
//     });
  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            // if (singleDevice.device == r.device
            // && r.device.address == 'B3:E5:E6:1C:5C:7C'
            // ) {
            print(r.device.address);
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
            // singleDevice.availability = _DeviceAvailability.yes;
            // singleDevice.rssi = r.rssi;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map(
          (_device) => BluetoothDeviceListEntry(
            device: _device.device,
            onTap: () {
              widget.onChatPage(_device.device);
            },
          ),
        )
        .toList();
    return ListView(
      children: list,
      // children: [list],
    );
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // BluetoothDeviceListEntry list = BluetoothDeviceListEntry(
  //   //   device: singleDevice,
  //   // );
  //   List<BluetoothDeviceListEntry> list = devices
  //       .map(
  //         (_device) => BluetoothDeviceListEntry(
  //           device: _device.device,
  //           onTap: () {
  //             widget.onChatPage(_device.device);
  //           },
  //         ),
  //       )
  //       .toList();
  //   return ListView(
  //     children: list,
  //   // children: [list],
  //   );
  //   // return Scaffold(
  //   //     body: ElevatedButton(
  //   //   onPressed: widget.onChatPage(singleDevice.device),
  //   //   child: Text('Click to connect'),
  //   // ));
  //   // 
  // }


