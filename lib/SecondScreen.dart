import 'package:flutter/material.dart';
import 'package:flutter_project/GridScreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, position) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Element ${position + 1}"),
            subtitle: Text("Subtitle $position"),
            onTap: ()  async {
              final int selected = await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return GridScreen(position);
              }));

            },
          );
        },
        itemCount: 20,
        reverse: false,
      ),
    );
  }
}
