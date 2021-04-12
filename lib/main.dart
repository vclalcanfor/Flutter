import 'package:flutter/material.dart';
import 'package:mqtt_app/deviceView.dart';
import 'device.dart';
import 'deviceCard.dart';
import 'package:provider/provider.dart';
import 'deviceProvider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DeviceProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      home: Home(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primaryColor: Colors.grey[800],
        backgroundColor: Colors.black,
        buttonColor: Colors.deepPurpleAccent,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      shape: BoxShape.circle
                    ),
                    height: 55,
                    width: 55,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.menu), 
                      iconSize: 35,
                      onPressed: (){}
                    ),
                  ),
                  SizedBox(width: 45),
                  Text(
                    'SmartHome',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
              Container(
                height:35,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
                ),
              Consumer<DeviceProvider>(
                builder: (context, deviceProvider, child){
                  return deviceProvider.devices.isNotEmpty 
                    ? Expanded(
                      child: StaggeredGridView.countBuilder(
                        itemCount: deviceProvider.devices.length,
                        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          return DeviceCard(
                            device: deviceProvider.devices[index],
                            onTap: deviceProvider.changeStateDevice,
                            onTapTimer: deviceProvider.changeStateDeviceTimer,
                            onLongPress: goToEditDeviceView,
                          );
                        },
                      ),
                    )
                    : Center(child: Text(
                      "No devices added", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        ),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle
        ),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          elevation: 10,
          onPressed: goToNewDeviceView,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ), 
    );
  }

  // Navigation
  void goToNewDeviceView(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return DeviceView();
      }
    ));
  }

  void goToEditDeviceView(SwitchDevice device){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return DeviceView(device: device);
      }
    ));
  }
}
