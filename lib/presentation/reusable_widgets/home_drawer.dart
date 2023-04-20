import 'package:flutter/material.dart';
import 'package:stylebusters/core/utils/constants/styles_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';



class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
              ),
              child:
                    Image.asset('assets/images/logo.png',scale: 2,),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.houseUser,
                color: Colors.deepOrange,
              ),
              title: const Text('Home', style: StylesManager.boldTextStyle),
              trailing: const FaIcon(
                FontAwesomeIcons.arrowRight,
              ),
              onTap: () {
                context.push('/');
              },
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.palette,
                color: Colors.deepOrange,
              ),
              title: const Text('Find Artworks', style: StylesManager.boldTextStyle),
              trailing: const FaIcon(
                FontAwesomeIcons.arrowRight,
              ),
              onTap: () {
                context.push('/artworks');
              },
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.circle,
                color: Colors.deepOrange,
              ),
              title: const Text('Find Logos', style: StylesManager.boldTextStyle),
              trailing: const FaIcon(FontAwesomeIcons.arrowRight),
              onTap: () {
                context.push('/logos');
              },
            ),
           /* ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.shirt,
                color: Colors.deepOrange,
              ),
              title: const Text('Find Clothes', style: StylesManager.boldTextStyle),
              trailing: const FaIcon(FontAwesomeIcons.arrowRight),
              onTap: () {
                context.push('/clothes');
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.lightbulb,
                color: Colors.deepOrange,
              ),
              title: const Text(
                'About Us',
                style: StylesManager.boldTextStyle,
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.arrowRight,
              ),
              onTap: () {
                context.push('/aboutus');
              },
            )
*/
          ],
        ),
      );
    }
  }

