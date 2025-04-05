import 'package:flutter/material.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/screens/home_screen/home_screen.dart';

class BeginScreen extends StatefulWidget {
  const BeginScreen({super.key});

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logo.png',
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
          ),
          SizedBox(
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
          ),
        ],
      )),
    );
  }
}
