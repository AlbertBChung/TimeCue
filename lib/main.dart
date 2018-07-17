import 'package:flutter/material.dart';
import 'components/particleController/waterController.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Time Cue App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(title: 'Time cue App'),
      showPerformanceOverlay: true,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    print(mediaQueryData);


    return new Scaffold(
      body: new Center(
        child: WaterController()
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
