import 'package:flutter/cupertino.dart';

class CharacterDescription extends StatelessWidget {
  final String descriptionName;
  final String description;

  const CharacterDescription({
    required this.description,
    required this.descriptionName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          descriptionName,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            description,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
