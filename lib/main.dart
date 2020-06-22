import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class homeIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:RaisedButton(
          child:Text("navegação") 
          ,onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => HomePage()));
              })
        ),
    );
  }
}
