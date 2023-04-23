import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants/home_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/clothes_screen.dart';
import '../../presentation/screens/logos_screen.dart';
import '../../presentation/screens/artworks_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  int currentPageIndex = 0;
  PageController pageController = PageController(initialPage:0);
  final List<Widget> mainPages = [
    HomeScreen(),
    ClothesScreen(),
    LogosScreen(),
    ArtworksScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child:PageView(
            controller:pageController,
            children: mainPages,
            onPageChanged: (int index)=> setState((){currentPageIndex = index;}),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon:Icon(Icons.home)
              ,label: HomeManager.bottomNavigationBarItemLabel1),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.shirt)
              ,label: HomeManager.bottomNavigationBarItemLabel2  ),
          BottomNavigationBarItem(
              icon:FaIcon(FontAwesomeIcons.circle)
              ,label: HomeManager.bottomNavigationBarItemLabel3 ),
          BottomNavigationBarItem(
              icon:FaIcon(FontAwesomeIcons.palette)
              ,label: HomeManager.bottomNavigationBarItemLabel4 )
        ],
        currentIndex: currentPageIndex,
        onTap: (int pageIndex){

          print(pageIndex);
          pageController.animateToPage(pageIndex,
              duration: Duration(milliseconds: ValuesManager.swipePageAnimationDuration),
              curve: Curves.easeInCirc);
        },
        unselectedItemColor: ColorsManager.bottomBarUnselectedIconsColor ,
        selectedItemColor: ColorsManager.bottomBarSelectedIconsColor,


      ),

    );
  }
  @override
  void dispose(){


   // pageController.dispose();
    super.dispose();
  }

}
