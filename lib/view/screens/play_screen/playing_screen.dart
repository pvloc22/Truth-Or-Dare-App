import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/repository/playing_repository.dart';
import 'package:truth_or_dare/view/screens/play_screen/playing_form.dart';
import 'package:truth_or_dare/view_models/playing_view_model.dart';

class PlayingScreen extends StatelessWidget {
  final int idTopic;
  const PlayingScreen({super.key, required this.idTopic});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context)=> PlayingViewModel(playingRepository: PlayingRepository())..initialData(idTopic),
      child: const PlayingForm(),);
  }
}
