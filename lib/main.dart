import 'package:flutter/material.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/screens/begin_screen/begin_screen.dart';
import 'package:truth_or_dare/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Truth or Dare',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        // textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/start',
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/start':
            return MaterialPageRoute(builder: (context) => const BeginScreen());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          default:
            return null;
        }
      },
    );
  }
}
