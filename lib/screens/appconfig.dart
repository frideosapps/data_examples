import 'package:flutter/material.dart';

import '../models/appconfig.dart';
import '../inheriteds/inherited_provider.dart';

class AppConfigPage extends StatefulWidget {
  @override
  AppConfigPageState createState() {
    return new AppConfigPageState();
  }
}

class AppConfigPageState extends State<AppConfigPage> {
  final textController = TextEditingController();
  String text = 'Lorem ipsum';

  @override
  Widget build(BuildContext context) {
    final appConfig = InheritedProvider.of<AppConfig>(context);

    textController.text = text;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('AppConfig'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: 54.0,
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                color: appConfig.backgroundAppConfigPageOne,
                child: Text('Styles from the AppConfig inherited object',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: appConfig.textColorAppConfigPageOne))),
            Container(height: 24.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Text',
                  hintText: 'Insert some text',
                  border: OutlineInputBorder()),
              onChanged: (newText) {
                text = newText;
              },
            ),
            Container(height: 12.0),
            RaisedButton(
              child: Text('Send to the new page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(
                            text: text,
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
  final String text;

  SecondPage({this.text});

  @override
  Widget build(BuildContext context) {
   final appConfig = InheritedProvider.of<AppConfig>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: 54.0,
                color: appConfig.backgroundAppConfigPageTwo,
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: appConfig.textColorAppConfigPageTwo))),
          ],
        ),
      ),
    );
  }
}
