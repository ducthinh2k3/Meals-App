import 'package:flutter/material.dart';

class Categorymodel {
  final String id;
  final String title;
  final Color color;

  const Categorymodel({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}
