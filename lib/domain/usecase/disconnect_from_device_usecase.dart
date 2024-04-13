import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DisconnectFromDeviceUseCase {
  final BluetoothRepository bluetoothRepository;

  DisconnectFromDeviceUseCase({required this.bluetoothRepository});

  Future<void> call(BluetoothDevice device) {
    return bluetoothRepository.disconnectFromDevice(device);
  }
}
