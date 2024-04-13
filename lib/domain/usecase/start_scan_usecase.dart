import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class StartScanUseCase {
  final BluetoothRepository _repository;

  StartScanUseCase(this._repository);

  Stream<List<ScanResult>> call() {
    return _repository.startScan();
  }
}
