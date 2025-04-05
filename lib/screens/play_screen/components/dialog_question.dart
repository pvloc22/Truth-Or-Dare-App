import 'package:flutter/material.dart';

import '../../../constant.dart';

class DialogQuestion extends StatefulWidget{
  final String question;
  final String type;

  const DialogQuestion({super.key, required this.question, required this.type});
  @override
  State<StatefulWidget> createState() => _DialogQuestion();

}
class _DialogQuestion extends State<DialogQuestion>{

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: kPrimaryColor.withOpacity(0.8),
          title: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),child: Center(child: Text(widget.type, style: const TextStyle(color: kTextWhiteColor,fontWeight: FontWeight.bold),))),
          content: SizedBox(
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*3/4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: SingleChildScrollView(
                child: Text(widget.question, style: const TextStyle(fontWeight: FontWeight.bold, color: kTextWhiteColor),),
              ),
            ),

          ),
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width*3/4,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonColor,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'TIẾP TỤC',
              style: TextStyle(color: kTextWhiteColor),
            ),
          ),
        ),
      ],
    );
  }

}