import 'package:flutter/material.dart';

import '../../core/utils/constants/styles_manager.dart';
import '../reusable_widgets/home_drawer.dart';

class AboutUsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us', style: StylesManager.boldTextStyle),
        centerTitle: true,),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('About Us',
                style: StylesManager.boldTextStyle2,)
            ],),
        ),
      ),
      drawer: const HomeDrawer(),);
  }

}