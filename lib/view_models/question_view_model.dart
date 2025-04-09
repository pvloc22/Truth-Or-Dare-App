import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:truth_or_dare/constant.dart';
import 'package:truth_or_dare/models/dare_model.dart';
import 'package:truth_or_dare/models/truth_model.dart';
import 'package:truth_or_dare/repository/question_repository.dart';
class QuestionViewModel extends ChangeNotifier{
  final QuestionRepository questionRepository;

  QuestionViewModel({required this.questionRepository});

  bool _isLoading = true;
  List<Truth> _listTruth =[];
  List<Dare> _listDare = [];
  int _idTopic = 0;

  List<Truth> get listTruth => _listTruth;
  List<Dare> get listDare => _listDare;
  bool get isLoading => _isLoading;
  int get idTopic => _idTopic;

  Future<void> fetchTruthAndDare(int idTopic) async {
    try {
      _isLoading = true;
      _idTopic = idTopic;
      notifyListeners();

      _listTruth = await questionRepository.fetchTruth(idTopic);
      _listDare = await questionRepository.fetchDare(idTopic);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
  // create future to fetch list truth

  
  void deleteADare(int id, int idTopic) async {
    _isLoading = true;
    notifyListeners();

    await questionRepository.deleteDareOfTopic(id, idTopic);
    _listDare = await questionRepository.fetchDare(idTopic);
    _isLoading = false;
    notifyListeners();
  }

  void deleteATruth(int id, int idTopic) async {
    _isLoading = true;
    notifyListeners();

    await questionRepository.deleteTruthOfTopic(id, idTopic);
    _listTruth = await questionRepository.fetchTruth(idTopic);
    print(_listTruth);
    _isLoading = false;
    notifyListeners();
  }
}
