import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

import '../models/data.dart';
import '../inheriteds/inheritedstream.dart';

class InheritedStreamPage extends StatefulWidget {
  @override
  InheritedStreamPageState createState() {
    return new InheritedStreamPageState();
  }
}

class InheritedStreamPageState extends State<InheritedStreamPage> {
  final inheritedStream = StreamedValue<Data>();
  final textController = TextEditingController();
  int rebuilding = 0;

  @override
  void initState() {
    super.initState();
    inheritedStream.value = Data(
        counter: 1,
        dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
        text: "Lorem ipsum");

    inheritedStream.debugMode();

    inheritedStream.outStream.listen((data) {
      textController.text = data.text;
    });
  }

  @override
  void dispose() {
    print('dispose');
    inheritedStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rebuilding += 1;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('InheritedStream'),
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
                    'Data propagated along the tree, widgets update by using streams:',
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Container(height: 12.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Text',
                  hintText: 'Insert some text',
                  border: OutlineInputBorder()),
              onSubmitted: (text) {
                inheritedStream.value.text = text;
                inheritedStream.refresh();
              },
            ),
            Divider(),
            InheritedStreamedDataProvider(
              data: inheritedStream,
              child: StreamedWidget(
                  stream: inheritedStream.outStream,
                  builder: (context, snapshot) {
                    return InheritedStreamedDataProviderWidget();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class InheritedStreamedDataProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedStreamedDataProvider.of(context).data;

    return Container(
      child: Column(
        children: <Widget>[
          Text('Parent',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.value.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          InheritedStreamedDataProviderWidgetChild()
        ],
      ),
    );
  }
}

class InheritedStreamedDataProviderWidgetChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedStreamedDataProvider.of(context).data;

    return Container(
      child: Column(
        children: <Widget>[
          Divider(),
          Text('Child',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.value.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          InheritedStreamedDataProviderWidgetGrandchild(),
          Divider(),
        ],
      ),
    );
  }
}

class InheritedStreamedDataProviderWidgetGrandchild extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = InheritedStreamedDataProvider.of(context).data;

    textController.text = data.value.text;

    return Container(
      margin: EdgeInsets.only(top: 12.0),
      padding: EdgeInsets.all(12.0),
      color: Colors.blueGrey[50],
      child: Column(
        children: <Widget>[
          Text('Grandchild',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          Text(
            '${data.value.text}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Container(
            height: 12.0,
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(
                labelText: 'Text',
                hintText: 'Insert some text',
                border: OutlineInputBorder()),
            onSubmitted: (text) {
              data.value.text = text;
              data.refresh();
            },
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedStreamedDataProvider.of(context).data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('${data.value.text}'),
          ],
        ),
      ),
    );
  }
}
