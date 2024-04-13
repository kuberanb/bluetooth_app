import 'package:bluetooth_app/data/datasource/bluetooth_datasource.dart';
import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothRepositoryImpl extends BluetoothRepository {
  final BluetoothDataSource bluetoothDataSource;

  BluetoothRepositoryImpl({required this.bluetoothDataSource});

  @override
  Future<void> connectToDevice(BluetoothDevice device) async {
    await bluetoothDataSource.connectToDevice(device);
  }

  @override
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await bluetoothDataSource.disconnectFromDevice(device);
  }

  @override
  Stream<List<ScanResult>> startScan() async* {
    yield* bluetoothDataSource.startScan();
  }

  @override
  Future<void> stopScan() async {
    await bluetoothDataSource.stopScan();
  }
}
