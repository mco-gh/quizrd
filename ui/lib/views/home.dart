// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizaic/models/state.dart';
import 'package:quizaic/views/browse.dart';
import 'package:quizaic/views/host.dart';
import 'package:quizaic/views/create.dart';
import 'package:quizaic/views/play.dart';
import 'package:quizaic/views/settings.dart';
import 'package:quizaic/auth/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:quizaic/const.dart';
import 'package:quizaic/views/helpers.dart';
import 'package:quizaic/views/quiz.dart';
import 'package:quizaic/views/welcome.dart';
import 'package:quizaic/views/about.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

errorDialog(error) {
  print('errorDialog: $error');
  var context = _rootNavigatorKey.currentContext!;
  Widget okButton = TextButton(
    onPressed: GoRouter.of(context).pop,
    child: Text("OK"),
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(error),
    actions: [
      okButton,
    ],
  );
  showDialog(context: context, builder: (BuildContext context) => alert);
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();

  final _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      //initialLocation: '/browse',
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return MaterialPage(
                child: HeroControllerScope(
                    controller: MaterialApp.createMaterialHeroController(),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return HomePageScaffold(
                          child: child,
                        );
                      },
                    )));
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              pageBuilder: (context, state) =>
                  genCustomTransitionPage(state, WelcomePage()),
            ),
            GoRoute(
              path: '/about',
              pageBuilder: (context, state) =>
                  genCustomTransitionPage(state, AboutPage()),
            ),
            GoRoute(
              path: '/browse',
              pageBuilder: (context, state) =>
                  genCustomTransitionPage(state, BrowsePage()),
            ),
            GoRoute(
              path: '/edit/:quizId',
              pageBuilder: (context, state) => genCustomTransitionPage(
                  state, CreatePage(quizId: state.pathParameters['quizId'])),
            ),
            GoRoute(
              path: '/clone',
              pageBuilder: (context, state) =>
                  genCustomTransitionPage(state, CreatePage()),
            ),
            GoRoute(
              path: '/host/:quizId',
              pageBuilder: (context, state) => genCustomTransitionPage(
                  state, HostPage(quizId: state.pathParameters['quizId'])),
            ),
            GoRoute(
                path: '/create',
                pageBuilder: (context, state) =>
                    genCustomTransitionPage(state, CreatePage())),
            GoRoute(
                path: '/view/:quizId',
                pageBuilder: (context, state) => genCustomTransitionPage(
                    state,
                    CreatePage(
                        quizId: state.pathParameters['quizId'],
                        readOnly: true))),
            GoRoute(
                path: '/play',
                pageBuilder: (context, state) =>
                    genCustomTransitionPage(state, PlayPage())),
            GoRoute(
                path: '/play/:pin',
                pageBuilder: (context, state) => genCustomTransitionPage(
                    state, PlayPage(pin: state.pathParameters['pin']))),
            GoRoute(
                path: '/quiz',
                pageBuilder: (context, state) =>
                    genCustomTransitionPage(state, QuizPage())),
            GoRoute(
                path: '/settings',
                pageBuilder: (context, state) =>
                    genCustomTransitionPage(state, SettingsPage())),
            GoRoute(
                path: '/login',
                pageBuilder: (context, state) =>
                    genCustomTransitionPage(state, AuthPage())),
          ],
        )
      ]);

  set initialLocation(location) => initialLocation = location;
  GoRouter get router => _router;
}

CustomTransitionPage genCustomTransitionPage(state, page) {
  return CustomTransitionPage(
      transitionDuration: Duration(milliseconds: 700),
      reverseTransitionDuration: Duration(milliseconds: 700),
      key: state.pageKey,
      child: page,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      });
}

class _MyHomePageState extends State<HomePage> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    FirebaseAuth.instance.authStateChanges().listen((event) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.getIdTokenResult().then((result) {
          appState.userData.idToken = result.token as String;
        });
      }
    });

    return MaterialApp.router(
      theme: theme,
      routerConfig: _router,
    );
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class HomePageScaffold extends StatelessWidget {
  /// Constructs an [HomePageScaffold].
  HomePageScaffold({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

// The container for the current page, with its background color

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var appBarTextStyle = theme.textTheme.titleLarge!.copyWith(
      color: colorScheme.onPrimary,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    );

    dynamic icon = Icon(Icons.person, color: Colors.white);
    if (appState.userData.photoUrl != '') {
      icon = Image.network(appState.userData.photoUrl, height: 40, headers: {});
    }

    String title = appBarTitle;
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      title = appBarTitleExtended;
    }

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              user.getIdTokenResult().then((result) {
                print('home page setting idToken');
                appState.userData.idToken = result.token as String;
                if (user.photoURL != null) {
                  print('home page setting photoUrl');
                  appState.userData.photoUrl = user.photoURL as String;
                }
                if (user.displayName != null) {
                  print('home page setting displayName');
                  appState.userData.name = user.displayName as String;
                }
                if (user.email != null) {
                  print('home page setting email and hashedEmail');
                  appState.userData.email = user.email as String;
                  var data = utf8.encode('${user.email}'); // data being hashed
                  var hashedEmail = sha256.convert(data).toString();
                  appState.userData.hashedEmail = hashedEmail;
                }
              });
            }
            if ((user != null) && (user.photoURL != null)) {
              appState.userData.photoUrl = user.photoURL as String;
            }
          }
          var lg = LinearGradient(
            colors: <Color>[
              Color(0xff4F87ED),
              Color(0xff9476C5),
              Color(0xffBC688E),
              Color(0xffD6645D),
            ],
            tileMode: TileMode.mirror,
          );
          return Scaffold(
              resizeToAvoidBottomInset: false,
              //body: child,
              appBar: AppBar(
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: lg,
                  )),
                  actions: <Widget>[
                    IconButton(
                      icon: icon,
                      onPressed: () {
                        GoRouter.of(context).go('/login');
                      },
                    ),
                    SizedBox(width: horizontalSpaceWidth),
                    /*
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        GoRouter.of(context).go('/settings');
                      },
                    )
                    */
                  ],
                  backgroundColor: theme.primaryColor,
                  centerTitle: false,
                  title: InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/quizaic.png',
                          height: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              title,
                              style: appBarTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              //drawer: Drawer(),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 450) {
                    // Use a more mobile-friendly layout with BottomNavigationBar
                    // on narrow screens.
                    return Column(
                      children: [
                        Expanded(
                            child: ColoredBox(
                          color: colorScheme.surfaceVariant,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            child: child,
                          ),
                        )),
                        SafeArea(
                          child: BottomNavigationBar(
                            selectedItemColor: Colors.black,
                            unselectedItemColor: Colors.blue,
                            currentIndex: _calculateSelectedIndex(context),
                            onTap: (int idx) => _onItemSelected(idx, context),
                            items: [
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.grid_view),
                                label: 'Browse',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.add_circle),
                                label: 'Create',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.sports_esports),
                                label: 'Play',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.description),
                                label: 'About',
                              ),
                            ],
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
                                label: genText(theme, 'Home'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.grid_view),
                                label: genText(theme, 'Browse'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.add_circle),
                                label: genText(theme, 'Create'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.sports_esports),
                                label: genText(theme, 'Play'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.description),
                                label: genText(theme, 'About'),
                              ),
                            ],
                            //selectedIndex: appState.selectedIndex,
                            selectedIndex: _calculateSelectedIndex(context),
                            onDestinationSelected: (int idx) =>
                                _onItemSelected(idx, context),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: ColoredBox(
                            color: colorScheme.surfaceVariant,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              child: child,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ));
        });
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/browse')) {
      return 1;
    }
    if (location.startsWith('/create')) {
      return 2;
    }
    if (location.startsWith('/play')) {
      return 3;
    }
    if (location.startsWith('/about')) {
      return 4;
    }
    return 0;
  }

  void _onItemSelected(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/browse');
        break;
      case 2:
        GoRouter.of(context).go('/create');
        break;
      case 3:
        GoRouter.of(context).go('/play');
        break;
      case 4:
        GoRouter.of(context).go('/about');
        break;
    }
  }
}
