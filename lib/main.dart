

import 'package:daily_recipe/pages/splash_screen/splash_screen.dart';
import 'package:daily_recipe/provider/Ingredients.provider.dart';
import 'package:daily_recipe/provider/recipe.provider.dart';
import 'package:daily_recipe/provider/test.provider.dart';
import 'package:provider/provider.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:daily_recipe/provider/app_auth.provider.dart';
import 'package:daily_recipe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_kit/overlay_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();

    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  } catch (e) {
    print(
        '=========================Error In init Prefrences ${e}========================');
  }
  // runApp(const MyApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> AppAuthProvider()),
    ChangeNotifierProvider(create: (context)=> AdsProvider()),
    ChangeNotifierProvider(create: (context)=> IngredientsProvider()),
    ChangeNotifierProvider(create: (context)=> RecipeProvider()),
    ChangeNotifierProvider(create: (context)=> TestProvider()),

  ], child:const MyApp( )));
  // runApp(ChangeNotifierProvider(create: (context)=> AdsProvider(), child:const MyApp()));
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: FirebaseOptions(
//         options: DefaultFirebaseOptions.currentPlatform,
//       ),
//
//   );

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlayKit(child: MaterialApp(
      title: 'Daily Recipe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Daily Recipe'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashScreen());
  }
}

