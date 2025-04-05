import 'package:flutter/material.dart';
import 'dart:math';

import '../../constant.dart';
import '../../models/question_models.dart';
import 'components/dialog_erro.dart';
import 'components/dialog_question.dart';

class PlayingScreen extends StatelessWidget{
  final Data? data;
  final String ?topic;

  const PlayingScreen({super.key, required this.data, required this.topic});


  String? randomList(Data listData, String type){
    Random random = Random();

    if(type == 'Truth'){
      do{
        int randomNumber = random.nextInt(data!.truth!.length);
        if(listData.truth?[randomNumber].state??false) {
          return listData.truth![randomNumber].name;
        }
      }
      while(true);
    }
    else{
      do{
        int randomNumber = random.nextInt(data!.dare!.length);
        if(listData.dare?[randomNumber].state??false) {
          return listData.dare![randomNumber].name;
        }
      }
      while(true);
    }
  }
  showQuestionDialog_truth(BuildContext context) => showDialog(
      context: context,
      builder: (context) => DialogQuestion(question: randomList(data!, 'Truth')!, type: 'Truth',));

  showQuestionDialog_dare(BuildContext context) => showDialog(
      context: context,
      builder: (context) => DialogQuestion(question: randomList(data!, 'Dare')!,type: 'Dare',));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kButtonColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Danh sách câu hỏi",
                  style: TextStyle(
                      color: kTextLightColor,
                      fontFamily: defaultFontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
          ),

          /*Body of playing screen*/

          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding*2),
            child: Container(
              height: MediaQuery.of(context).size.height/20,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text('${topic}', style: TextStyle(color: kTextWhiteColor,fontWeight: FontWeight.bold, fontSize: 20),overflow: TextOverflow.ellipsis,)),
            ),
          ),

          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: (){
                        if(data!.truth!.length!=0){
                          showQuestionDialog_truth(context);
                        }
                        else{
                          showDialog(
                              context: context,
                              builder: (context) => const DialogError(type: 'Truth',));
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Truth ',
                            style: TextStyle(color: kTextWhiteColor),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: (){
                        if(data!.dare!.length !=0) {
                          showQuestionDialog_dare(context);
                        }
                        else{
                          showDialog(
                              context: context,
                              builder: (context) => DialogError(type: 'Dare',));
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Dare',
                            style: TextStyle(color: kTextWhiteColor),
                          ),
                        ),
                      )
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}