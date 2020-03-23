import 'package:alarm/components/card-component.dart';
import 'package:flutter/material.dart';
import 'package:alarm/constants/constants.dart';
class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: boards.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CardComponent(board: boards[index], colors: gradients[index],);
        }
    );
  }
}
