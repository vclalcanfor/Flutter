import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'device.dart';

class DeviceProvider with ChangeNotifier {

  List<SwitchDevice> devices = List<SwitchDevice>.empty(growable:true);

  void setTime(SwitchDevice device, TimeOfDay time){
      device.time = time;
      print(device.time);
      notifyListeners();
  }
  

  void editDeviceName(SwitchDevice device, String name){
    if (name != null && name != ''){
      device.name = name;
      notifyListeners();
    }
  }

  void editDevicePubTopic(SwitchDevice device, String pubTopic){
    if (pubTopic != null && pubTopic != ''){
      device.pubTopic = pubTopic;
      notifyListeners();
    }
  }

  void removeDevice(SwitchDevice device){
    devices.remove(device);
    print(devices.length);
    notifyListeners();
  }

  void addNewDevice(String name, {String pubTopic = ''}){
    if (name != null && name != ''){
      devices.add(SwitchDevice(name, pubTopic: pubTopic));
      print(devices.length);
      notifyListeners();
    }
  }

  void changeStateDevice(SwitchDevice device){
    device.state = !device.state;
    print("${device.name} ${device.state}");
    notifyListeners();
  }

  void changeStateDeviceTimer(SwitchDevice device){
    device.timer = !device.timer;
    print("${device.name} Timer ${device.timer}");
    notifyListeners();
  }

  
}

