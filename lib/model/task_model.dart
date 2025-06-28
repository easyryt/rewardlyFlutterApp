import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String subtitle;
  final String reward;
  final String action;
  final String imageUrl;
  final Color bgColor;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.reward,
    required this.action,
    required this.imageUrl,
    required this.bgColor,
  });
}
