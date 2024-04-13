import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BluetoothDataSource {
  Stream<List<ScanResult>> startScan();
  Future<void> stopScan();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<void> disconnectFromDevice(BluetoothDevice device);
}

class BluetoothDataSourceImpl extends BluetoothDataSource {
  // final FlutterBluePlus flutterBlue;

  BluetoothDataSourceImpl(

      // required this.flutterBlue

      );

  @override
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (e) {
      print("Exception Occured While bluetooth Connection : $e");
    }
  }

  @override
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      device.disconnect();
    } catch (e) {
      print("Error Occured While Disconecting Bluetooth device : $e");
    }
  }

  @override
  Stream<List<ScanResult>> startScan() async* {
    List<ScanResult> scanResult = [];

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    FlutterBluePlus.onScanResults.listen((event) {
      print("scanResult length : ${event.length}");
      if (event.isNotEmpty) {
        scanResult = event;
      }
    });

    yield scanResult;
  }

  @override
  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print("Exception Occured while stop scan bluetooth : ${e}");
    }
  }
}
