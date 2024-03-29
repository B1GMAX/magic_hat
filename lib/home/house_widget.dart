import 'package:flutter/material.dart';

class HouseWidget extends StatelessWidget {
  final String houseName;
  final bool isNotInHouse;
  final Function(String) onPressed;

  const HouseWidget({
    required this.houseName,
    required this.onPressed,
    this.isNotInHouse = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !isNotInHouse
        ? Expanded(
            child: GestureDetector(
              onTap: () {
                onPressed(houseName);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/$houseName.webp',
                      height: 50,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      houseName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              onPressed(houseName);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Center(
                child: Text(
                  houseName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
  }
}
