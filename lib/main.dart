import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/layouts/home_layout.dart';
import 'package:todo/styles/theme.dart';
import 'providers/bot_nav_bar_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BotNavBarProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: HomeLayout.routeName,
        routes: {HomeLayout.routeName: (context) => HomeLayout()},
        debugShowCheckedModeBanner: false,
        theme: ToDOThemeData.lightTheme,
        darkTheme: ToDOThemeData.DarkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
