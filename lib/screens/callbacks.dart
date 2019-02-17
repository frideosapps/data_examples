import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:frideos/frideos.dart';

class CallbacksPage extends StatefulWidget {
  @override
  CallbacksPageState createState() {
    return new CallbacksPageState();
  }
}

class CallbacksPageState extends State<CallbacksPage> {
  String dateTime = '';
  String text = '';

  final streamedTime = StreamedValue<String>();
  final streamedText = StreamedValue<String>();

  int rebuilding = 0;

  @override
  void initState() {
    super.initState();
    streamedTime.value = dateTime;
    streamedText.value = text;
  }

  @override
  void dispose() {
    streamedTime.dispose();
    streamedText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rebuilding += 1;

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Callbacks'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              color: Colors.blueGrey[100],
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text('StatefulWidget and callbacka',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Text("Time: $dateTime"),
                  Text("Text: $text"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('CallbacksWidget (setState)'),
                  CallbacksWidget(
                    onChangeDate: (newdate) {
                      setState(() {
                        dateTime = newdate;
                      });
                    },
                    onChangeText: (newtext) {
                      setState(() {
                        text = newtext;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              color: Colors.blueGrey[100],
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text('StatelessWidget, streams and callbacks',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  StreamedWidget(
                    initialData: streamedTime.value,
                    stream: streamedTime.outStream,
                    builder: (context, snapshot) =>
                        Text("Time: ${snapshot.data}"),
                  ),
                  StreamedWidget(
                    initialData: streamedText.value,
                    stream: streamedText.outStream,
                    builder: (context, snapshot) =>
                        Text("Text: ${snapshot.data}"),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('CallbacksWidget (streams)'),
                  CallbacksWidget(
                    onChangeDate: (newdate) {
                      streamedTime.value = newdate;
                    },
                    onChangeText: (newtext) {
                      streamedText.value = newtext;
                    },
                  ),
                ],
              ),
            ),
            Text(
                "Widget rebuilding: $rebuilding time${rebuilding > 1 ? 's' : ''}",
                style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class CallbacksWidget extends StatelessWidget {
  final Function(String dateTime) onChangeDate;
  final Function(String text) onChangeText;

  CallbacksWidget({this.onChangeDate, this.onChangeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(height: 6.0),
          TextField(
            decoration: InputDecoration(
                labelText: 'Text',
                hintText: 'Insert some text',
                border: OutlineInputBorder()),
            onChanged: (value) {
              onChangeText(value);
            },
          ),
          Container(height: 6.0),
          RaisedButton(
              child: Text("GetTime"),
              onPressed: () {
                var dateTime = DateFormat("dd/MM/yyyy - HH:mm:ss:S")
                    .format(DateTime.now());

                onChangeDate(dateTime);
              }),
        ],
      ),
    );
  }
}
