import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../inheriteds/inherited_provider.dart';

import '../models/data.dart';

class InheritedGenericPage extends StatefulWidget {
  @override
  InheritedPageState createState() {
    return new InheritedPageState();
  }
}

class InheritedPageState extends State<InheritedGenericPage> {
  final data = Data(
      counter: 1,
      dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
      text: "Lorem ipsum");

  int rebuilding = 0;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    rebuilding += 1;

    textController.text = data.text;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Inherited'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('No. rebuilds: $rebuilding',
                style: TextStyle(fontWeight: FontWeight.w700)),
            Container(
                height: 44.0,
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Data from the parent widget propagates along the tree:',
                    style: TextStyle(fontWeight: FontWeight.w700))),
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
            Divider(),
            InheritedProvider<Data>(
              child: InheritedDataWidget(),
              inheritedData: data,
            ),
            Divider(),
            Container(height: 12.0),
            RaisedButton(
              child: Text('Second page'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InheritedProvider(
                              child: SecondPage(),
                              inheritedData: data,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InheritedDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<Data>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Text('Parent',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          InheritedDataWidgetChild()
        ],
      ),
    );
  }
}

class InheritedDataWidgetChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<Data>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Divider(),
          Text('Child',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          InheritedDataWidgetGrandchild()
        ],
      ),
    );
  }
}

class InheritedDataWidgetGrandchild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<Data>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Divider(),
          Text('Grandchild',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<Data>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('${data.text}'),
          ],
        ),
      ),
    );
  }
}
