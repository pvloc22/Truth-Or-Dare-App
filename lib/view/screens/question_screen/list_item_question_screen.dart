import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Topic_model.dart';
import '../../../repository/question_repository.dart';
import '../../../view_models/question_view_model.dart';
import 'list_item_question_form.dart';

class ListItemQuestionScreen extends StatelessWidget {
  final Topic topic;

  const ListItemQuestionScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => QuestionViewModel(questionRepository: QuestionRepository())..fetchTruthAndDare(topic.id),
          child: const ListItemQuestionForm(),
      );
  }
}
