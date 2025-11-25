import 'package:flutter/material.dart';

class custom_radio extends StatefulWidget {
  final text;
  const custom_radio({super.key, this.text});

  @override
  State<custom_radio> createState() => _custom_radioState();
}

class _custom_radioState extends State<custom_radio> {
  @override
  Widget build(BuildContext context) {
    String? tratamiento = 'Sr';

    return Row(
      children: [
        Radio(
          value: widget.text,
          groupValue: tratamiento,

          onChanged: (value) {
            setState(() => tratamiento = value);
          },
        ),
        Text(widget.text),
      ],
    );
  }
}
