import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';

import 'package:provider/provider.dart';
import 'package:sky_wallpeper/screen/provider/wallpepar_provider.dart';
import 'package:sky_wallpeper/screen/view/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WallpaperProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class NavigationBar extends StatelessWidget {
  NavigationBar({Key? key}) : super(key: key);

  static const Color mediumPurple =
      Color(0xFF6A1B9A); // Define medium purple color
  static const Color customYellow =
      Color(0xFFFFEB3B); // Define custom yellow color

  final List<NavbarItem> items = [
    NavbarItem(
      Icons.home_outlined,
      'Home',
      backgroundColor: mediumPurple,
      selectedIcon: Icon(
        Icons.home,
        size: 26,
      ),
    ),
    NavbarItem(
      Icons.shopping_bag_outlined,
      'Updates',
      backgroundColor: customYellow,
      selectedIcon: Icon(
        Icons.shopping_bag,
        size: 26,
      ),
    ),
    NavbarItem(
      Icons.person_outline,
      'Communities',
      backgroundColor: Colors.teal,
      selectedIcon: Icon(
        Icons.person,
        size: 26,
      ),
    ),
    NavbarItem(
      Icons.call_outlined,
      'Calls',
      backgroundColor: Colors.teal,
      selectedIcon: Icon(
        Icons.call,
        size: 26,
      ),
    ),
  ];

  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': HomePage(),
      // Add more routes if needed
    },
    1: {
      '/': HomePage(),
      // Add more routes if needed
    },
    2: {
      '/': HomePage(),
      // Add more routes if needed
    },
    3: {
      '/': HomePage(),
      // Add more routes if needed
    },
  };

  @override
  Widget build(BuildContext context) {
    return NavbarRouter(
      type: NavbarType.floating,
      errorBuilder: (context) {
        return const Center(child: Text('Error 404'));
      },
      onBackButtonPressed: (isExiting) {
        return isExiting;
      },
      destinationAnimationCurve: Curves.fastOutSlowIn,
      destinationAnimationDuration: 600,
      decoration: NavbarDecoration(
          navbarType: BottomNavigationBarType.fixed,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      destinations: [
        for (int i = 0; i < items.length; i++)
          DestinationRouter(
            navbarItem: items[i],
            destinations: [
              for (int j = 0; j < _routes[i]!.keys.length; j++)
                Destination(
                  route: _routes[i]!.keys.elementAt(j),
                  widget: _routes[i]!.values.elementAt(j),
                ),
            ],
            initialRoute: _routes[i]!.keys.first,
          ),
      ],
    );
  }
}
