import 'package:flutter/material.dart';

class XLog extends StatelessWidget {
  List<String> logs;

  XLog(this.logs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100],
      padding: const EdgeInsets.fromLTRB(25, 35, 25, 20),
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: logs.length,
        itemBuilder: (ctx, index) {
          return Text(logs[index]);
        },
      ),
    );
  }
}
