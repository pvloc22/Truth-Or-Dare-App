import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/repository/playing_repository.dart';

import '../constant.dart';
import '../models/dare_model.dart';
import '../models/truth_model.dart';

class PlayingViewModel extends ChangeNotifier {
  final PlayingRepository playingRepository;

  bool _isLoading = true;
  List<Truth> _listTruth = [];
  List<Dare> _listDare = [];

  bool get isLoading => _isLoading;

  List<Truth> get listTruth => _listTruth;

  List<Dare> get listDare => _listDare;

  PlayingViewModel({required this.playingRepository});

  Future<void> initialData(int idTopic) async {
    _isLoading = true;
    notifyListeners();

    _listTruth = await playingRepository.fetchTruth(idTopic);
    _listDare = await playingRepository.fetchDare(idTopic);
    _isLoading = false;
    notifyListeners();
  }

  String? randomList(List<Truth> listTruth, List<Dare> listDare, String type) {
    Random random = Random();

    if (type == TRUTH_STRING) {
      do {
        int randomNumber = random.nextInt(listTruth.length);
        if (!(listTruth[randomNumber].is_delete)) {
          return listTruth[randomNumber].name;
        }
      } while (true);
    } else {
      do {
        int randomNumber = random.nextInt(listDare.length);
        if (!(listDare[randomNumber].is_delete)) {
          return listDare[randomNumber].name;
        }
      } while (true);
    }
  }
}
