import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class AppRouter {
  GoRouter get router => _goRouter;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _goRouter =
      GoRouter(initialLocation: '/1', navigatorKey: _rootNavigatorKey, routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, child) => SampleGuard(child: child),
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/1',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/2',
            builder: (context, state) => SettingsScreen(),
          )
        ])
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter().router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pushReplacement("/2"),
          child: Text("navigate"),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("2"),
      ),
    );
  }
}

class SampleGuard extends StatelessWidget {
  final Widget? child;

  const SampleGuard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}
