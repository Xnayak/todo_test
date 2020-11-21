import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
  ));
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Something Went Wrong",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
