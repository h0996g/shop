import 'package:flutter/material.dart';

class Faverites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Favorites',
        style: Theme.of(context).textTheme.headline4,
      )),
    );
  }
}
