import 'package:flutter/material.dart';
// Only if you've separated HomePage into its own file.
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/root_page.dart';
import 'themes/app_theme.dart';



Future<void> main() async {
  //Uncomment this to show widget boundaries 
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alec\'s Sports App',
      theme: appThemeData,
      home: const RootPage(),
    );
  }
}
