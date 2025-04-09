import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../../../../models/Topic_model.dart';

class DialogMakeQuestion extends StatefulWidget {

  const DialogMakeQuestion(
      {super.key});
  @override
  State<StatefulWidget> createState() => _DialogMakeQuestionState();
}

class _DialogMakeQuestionState extends State<DialogMakeQuestion> {
  bool isChecked_1 = true;
  bool isChecked_2 = false;
  final TextEditingController _question = TextEditingController();

  void toggleCheckbox_1(bool? value) {
    setState(() {
      isChecked_1 = isChecked_1 ? false : true;
      isChecked_2 = isChecked_1 ? false : true;
    });
  }

  void toggleCheckbox_2(bool? value) {
    setState(() {
      isChecked_2 = isChecked_2 ? false : true;
      isChecked_1 = isChecked_2 ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width * 3 / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Chọn loại câu hỏi',
              style: TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked_1,
                      onChanged: toggleCheckbox_1,
                      shape: const CircleBorder(),
                    ),
                    const Text(
                      'Truth',
                      style: TextStyle(
                          color: kTextWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked_2,
                      onChanged: toggleCheckbox_2,
                      shape: const CircleBorder(),
                    ),
                    const Text(
                      'Dare',
                      style: TextStyle(
                          color: kTextWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Nhập câu hỏi',
              style: TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding / 2, right: kDefaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: kColorHidden.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                controller: _question,
                scrollPadding: const EdgeInsets.all(kDefaultPadding / 2),
                enabled: true,
                cursorColor: kButtonColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButtonColor,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Thêm câu hỏi',
                  style: TextStyle(color: kTextWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
