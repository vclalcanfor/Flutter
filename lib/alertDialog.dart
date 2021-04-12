import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deviceProvider.dart';
import 'device.dart';

class AlertRemove extends StatelessWidget {
  SwitchDevice device;

  AlertRemove(this.device);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Remove Device?',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.grey[900],
      content: Text(
        'Remove ${device.name}?',
        style: TextStyle(
          color: Colors.grey
        ),
      ),
      actions: [
        TextButton(
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.deepPurple[400]
              ),
            ),
            onPressed: () {
              context.read<DeviceProvider>().removeDevice(device);
              Navigator.of(context).pop();
            },
        ),
        TextButton(
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.deepPurple[400]
              ),
            ),
            onPressed: () {
              context.read<DeviceProvider>().removeDevice(device);
              Navigator.of(context).pop();
              context.read<DeviceProvider>().addNewDevice(device.name);
            },
        ),
      ],
    );
  }
}