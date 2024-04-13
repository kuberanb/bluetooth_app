

import 'package:bluetooth_app/data/datasource/bluetooth_datasource.dart';
import 'package:bluetooth_app/data/repository/bluetooth_repository_impl.dart';
import 'package:bluetooth_app/domain/repository/bluetootth_repository.dart';
import 'package:bluetooth_app/domain/usecase/connect_to_device_usecase.dart';
import 'package:bluetooth_app/domain/usecase/disconnect_from_device_usecase.dart';
import 'package:bluetooth_app/domain/usecase/start_scan_usecase.dart';
import 'package:bluetooth_app/domain/usecase/stop_scan_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setUpLocator(){

  getIt.registerLazySingleton<BluetoothDataSource>(() => BluetoothDataSourceImpl());
  getIt.registerLazySingleton<BluetoothRepository>(() =>BluetoothRepositoryImpl(bluetoothDataSource:getIt<BluetoothDataSource>()));
  getIt.registerLazySingleton<ConnectToDeviceUseCase>(() =>ConnectToDeviceUseCase(bluetoothRepository: getIt<BluetoothRepository>()));
  getIt.registerLazySingleton<DisconnectFromDeviceUseCase>(() =>DisconnectFromDeviceUseCase(bluetoothRepository: getIt<BluetoothRepository>()));
  getIt.registerLazySingleton<StartScanUseCase>(() => StartScanUseCase(getIt<BluetoothRepository>()));
  getIt.registerLazySingleton<StopScanUseCase>(() => StopScanUseCase(bluetoothRepository: getIt<BluetoothRepository>()));
  
}