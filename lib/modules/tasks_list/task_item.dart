import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/network/local/firebase_util.dart';
import 'package:todo/styles/colors.dart';

import '../../models/task.dart';

class TaskItem extends StatelessWidget {
  Task task;
  TaskItem(this.task);

  String cache = "";
  String cache_1 = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (context) => deleteTask(task.id),
            ),
            SlidableAction(
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Edit',
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      actions: [
                        Container(
                          decoration: BoxDecoration(
                            color: GREEN_BACKGROUND,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Form(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                height: 300,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Edit Task",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        updateTask(
                                          task.id,
                                          value,
                                          "",
                                        );
                                        cache = value;
                                      },
                                      controller: TextEditingController(),
                                      decoration: InputDecoration(
                                          hintText: "This is Title"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        updateTask(
                                          task.id,
                                          cache,
                                          value,
                                        );
                                        cache_1 = value;
                                      },
                                      controller: TextEditingController(),
                                      decoration: InputDecoration(
                                          hintText: "Task details"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 40,
                                        child: Text(
                                          "Save Changes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: WHITE_COLOR),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                color: PRIMARY_COLOR,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      task.description,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.done,
                  size: 30,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
