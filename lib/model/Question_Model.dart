// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Question {
  final int id;
  final String title;
  final List<dynamic> answer;
  final int key;
  final int level;

  Question({
    required this.id,
    required this.title,
    required this.answer,
    required this.key,
    required this.level
  });
  Question copyWith({
    int? id,
    String? title,
    List<dynamic>? answer,
    int? key,
    int? level
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      answer: answer ?? this.answer,
      key: key ?? this.key,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'answer': answer,
      'key': key,
      'level' : level
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      title: map['title'] as String,
      answer: List<dynamic>.from(
        (map['answer'] as List<dynamic>),
      ),
      key: map['key'] as int,
      level: map['level'] as int
    );
  }
  factory Question.fromQueryDoucumentSnapshot(QueryDocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String,dynamic>;
    final id = snapshot.id;
    data[id] = id;
    return Question.fromMap(data);
  }
  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, title: $title, answer: $answer, key: $key, level : $level)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.answer, answer) &&
        other.key == key;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        answer.hashCode ^
        key.hashCode;
  }

  // List<Question> question = [
  //   Question(
  //       id: '1',
  //       title: '2 + 2 = ?',
  //       answer: ['2', '4', '6', '8'],
  //       key: 1
  //   ),
  //     Question(
  //       id: '1',
  //       title: '2 + 2 = ?',
  //       answer: ['2', '4', '6', '8'],
  //       key: 1
  //   ),
  //     Question(
  //       id: '1',
  //       title: '2 + 2 = ?',
  //       answer: ['2', '4', '6', '8'],
  //       key: 1
  //   ),
  //     Question(
  //       id: '1',
  //       title: '2 + 2 = ?',
  //       answer: ['2', '4', '6', '8'],
  //       key: 1
  //   ),
        
  // ];
}
