import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';

class StopScanUseCase {
  final BluetoothRepository bluetoothRepository;

  StopScanUseCase({required this.bluetoothRepository});

  Future<void> call() {
    return bluetoothRepository.stopScan();
  }
}
