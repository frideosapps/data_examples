import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'inheriteds/inherited_provider.dart';
import 'models/appconfig.dart';
import 'screens/appconfig.dart';
import 'screens/appdata.dart';
import 'screens/callbacks.dart';
import 'screens/databack.dart';
import 'screens/inherited.dart';
import 'screens/inherited_generic.dart';
import 'screens/inheritedstream.dart';
import 'screens/constructor.dart';
import 'screens/bloc_page.dart';
import 'singletons/bloc.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appConfig = AppConfig();

  @override
  Widget build(BuildContext context) {
    bloc.dateTime.value =
        DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now());

    return InheritedProvider<AppConfig>(
      inheritedData: appConfig,
      child: MaterialApp(
          title: 'Data examples',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home()),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButton(String title, Widget page) {
      return Container(
        height: 36.0,
        margin: EdgeInsets.only(
          bottom: 4.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(title),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Data examples'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[50],
        child: Column(
          children: <Widget>[
            _buildButton('Simple sending data', ConstructorPage()),
            _buildButton('Send and receive', DataBackPage()),
            _buildButton('InheritedWidget', InheritedPage()),
            _buildButton('InheritedWidget generic', InheritedGenericPage()),
            _buildButton('InheritedWidget and streams', InheritedStreamPage()),
            _buildButton('Inherited AppConfig', AppConfigPage()),
            _buildButton('Singleton', AppDataPage()),
            _buildButton('Singleton BLoC', SingletonBlocPage()),
            _buildButton('Callbacks', CallbacksPage()),                        
          ],
        ),
      ),
    );
  }
}
