import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.account_circle_outlined,
              size: 32,
            ),
          )
        ],
      ),
      body: widget.child,
    );
  }
}
