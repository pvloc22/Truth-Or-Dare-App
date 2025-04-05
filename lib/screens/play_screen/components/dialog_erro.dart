import 'package:flutter/material.dart';

import '../../../constant.dart';

class DialogError extends StatefulWidget{
  final String type;

  const DialogError({super.key, required this.type});
  @override
  State<StatefulWidget> createState() => _DialogError();

}
class _DialogError extends State<DialogError>{

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: kPrimaryColor.withOpacity(0.8),
          title: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),child: const Center(child: Text('ERROR!', style: TextStyle(color: kTextWhiteColor,fontWeight: FontWeight.bold),))),
          content: SizedBox(
            height: MediaQuery.of(context).size.height/8,
            width: MediaQuery.of(context).size.width*3/4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: Center(
                child: Text('Danh sách câu hỏi đang trống, bạn vui lòng tạo các câu hỏi cho danh mục ${widget.type}.', style: const TextStyle(fontWeight: FontWeight.bold, color: kTextWhiteColor),),
              )
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
              'OKE',
              style: TextStyle(color: kTextWhiteColor),
            ),
          ),
        ),
      ],
    );
  }

}