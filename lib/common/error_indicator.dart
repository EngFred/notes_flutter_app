import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String error;
  const ErrorIndicator({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
