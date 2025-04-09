
import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../../../../models/dare_model.dart';
import '../../../../models/truth_model.dart';

class QuestionItem extends StatefulWidget{

  final int idItem;
  final Dare? dare;
  final Truth? truth;
  final Future<void> Function(String type, int idItem) deleteItem;

  const QuestionItem({super.key, this.dare, this.truth, required this.deleteItem, required this.idItem});

  @override
  State<StatefulWidget> createState() => _QuestionItemState();

}
class _QuestionItemState extends State<QuestionItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: kTextWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding/2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 10,
                child: Text('${widget.dare!=null ? widget.dare!.name : widget.truth!.name}', style: const TextStyle(color: kTextLightColor),)),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  if(widget.truth != null) {
                    widget.deleteItem( 'truth', widget.idItem);
                  }
                  else{
                    widget.deleteItem( 'dare', widget.idItem);
                  }
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}