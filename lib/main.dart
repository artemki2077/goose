import 'package:flutter/material.dart';
import 'package:goose/ui/pages/main_pages/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/global.dart' as global;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("db");
  await global.setup();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
