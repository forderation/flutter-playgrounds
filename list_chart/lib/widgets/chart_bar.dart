import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  //NOTE: use const of front constructor when all properties are final
  // this takes litle bit increased performance
  const ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    // using Expanded Widget to most bottom container to push chart section area
    // or use layout builder to get current context limited on sections
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
              height: constraint.maxHeight * 0.10,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            width: 10,
            height: constraint.maxHeight * 0.65,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Text(label)
        ],
      );
    });
  }
}
