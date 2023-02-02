import 'package:flutter/material.dart';
import 'package:todo/modules/settings/settings.dart';
import 'package:todo/modules/tasks_list/tasks_list.dart';
import 'package:todo/providers/bot_nav_bar_provider.dart';
import 'package:todo/styles/colors.dart';
import 'package:provider/provider.dart';

import 'add_task_bottom_sheet.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'Home';

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: WHITE_COLOR,
            width: 3,
          ),
        ),
        onPressed: () {
          addTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: context.watch<BotNavBarProvider>().currentIndex,
          onTap: (value) {
            context.read<BotNavBarProvider>().change(value);
          },
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 35,
                ),
                label: ""),
          ],
        ),
      ),
      body: tabs[context.watch<BotNavBarProvider>().currentIndex],
    );
  }

  addTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddTaskBotttomSheet(),
    );
  }

  List<Widget> tabs = [
    TasksListTab(),
    SettingsTab(),
  ];
}
