import 'package:flutter/material.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/repository/home_repository.dart';
import 'package:truth_or_dare/view/screens/begin_screen/begin_screen.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/view_models/home_view_model.dart';
import 'package:truth_or_dare/view_models/question_view_model.dart';
import 'package:truth_or_dare/repository/question_repository.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeViewModel(homeRepository: HomeRepository())..fetchData()),
    ],
    child: const MainApp(),
  ));
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
      ),
      home: const BeginScreen(),
    );
  }
}
