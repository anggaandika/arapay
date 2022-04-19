// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';

class AppDropdownInput extends StatefulWidget {
  final String hintText;
  final List<dynamic> options;
  String value;
  TextStyle getLabel;
  final VoidCallback getInit;
  AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.value = '',
    required this.getLabel,
    required this.getInit,
  }) : super(key: key);

  @override
  State<AppDropdownInput> createState() => _AppDropdownInputState();
}

class _AppDropdownInputState extends State<AppDropdownInput> {
  @override
  void initState() {
    widget.getInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelStyle: widget.getLabel,
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: widget.options == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.value,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  widget.value = newValue.toString();
                  state.didChange(newValue);
                });
              },
              items: widget.options.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
