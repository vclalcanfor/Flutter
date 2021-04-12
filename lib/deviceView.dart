import 'package:flutter/material.dart';
import 'device.dart';
import 'deviceProvider.dart';
import 'package:provider/provider.dart';
import 'animationButton.dart';

class DeviceView extends StatefulWidget {
  final SwitchDevice device;

  DeviceView({this.device});

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  TextEditingController _textEditingName = TextEditingController();
  TextEditingController _textEditingPubTopic = TextEditingController();

  @override
  void initState() {
    if(widget.device != null)
      _textEditingName.text = widget.device.name;
      _textEditingPubTopic.text = widget.device.pubTopic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Add New Device'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          elevation: 10,
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Increment',
          child: Icon(Icons.close),
        ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _textEditingName,
              decoration: InputDecoration(
                labelText: 'Device Name',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 2,
                ),
              ),
              //onFieldSubmitted: (name) => submit(),
              style: TextStyle(
                color: Colors.white
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _textEditingPubTopic,
              decoration: InputDecoration(
                labelText: 'Publish Topic',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 2,
                ),
              ),
              //onFieldSubmitted: (name) => submit(),
              style: TextStyle(
                color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  ),
                ),
              onPressed: submit
            ),
          ],
        ),
      ),
    );
  }

    void submit(){
      String name = _textEditingName.text;
      String pubTopic = _textEditingPubTopic.text;
      if(widget.device != null){
        context.read<DeviceProvider>().editDeviceName(widget.device, name);
        context.read<DeviceProvider>().editDevicePubTopic(widget.device, pubTopic);
      } else {
        context.read<DeviceProvider>().addNewDevice(name, pubTopic:pubTopic);
      }
      Navigator.pop(context, _textEditingName.text);
  }
}

