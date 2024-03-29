import 'package:flutter/cupertino.dart';
import 'package:magic_hat/widgets/score_widget.dart';

class ScoresHeader extends StatelessWidget {
  final String totalText;
  final String totalValue;
  final String successText;
  final String successValue;
  final String failedText;
  final String failedValue;

  const ScoresHeader({
    required this.totalText,
    required this.totalValue,
    required this.successText,
    required this.successValue,
    required this.failedText,
    required this.failedValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ScoreWidget(
          text: totalText,
          value: totalValue,
        ),
        ScoreWidget(
          text: successText,
          value: successValue,
        ),
        ScoreWidget(
          text: failedText,
          value: failedValue,
        ),
      ],
    );
  }
}
