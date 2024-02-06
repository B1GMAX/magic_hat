import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class NavigatorBarBloc {
  final pagViewController = PageController();

  final _indexPageController = BehaviorSubject<int>();

  Stream<int> get indexPageStream => _indexPageController.stream;

  void changeIndexPage(int index) {
    pagViewController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);

    _indexPageController.add(index);
  }
}
