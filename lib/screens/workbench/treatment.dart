import 'package:flutter/material.dart';

class Treatment  extends StatelessWidget {
  const Treatment ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: GestureDetector(onTap: () {
      Navigator.pop(context);
    },child: Icon(Icons.arrow_back)),),  body:Center(child: Text("treatment page"),));
  }
}