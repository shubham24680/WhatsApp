import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:whatsapp/profile_info.dart';
import 'Components/firebase_options.dart';

import 'Screens/Home/home.dart';
import 'Theme/light_theme.dart';
// import 'Theme/dark_theme.dart';
import 'Components/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatsApp",
      theme: lightTheme(),
      // darkTheme: darkTheme(),
      // themeMode: ThemeMode.system,
      onGenerateRoute: (settings) {
        return route(settings);
      },
      home: const Home(),
    );
  }
}
