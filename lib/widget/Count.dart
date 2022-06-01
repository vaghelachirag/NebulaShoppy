import 'package:flutter/material.dart';

class Count extends StatelessWidget {
  final int count;
  final VoidCallback onCountSelected;
  final Function(int) onCountChanged;

  Count({
    required this.count,
    required this.onCountChanged,
    required this.onCountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onCountChanged(1);
          },
        ),
        FlatButton(
          child: Text("$count"),
          onPressed: () => onCountSelected(),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            onCountChanged(-1);
          },
        ),
      ],
    );
  }
}