import 'package:flutter/material.dart';
import 'package:stylebusters/core/utils/constants/styles_manager.dart';

import '../reusable_widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home',style: StylesManager.boldTextStyle),
      centerTitle: true,),
      body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/logo.png',scale: 2,),
          Text('We will catch every style',
            style: StylesManager.boldTextStyle2,)
        ],),
      ),
    ),
      drawer: const HomeDrawer(),
    );
  }
}
