import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/view_models/home_view_model.dart';

import '../../../constant.dart';
import '../../../models/Topic_model.dart';
import '../question_screen/list_item_question_screen.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  final List<Topic> allData = [];
  final TextEditingController _titleTopic = TextEditingController();

  // Separate dialog widget for better performance
  Widget _buildAddTopicDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      title: const Text('Thêm chủ đề mới', style: TextStyle(color: kTextWhiteColor)),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kBackgroundColor,
          boxShadow: [BoxShadow(color: kColorHidden.withOpacity(0.2), offset: const Offset(0, 4), blurRadius: 4)],
        ),
        child: TextField(
          controller: _titleTopic,
          scrollPadding: const EdgeInsets.all(kDefaultPadding / 2),
          enabled: true,
          cursorColor: kButtonColor,
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            onPressed: () {
              int id = context.read<HomeViewModel>().listTopics.length;
              context.read<HomeViewModel>().insertATopic(Topic(id: id, title: _titleTopic.text));
              Navigator.of(context).pop();
            },
            child: const Text('Thêm mới', style: TextStyle(color: kTextWhiteColor)),
          ),
        ),
      ],
    );
  }

  // Optimized topic item widget
  Widget _buildTopicItem(Topic topic, int index) {
    return Padding(
      key: ValueKey(topic.id),
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        child: ElevatedButton(
          onPressed: () => _navigateToQuestions(topic),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          child: Text(topic.title, style: const TextStyle(color: kTextWhiteColor, fontFamily: defaultFontFamily)),
        ),
      ),
    );
  }

  void _navigateToQuestions(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ListItemQuestionScreen(
              topic: topic,
            ),
      ),
    );
  }

  void _showAddTopicDialog() {
    showDialog(context: context, builder: (dialogContext) => _buildAddTopicDialog(dialogContext));
  }

  bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }

  Future<void> handleReadFilCustomer(bool isReset) async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleTopic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(children: <Widget>[_buildAppBar(), _buildBody()])));
  }

  Widget _buildAppBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kBackgroundColor,
        boxShadow: [BoxShadow(color: kColorHidden.withOpacity(0.2), offset: const Offset(0, 4), blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: kButtonColor), onPressed: () => Navigator.pop(context)),
          const Text(
            "Truth or Dare",
            style: TextStyle(
              color: kTextLightColor,
              fontFamily: defaultFontFamily,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(icon: const Icon(Icons.add, color: kButtonColor), onPressed: _showAddTopicDialog),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<HomeViewModel>(
      builder: (context, viewHomeModel, child) {
        if (viewHomeModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewHomeModel.listTopics.isNotEmpty) {
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewHomeModel.listTopics.length,
                    itemBuilder: (context, index) => _buildTopicItem(viewHomeModel.listTopics[index], index),
                  ),
                ),
                _buildResetButton(),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Empty data'));
        }
      },
    );
  }

  Widget _buildResetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 3),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kButtonColor,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          onPressed: () => setState(() => handleReadFilCustomer(true)),
          child: const Text('Load lại dữ liệu ban đầu', style: TextStyle(color: kTextWhiteColor)),
        ),
      ),
    );
  }
}
