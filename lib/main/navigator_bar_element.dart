import 'package:flutter/material.dart';

class NavigatorBarWidget extends StatelessWidget {
  final Function(int) onPageChange;
  final Color homeColor;
  final Color listColor;

  const NavigatorBarWidget({
    required this.onPageChange,
    required this.homeColor,
    required this.listColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              onPageChange(0);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  color: homeColor,
                ),
                const SizedBox(height: 5),
                Text(
                  'Home',
                  style: TextStyle(color: homeColor),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onPageChange(1);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.list,
                  color: listColor,
                ),
                const SizedBox(height: 5),
                Text(
                  'List',
                  style: TextStyle(color: listColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
