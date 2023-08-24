import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/Screens/Home/home.dart';
import 'Components/firebase_options.dart';

import 'Components/storage.dart';
import 'Theme/light_theme.dart';
// import 'Theme/dark_theme.dart';
import 'Components/route.dart';

// import 'Screens/Home/home.dart';
import 'Screens/welcome.dart';
import '/Screens/profile_info.dart';

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<QuerySnapshot>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) return const Home();
                return const ProfileInfo();
              },
            );
          }
          return const Welcome();
        },
      ),
    );
  }
}
