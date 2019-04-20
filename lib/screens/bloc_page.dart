import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../singletons/bloc.dart';

class SingletonBlocPage extends StatefulWidget {
  @override
  SingletonBlocPageState createState() {
    return new SingletonBlocPageState();
  }
}

class SingletonBlocPageState extends State<SingletonBlocPage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = bloc.text.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('SingletonBloc PageOne'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            StreamedWidget(
                stream: bloc.text.outStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Text',
                        hintText: 'Insert some text',
                        border: OutlineInputBorder()),
                    onChanged: bloc.text.inStream,
                  );
                }),
            Divider(),
            RaisedButton(
              child: Text('PageTwo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
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

  @override
  void initState() {
    super.initState();
    textController.text = bloc.text.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageTwo'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            StreamedWidget(
                initialData: bloc.text.value,
                stream: bloc.text.outStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Text',
                        hintText: 'Insert some text',
                        border: OutlineInputBorder()),
                    onChanged: (text) {
                      bloc.text.inStream(text);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
