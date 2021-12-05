import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.1
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Riverpod',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreem(),
    );
  }
}

class HomeScreem extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        leading: authControllerState != null
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () =>
                    ref.watch(authControllerProvider.notifier).signOut(),
              )
            : null,
      ),
    );
  }
}
