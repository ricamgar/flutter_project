import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  final int position;

  GridScreen(this.position);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail of item ${widget.position}"),),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (c, position) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, position);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: Center(child: Text("Item $position")),
              ),
            ),
          );
        },
      ),
    );
  }
}
