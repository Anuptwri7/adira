import 'package:flutter/material.dart';

class MoreTabPage extends StatefulWidget {
  const MoreTabPage({Key key}) : super(key: key);

  @override
  State<MoreTabPage> createState() => _MoreTabPageState();
}

class _MoreTabPageState extends State<MoreTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(child: Text("Page"),));
  }
}
