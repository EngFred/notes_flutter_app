import 'package:flutter/material.dart';

enum ColorSelection {
  black('Cloud Burst', Color.fromARGB(255, 28, 36, 68)),
  deepPurple('Deep Purple', Colors.deepPurple),
  purple('Purple', Colors.purple),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink),
  teal('Teal', Colors.teal),
  green('Green', Colors.green);

  const ColorSelection(
    this.label,
    this.color,
  );

  final String label;
  final Color color;
}
