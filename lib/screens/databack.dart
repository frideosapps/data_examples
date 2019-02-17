import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/data.dart';

class DataBackPage extends StatefulWidget {
  @override
  DataBackPageState createState() {
    return new DataBackPageState();
  }
}

class DataBackPageState extends State<DataBackPage> {
  final data = Data(
      counter: 1,
      dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
      text: "Lorem ipsum");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _secondPage(BuildContext context, Widget page) async {
      final dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ) as Data;

      // Here we have the data from the second screen

      data.counter = dataFromSecondPage.counter;
      data.dateTime = dataFromSecondPage.dateTime;
      data.text = dataFromSecondPage.text;
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Send/receive - first page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: 54.0,
                padding: EdgeInsets.all(12.0),
                child: Text(
                    'Passing this data to the new page through the constructor:',
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Text('Text: ${data.text}'),
            Text('Counter: ${data.counter}'),
            Text('Date: ${data.dateTime}'),
            Container(height: 12.0),
            Divider(),
            RaisedButton(
              child: Text('Second page'),
              onPressed: () {
                _secondPage(context, SecondPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() {
    return new SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  final textController = TextEditingController();
  final data = Data(
      counter: 99,
      dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
      text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Send/receive - second page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: 54.0,
                padding: EdgeInsets.all(12.0),
                child: Text('Data passed to this page:',
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Text('Text: ${data.text}'),
            Text('Counter: ${data.counter}'),
            Text('Date: ${data.dateTime}'),
            Container(height: 12.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Text',
                  hintText: 'Insert some text',
                  border: OutlineInputBorder()),
              onChanged: (text) {
                setState(() {
                  data.text = text;
                });
              },
            ),
            Container(height: 12.0),
            RaisedButton(
              child: Text('Increment counter'),
              onPressed: () {
                setState(() {
                  data.counter += 1;
                });
              },
            ),
            Container(height: 12.0),
            RaisedButton(
              child: Text('Get datetime'),
              onPressed: () {
                setState(() {
                  data.dateTime = DateFormat("dd/MM/yyyy - HH:mm:ss:S")
                      .format(DateTime.now());
                });
              },
            ),
            Container(height: 12.0),
            Divider(),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, data); // data to the first screen
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
