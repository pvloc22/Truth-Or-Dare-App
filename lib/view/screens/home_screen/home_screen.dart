
import 'package:flutter/material.dart';

import 'package:truth_or_dare/view/screens/home_screen/home_form.dart';
import 'package:truth_or_dare/view_models/home_view_model.dart';
import 'package:truth_or_dare/repository/home_repository.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
@override
  Widget build(BuildContext context) {
    return const HomeForm();
  }
}
