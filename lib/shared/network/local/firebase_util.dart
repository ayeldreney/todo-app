import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

CollectionReference<Task> getTaskCollection() =>
    FirebaseFirestore.instance.collection("tasks").withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

Future<void> addTaskToFirestore(Task task) {
  var collection = getTaskCollection();
  var docref = collection.doc();
  task.id = docref.id;
  return docref.set(task);
}

Stream<QuerySnapshot<Task>> getTasksFromFirebase(DateTime dateTime) {
  return getTaskCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
      .snapshots();
}

Future<void> deleteTask(String id) {
  return getTaskCollection().doc(id).delete();
}

void updateTask(
  String id,
  String title,
  String description,
  int date,
) {
  getTaskCollection()
      .doc(id)
      .update({"title": title, "description": description, "date": date})
      .then((_) => print('Success'))
      .catchError((error) => print('Failed: $error'));
  ;
}
