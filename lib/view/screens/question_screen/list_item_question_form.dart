import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/models/Topic_model.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/repository/question_repository.dart';
import 'package:truth_or_dare/view_models/question_view_model.dart';
import 'package:truth_or_dare/view/screens/play_screen/playing_screen.dart';

class ListItemQuestionForm extends StatefulWidget {
  const ListItemQuestionForm({super.key});


  @override
  State<ListItemQuestionForm> createState() => _ListItemQuestionFormState();
}

class _ListItemQuestionFormState extends State<ListItemQuestionForm> with TickerProviderStateMixin {
  late final TabController _tabController;
  late int selectedRadio;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                IconButton(
                  icon: const Icon(Icons.add, color: kButtonColor),
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => DialogQuestion(question: question ?? 'error!!', type: TRUTH_STRING),
                    // );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: kPrimaryColor),
            child: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  child: Text(
                    'Truth',
                    style: TextStyle(color: kTextWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Dare',
                    style: TextStyle(color: kTextWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TabBarView(controller: _tabController, children: <Widget>[_truthTabView(), _dareTabView()]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _truthTabView() {
    return Column(
      children: [
        Consumer<QuestionViewModel>(
          builder: (context, questionViewModel, child) {
            if (questionViewModel.isLoading) {
              print('okie1');
              return const Center(child: CircularProgressIndicator());
            } else {
              print(questionViewModel.listTruth);
              return Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: questionViewModel.listTruth.length,
                    itemBuilder: (BuildContext context, int index) {
                      return questionViewModel.listTruth[index].is_delete
                          ? Container()
                          : _itemTruthOrDare(true, questionViewModel.listTruth[index]);
                    },
                  ),
                ),
              );
            }
          },
        ),
        _buttonStartGame()
      ],
    );
  }

  Widget _dareTabView() {
    return Column(
      children: [
        Consumer<QuestionViewModel>(
          builder: (context, questionViewModel, child) {
            if (questionViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: questionViewModel.listDare.length,
                        itemBuilder: (BuildContext context, int index) {
                        return questionViewModel.listDare[index].is_delete
                            ? Container()
                            : _itemTruthOrDare(false, questionViewModel.listDare[index]);
                      },    
                    ),  
                  ),
                );
              }
            },
          ),
        _buttonStartGame(),
      ],
    );
  }

  Widget _itemTruthOrDare(bool isTruth, dynamic data) {
    final String name = data.name ?? '';
    return Card(
      color: kTextWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 10, child: Text(name, style: const TextStyle(color: kTextLightColor))),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if (isTruth) {
                    print('${data.id}');
                    print('${context.read<QuestionViewModel>().idTopic}');
                    context.read<QuestionViewModel>().deleteATruth(data.id, context.read<QuestionViewModel>().idTopic); 
                  } else {
                    context.read<QuestionViewModel>().deleteADare(data.id, context.read<QuestionViewModel>().idTopic); 
                  }
                },
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonStartGame() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kButtonColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          int idTopic = context.read<QuestionViewModel>().idTopic;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlayingScreen(idTopic: idTopic,)),
          );
        },
        child: const SizedBox(
          height: 50,
          width: 200,
          child: Center(child: Text('BẮT ĐẦU CHƠI', style: TextStyle(color: kTextWhiteColor))),
        ),
      ),
    );
  }
}
