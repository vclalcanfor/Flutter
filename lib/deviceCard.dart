import 'package:flutter/material.dart';
import 'package:mqtt_app/alertDialog.dart';
import 'device.dart';
import 'deviceProvider.dart';
import 'package:provider/provider.dart';

class DeviceCard extends StatelessWidget {
  final SwitchDevice device;
  final Function(SwitchDevice) onTap;
  final Function(SwitchDevice) onTapTimer;
  final Function(SwitchDevice) onLongPress;

  DeviceCard({
    @required this.device,
    @required this.onTap,
    @required this.onTapTimer,
    @required this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Dismissible(
          key: Key(device.hashCode.toString()),
          direction: DismissDirection.startToEnd,
          background: Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            child: Icon(
              Icons.delete, 
              color: Colors.white,
              size: 40,),
            alignment: Alignment.centerLeft,
          ),
          onDismissed: (direction) {
            showDialog(
              context: context,
               builder: (BuildContext context) {
                 return AlertRemove(device);
               },
            );
          },
          child: GestureDetector(
            onLongPress: () => onLongPress(device),
            child: Container(
              width: (orientation == Orientation.portrait) ? width/2.2 : width/3.2,
              padding: EdgeInsets.symmetric(vertical: 35, horizontal:30),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      device.name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[400],),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: SizedBox(width:10)),
                          GestureDetector(
                            onTap: () => onTap(device),
                            child: Container(
                              decoration: BoxDecoration(
                                color: device.state ? Colors.grey[800] : Colors.black,
                                shape: BoxShape.circle
                              ),
                              height: 55,
                              width: 55,
                              child: Icon(
                                Icons.power_settings_new,
                                color: (device.state) ? Colors.lightGreenAccent : Colors.redAccent,
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(flex:2, child: SizedBox(width:10)),
                          GestureDetector(
                            onTap: () => onTapTimer(device),
                            onLongPress: () {
                              selectTime(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: device.timer ? Colors.grey[800] : Colors.black,
                                shape: BoxShape.circle
                              ),
                              height: 55,
                              width: 55,
                              child: Icon(
                                (device.timer) ? Icons.alarm : Icons.alarm_off,
                                color: (device.timer) ? Colors.lightGreenAccent : Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox(width:10)),
                        ],
                      ),
                      SizedBox(height:10),
                      device.timer ? 
                        device.time != null ? 
                          Text(
                            '${device.time.hour.toString().padLeft(2,'0')}:${device.time.minute.toString().padLeft(2,'0')}',
                            style: TextStyle(color: Colors.white),
                            ) : 
                          Text(
                            'No Timer set',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            )
                        : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height:10),
      ],
    );
  }

   Future<Null> selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: (device.time != null) ? device.time : TimeOfDay.now(),
    );
    context.read<DeviceProvider>().setTime(device, picked);
  }
}