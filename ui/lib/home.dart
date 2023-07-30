import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'favorites.dart';
import 'auth.dart';
import 'wordpairs.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var selectedIndex = 0;
  var appBarTitle = 'Quizrd';
  var appBarSeperator = ' | ';
  var appBarTitleExtended = 'AI Powered Infinite Trivia';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = WordPairPage();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      case 4:
        page = FavoritesPage();
        break;
      case 5:
        page = AuthPage();
        break;
      case 6:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    var appBarTextStyle = theme.textTheme.titleLarge!.copyWith(
      color: colorScheme.onPrimary,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => ProfileScreen(
                      actions: [
                        SignedOutAction((context) {
                          Navigator.of(context).pop();
                        })
                      ],
                    ),
                  ),
                ); // do something
              },
            )
          ],
          backgroundColor: Color(0xfff68d2d),
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/quizrd_logo.png',
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    appBarTitle,
                    style: appBarTextStyle,
                  ),
                  Text(
                    appBarSeperator,
                    style: appBarTextStyle,
                  ),
                  Text(
                    appBarTitleExtended,
                    style: appBarTextStyle,
                  ),
                ],
              ),
            ],
          )),
      drawer: Drawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            Future.delayed(Duration.zero, () {
              setState(() {
                appBarSeperator = '';
                appBarTitleExtended = '';
              });
            });
          } else {
            Future.delayed(Duration.zero, () {
              setState(() {
                appBarSeperator = ' | ';
                appBarTitleExtended = 'AI Powered Infinite Trivia';
              });
            });
          }

          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.sports_esports),
                        label: 'Play',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.grid_view),
                        label: 'Browse',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.quiz),
                        label: 'Create',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.login),
                        label: 'Login',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    minWidth: 70,
                    minExtendedWidth: 150,
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.sports_esports),
                        label: Text('Play'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.grid_view),
                        label: Text('Browse'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.quiz),
                        label: Text('Create'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.login),
                        label: Text('Login'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: mainArea,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
