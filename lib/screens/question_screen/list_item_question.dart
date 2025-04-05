import 'package:flutter/material.dart';
import 'package:truth_or_dare/models/question_models.dart';
import 'package:truth_or_dare/constant.dart';

import '../play_screen/playing_screen.dart';
import 'components/dialog_make_question.dart';
import 'components/question_item.dart';


class ListItemQuestion extends StatefulWidget {
  const ListItemQuestion({super.key, required this.data, required this.writeJsonFile});

  final Data? data;
  final Future<void> Function() writeJsonFile;

  @override
  State<ListItemQuestion> createState() => _ListItemQuestionState();
}

class _ListItemQuestionState extends State<ListItemQuestion> with TickerProviderStateMixin {

  late final TabController _tabController;
  late int selectedRadio;

  Future<void> deleteItem(String type, int idItem) async{
    switch (type) {
      case 'truth':
        setState(() {
          widget.data!.truth![idItem].state = false;
        });
        break;
      case 'dare':
        setState(() {
          widget.data!.dare![idItem].state = false;
        });
        break;
    }

  }

  Future<void> insertQuestion(String question, bool isCheckbox_1, bool isCheckbox_2, Data data) async {
    if(!question.isEmpty){
      if(isCheckbox_1){
        Truth newQuestion = Truth(id: widget.data!.truth!.length,name: question, state: true);
        setState(() {
          widget.data!.truth!.insert(widget.data!.truth!.length, newQuestion);
          widget.writeJsonFile();
        });
      }
      else{
        Dare newQuestion = Dare(id: widget.data!.truth!.length,name: question, state: true);
        setState(() {
          widget.data!.dare!.insert(widget.data!.dare!.length, newQuestion);
          widget.writeJsonFile();
        });
      }
    }
  }
  @override
  void initState(){
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  showToMakeQuestionDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => DialogMakeQuestion(data: widget.data!,insertQuestion: insertQuestion,));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: kButtonColor,
                  ),
                  onPressed: () {
                    showToMakeQuestionDialog(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor
            ),
            child: TabBar(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    child: Text('Truth', style: TextStyle(color: kTextWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Tab(
                    child: Text('Dare', style: TextStyle(color: kTextWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),),
                  )
                ]
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding/2),
              child: TabBarView(
                  controller: _tabController,
                  children: <Widget> [
                    Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              itemCount: widget.data!.truth!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return widget.data!.truth![index].state! ? QuestionItem(
                                  truth: widget.data!.truth![index],
                                  deleteItem: deleteItem,
                                  idItem: index,
                                ) : Container();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: kDefaultPadding*4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kButtonColor,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                            ),
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayingScreen(
                                        data: widget.data,
                                        topic: widget.data!.title,
                                      )));
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 200,
                              child: Center(
                                child: Text(
                                  'BẮT ĐẦU CHƠI',
                                  style: TextStyle(color: kTextWhiteColor),
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              itemCount: widget.data!.dare!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return widget.data!.dare![index].state! ? QuestionItem(
                                  dare: widget.data!.dare![index],
                                  deleteItem: deleteItem,
                                  idItem: index,
                                ) : Container();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: kDefaultPadding*3),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kButtonColor,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                              ),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayingScreen(
                                          data: widget.data,
                                          topic: widget.data!.title,
                                        )));
                              },
                              child: const SizedBox(
                                height: 50,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    'BẮT ĐẦU CHƠI',
                                    style: TextStyle(color: kTextWhiteColor),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )

        ],
      ),
    );
  }
}


