import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MJN Crew Store Status'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ViewType {android, ios}
class _MyHomePageState extends State<MyHomePage> {

  AppViewItem? androidAppViewItem;
  AppViewItem? iosAppViewItem;
  @override
  void initState() {
    super.initState();
    getAppVersions();
  }

  getAppVersions() async{
   androidAppViewItem = await fetchAppInfo(ViewType.android);
   setState(() {});
   iosAppViewItem = await fetchAppInfo(ViewType.ios);
   setState(() {});
  }
  Future<AppViewItem> fetchAppInfo(ViewType type) async {
    Response response;
    if (type == ViewType.android){
      response = await http
          .get(Uri.parse('http://localhost:6060/api/android'));
    }else {
      response = await http
          .get(Uri.parse('http://localhost:6060/api/ios'));
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var result = jsonDecode(response.body)["result"];
      if (type == ViewType.android){
        var millis =  result["updated"];
        var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
        var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM
        AppViewItem appViewItem = AppViewItem(bundleId: result["appId"], title: result["title"], url: result["url"], type: type, updated:d12);
        return appViewItem;
      }else {
        AppViewItem appViewItem = AppViewItem(bundleId: result["appId"], title: result["title"], url: result["url"], type: type, updated:  result["updated"]);
        return appViewItem;
      }
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }
  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            getAppViewWidget(androidAppViewItem),
            getAppViewWidget(iosAppViewItem)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget getAppViewWidget(AppViewItem? item){

    if (item == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(item.type == ViewType.android ? "Android": "iOS"),
          Text(item.bundleId),
          Text(item.title),
          Text(item.url),
          Text(item.updated),
        ],
      ),
    );
  }
}
class AppViewItem{
  ViewType type;
  String bundleId;
  String title;
  String url;
  String updated;
  // List<String> screenshots;
  AppViewItem({required this.type, required this.bundleId,required this.title, required this.url, required this.updated}){
  }
}