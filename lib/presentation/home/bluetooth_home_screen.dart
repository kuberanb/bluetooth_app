import 'package:bluetooth_app/presentation/home/bluetooth_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class BluetoothHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bluetooth Devices',
          style: TextStyle(),
        ),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     print("refrsh button clicked");
          //     Provider.of<BluetoothHomeProvider>(context, listen: false)
          //         .startScan();
          //   },
          //   child: const Text(
          //     "refresh",
          //     style: TextStyle(),
          //   ),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.stop),
          //   onPressed: () async {
          //     // Stop scanning for Bluetooth devices
          //     await Provider.of<BluetoothHomeProvider>(context, listen: false)
          //         .stopScan();
          //   },
          // ),
        ],
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: Provider.of<BluetoothHomeProvider>(context).startScan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("snapshot connectionstate waiting");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print("snapshot error occured");
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("snapshot empty");
            return const Center(
              child: Text(
                'No Bluetooth devices found.',
                style: TextStyle(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ScanResult result = snapshot.data![index];
                bool isConnected = result.device.isConnected;
                return ListTile(
                  title: Text(result.device.platformName),
                  subtitle: Text(result.device.remoteId.toString()),
                  trailing: isConnected
                      ? const CircleAvatar(backgroundColor: Colors.green)
                      : const SizedBox(),
                  onTap: () {
                    // Check if the device is connected
                    if (result.device.isConnected) {
                      // Disconnect from the device
                      Provider.of<BluetoothHomeProvider>(context, listen: false)
                          .disconnectFromDevice(result.device);
                    } else {
                      // Connect to the device
                      Provider.of<BluetoothHomeProvider>(context, listen: false)
                          .connectToDevice(result.device);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
