import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectToDeviceUseCase {
  final BluetoothRepository bluetoothRepository;
  ConnectToDeviceUseCase({required this.bluetoothRepository});

  Future<void> call(BluetoothDevice device) {
    return bluetoothRepository.connectToDevice(device);
  }
}
