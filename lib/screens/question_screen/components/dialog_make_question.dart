import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/question_models.dart';

class DialogMakeQuestion extends StatefulWidget {
  final Data data;
  final Future<void> Function(
          String question, bool checkbox_1, bool checkbox_2, Data data)
      insertQuestion;

  const DialogMakeQuestion(
      {super.key, required this.data, required this.insertQuestion});
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
            SizedBox(
              height: 5,
            ),
            Text(
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
                      shape: CircleBorder(),
                    ),
                    Text(
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
                      shape: CircleBorder(),
                    ),
                    Text(
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Nhập câu hỏi',
              style: TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                scrollPadding: EdgeInsets.all(kDefaultPadding / 2),
                enabled: true,
                cursorColor: kButtonColor,
              ),
            ),
            SizedBox(
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
                  widget.insertQuestion(
                      _question.text, isChecked_1, isChecked_2, widget.data);
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
