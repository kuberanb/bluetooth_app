import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BluetoothRepository {
  Stream<List<ScanResult>> startScan();
  Future<void> stopScan();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<void> disconnectFromDevice(BluetoothDevice device);
}

// var subscription = FlutterBluePlus.onScanResults.listen((event) { 

  
// })
