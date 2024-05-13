import 'package:dart_website/f_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nav/nav.dart';

class App extends ConsumerStatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with Nav, WidgetsBindingObserver {
  @override
  GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        // navigatorObservers: <NavigatorObserver>[App.observer],
        debugShowCheckedModeBanner: false,
        navigatorKey: App.navigatorKey,
        home: const HomeFragment(),
      ),
    );
  }
}
