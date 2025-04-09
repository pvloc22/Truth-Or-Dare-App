import 'package:truth_or_dare/repository/home_repository.dart';
import 'package:flutter/material.dart';

import '../models/Topic_model.dart';
class HomeViewModel extends ChangeNotifier{
  final HomeRepository _homeRepository;
  bool _isLoading = true;
  List<Topic> _listTopics = [];

  HomeViewModel({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  bool get isLoading => _isLoading;
  List<Topic> get listTopics => _listTopics;

  Future<void> fetchData() async {
    ///Loading
    _isLoading = true;
    notifyListeners();

    _listTopics = await _homeRepository.fetchAllTopics();
    _isLoading = false;
    notifyListeners();
  }
  Future<void> insertATopic(Topic topic) async {
    _listTopics.add(topic);
    await _homeRepository.insertTopic(topic);
    notifyListeners();

  }
}