import 'package:flutter/material.dart';

class SwitchDevice{

  String name;
  bool state;
  bool timer;
  TimeOfDay time;
  String pubTopic;

  SwitchDevice(this.name, {this.state = false, this.timer = false, this.time, this.pubTopic = ''});
}
