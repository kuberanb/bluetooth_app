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

  Future<void> discoverServices(BluetoothDevice device) async {
    try {
      // Note: You must call discoverServices after every re-connection!
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) {
        // do something with service
      });
    } catch (e) {
      print("exeception occured in discover series : $e");
    }
  }

  Future<void> writeData(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    // Find the service and characteristic you want to communicate with
    BluetoothService service = services.firstWhere(
      (s) => s.uuid == Guid('your_service_uuid'),
      orElse: () => throw Exception('Service not found'),
    );
    BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == Guid('your_characteristic_uuid'),
      orElse: () => throw Exception('Characteristic not found'),
    );

    // Write data
    await characteristic.write([0x01, 0x02, 0x03], withoutResponse: true);
  }

  Future<void> readData(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    // Find the service and characteristic you want to communicate with
    BluetoothService service = services.firstWhere(
      (s) => s.uuid == Guid('your_service_uuid'),
      orElse: () => throw Exception('Service not found'),
    );
    BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == Guid('your_characteristic_uuid'),
      orElse: () => throw Exception('Characteristic not found'),
    );

    List<int> value = await characteristic.read();
  }

  Future<void> listenToNotifications(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    // Find the service and characteristic you want to communicate with
    BluetoothService service = services.firstWhere(
      (s) => s.uuid == Guid('your_service_uuid'),
      orElse: () => throw Exception('Service not found'),
    );
    BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == Guid('your_characteristic_uuid'),
      orElse: () => throw Exception('Characteristic not found'),
    );

    // Listen for notifications
    await characteristic.setNotifyValue(true);

    characteristic.value.listen((data) {
      // Data received from notifications
      print('Received: $data');
    });
  }
}
