import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/data.dart';

class ConstructorPage extends StatefulWidget {
  @override
  ConstructorPageState createState() {
    return new ConstructorPageState();
  }
}

class ConstructorPageState extends State<ConstructorPage> {
  final data = Data(
      counter: 1,
      dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
      text: "Lorem ipsum");

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = data.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Constructor - first page'),
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
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Text',
                  hintText: 'Insert some text',
                  border: OutlineInputBorder()),
              onSubmitted: (text) {
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
              child: Text('Send data to the second page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(
                            data: data,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final Data data;

  SecondPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Constructor - second page'),
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
          ],
        ),
      ),
    );
  }
}