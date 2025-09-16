import 'package:flutter/material.dart';

class FollowUp  extends StatelessWidget {
  const FollowUp ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: GestureDetector(onTap: () {
      Navigator.pop(context);
    },child: Icon(Icons.arrow_back)),),  body:Center(child: Text("follow up page"),));
  }
}