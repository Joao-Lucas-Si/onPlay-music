import 'package:flutter/material.dart';

class Check<T> extends StatelessWidget {
  final T value;
  final T currentValue;
  final String text;
  final Function(T value) onChanged;

  const Check(
      {super.key,
      required this.value,
      required this.currentValue,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: currentValue == value,
          onChanged: (_) {
            if (_ != null) {
              onChanged(value);
            }
          },
        ),
        Text(text)
      ],
    );
  }
}