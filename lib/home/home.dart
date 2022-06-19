import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubitHome/cupit_home.dart';
import 'cubitHome/homeStates.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupitHome obj = BlocProvider.of(context);
    return BlocConsumer<CupitHome, ShopeHomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: obj.body[obj.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
            currentIndex: obj.currentindex,
            onTap: (value) {
              obj.changenav(value);
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
