import 'package:flutter/material.dart';
import 'package:flowers/ui/flower_list.dart';

void main() => runApp(FlowerBoxApp());

class FlowerBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlue[700],
        brightness: Brightness.light,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 26.0,
              ),
              title: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 22.0,
              ),
              subtitle: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
                letterSpacing: 1,
              ),
            ),
      ),
      home: FlowerList(),
    );
  }
}
