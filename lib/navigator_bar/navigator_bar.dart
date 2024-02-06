import 'package:flutter/material.dart';
import 'package:magic_hat/home/home_screen.dart';
import 'package:magic_hat/list_screen/list_screen.dart';
import 'package:magic_hat/navigator_bar/navigator_bar_bloc.dart';
import 'package:provider/provider.dart';

import 'navigator_bar_widget.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Provider<NavigatorBarBloc>(
      create: (context) => NavigatorBarBloc(),
      builder: (context, _) {
        return StreamBuilder<int>(
            initialData: 0,
            stream: context.read<NavigatorBarBloc>().indexPageStream,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data! == 0 ? 'Home Screen' : 'List Screen',
                    ),
                  ),
                ),
                bottomNavigationBar: NavigatorBarWidget(
                  onPageChange: (index) {
                    context.read<NavigatorBarBloc>().changeIndexPage(index);
                  },
                  homeColor: snapshot.data! == 0 ? Colors.black : Colors.grey,
                  listColor: snapshot.data! == 1 ? Colors.black : Colors.grey,
                ),
                body: PageView(
                  controller:
                      context.read<NavigatorBarBloc>().pagViewController,
                  onPageChanged: (index) {
                    context.read<NavigatorBarBloc>().changeIndexPage(index);
                  },
                  children: const [
                    HomeScreen(),
                    ListScreen(),
                  ],
                ),
              );
            });
      },
    );
  }
}
