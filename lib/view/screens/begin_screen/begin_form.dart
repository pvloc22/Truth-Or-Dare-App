import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../home_screen/home_screen.dart';

class BeginForm extends StatefulWidget {
  const BeginForm({super.key});

  @override
  State<BeginForm> createState() => _BeginFormState();
}

class _BeginFormState extends State<BeginForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _introductionApp(),
              _startButton(),
            ],
          )),
    );
  }

  Widget _introductionApp(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 220,
          height: 220,
        ),
        const Text(
          "Thật hay thách",
          style: TextStyle(
              color: Colors.red,
              fontFamily: defaultFontFamily,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        const Text(
          "Hãy tận hưởng những giây phút thú vị",
          style: TextStyle(
              color: kTextDescription, fontFamily: defaultFontFamily),
        )
      ],
    );
  }

  Widget _startButton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: MediaQuery.sizeOf(context).height * 0.07,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          child: const Text(
            "BẮT ĐẦU",
            style: TextStyle(
                color: kTextWhiteColor, fontFamily: defaultFontFamily),
          )),
    );
  }
}
