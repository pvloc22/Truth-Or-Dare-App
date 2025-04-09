import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/models/dare_model.dart';
import 'package:truth_or_dare/models/truth_model.dart';

import '../../../constant.dart';
import '../../../view_models/playing_view_model.dart';
import 'components/dialog_erro.dart';
import 'components/dialog_question.dart';

class PlayingForm extends StatelessWidget {
  const PlayingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackgroundColor,
              boxShadow: [BoxShadow(color: kColorHidden.withOpacity(0.2), offset: const Offset(0, 4), blurRadius: 4)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: kButtonColor),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ),

          /*Body of playing screen*/
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: Container(
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(color: kButtonColor, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  '--topic',
                  style: TextStyle(color: kTextWhiteColor, fontWeight: FontWeight.bold, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          Expanded(
            child: Consumer<PlayingViewModel>(
              builder: (context, playingViewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: () {
                        List<Truth> listTruth = playingViewModel.listTruth;
                        List<Dare> listDare = playingViewModel.listDare;
                        final String? question = playingViewModel.randomList(listTruth, listDare, TRUTH_STRING);
                        if ((question ?? '').isEmpty) {
                          showDialog(context: context, builder: (context) => const DialogError(type: TRUTH_STRING));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => DialogQuestion(question: question ?? 'error!!', type: TRUTH_STRING),
                          );
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 200,
                        child: Center(child: Text('Truth ', style: TextStyle(color: kTextWhiteColor))),
                      ),
                    ),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: () {
                        List<Truth> listTruth = playingViewModel.listTruth;
                        List<Dare> listDare = playingViewModel.listDare;
                        String? question = playingViewModel.randomList(listTruth, listDare, DARE_STRING);
                        if ((question ?? '').isEmpty) {
                          showDialog(context: context, builder: (context) => const DialogError(type: DARE_STRING));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => DialogQuestion(question: question ?? 'error!!', type: DARE_STRING),
                          );
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 200,
                        child: Center(child: Text('Dare', style: TextStyle(color: kTextWhiteColor))),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
