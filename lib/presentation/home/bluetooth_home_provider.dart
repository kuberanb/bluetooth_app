import 'package:bluetooth_app/domain/usecase/connect_to_device_usecase.dart';
import 'package:bluetooth_app/domain/usecase/disconnect_from_device_usecase.dart';
import 'package:bluetooth_app/domain/usecase/start_scan_usecase.dart';
import 'package:bluetooth_app/domain/usecase/stop_scan_use_case.dart';
import 'package:bluetooth_app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothHomeProvider extends ChangeNotifier {
  final ConnectToDeviceUseCase _connectToDeviceUseCase =
      getIt<ConnectToDeviceUseCase>();
  final DisconnectFromDeviceUseCase _disconnectFromDeviceUseCase =
      getIt<DisconnectFromDeviceUseCase>();
  final StartScanUseCase _startScanUseCase = getIt<StartScanUseCase>();
  final StopScanUseCase _stopScanUseCase = getIt<StopScanUseCase>();

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await _connectToDeviceUseCase(device);
    } catch (e) {
      print("exception occured in connectToDevice provider : $e");
    }
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      await _disconnectFromDeviceUseCase(device);
    } catch (e) {
      print("exception occured in disconnectFromDevice provider : $e");
    }
  }

  Future<void> stopScan() async {
    try {
      await _stopScanUseCase();
    } catch (e) {
      print("exception occured in stopScan provider : $e ");
    }
  }

  Stream<List<ScanResult>> startScan() async* {
    try {
      // Stream<List<ScanResult>> scanResultList = _startScanUseCase();
      yield* _startScanUseCase();
      //   await for (var scanResultList in _startScanUseCase()) {
      //   for (var scanResult in scanResultList) {
      //     yield scanResult; // Yield each individual scan result
      //   }
      // }
    } catch (e) {
      print("exception occured in strtScan provider : $e");
      yield <ScanResult>[]; // Return an empty list on error
    }
  }
}
