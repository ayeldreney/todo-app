import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/models/task.dart';
import 'package:todo/shared/network/local/firebase_util.dart';
import 'package:todo/styles/colors.dart';

import '../shared/components/component.dart';

class AddTaskBotttomSheet extends StatefulWidget {
  @override
  State<AddTaskBotttomSheet> createState() => _AddTaskBotttomSheetState();
}

class _AddTaskBotttomSheetState extends State<AddTaskBotttomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add new task",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: BLACK_COLOR,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Please Enter a title";
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        label: Text("Title"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Please Enter a description";
                        }
                        return null;
                      },
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        label: Text("Description"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select date",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: BLACK_COLOR,
                    ),
              ),
              InkWell(
                onTap: () {
                  selectDate(context);
                },
                child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      showLoading(context, "loading...");
                      addTaskToFirestore(
                        Task(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateUtils.dateOnly(selectedDate)
                                .millisecondsSinceEpoch),
                      ).then((value) {
                        Navigator.pop(context);
                        showMessage(
                          context,
                          "successfully",
                          "task added",
                          "ok",
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          isCancellable: false,
                        );
                      });
                    }
                  },
                  child: Text("Add task")),
            ],
          ),
        ),
      ),
    );
  }

  void selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {});
  }
}
