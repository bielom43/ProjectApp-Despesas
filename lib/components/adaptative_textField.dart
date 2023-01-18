// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final String label;

  const AdaptativeTextField({
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.onFieldSubmitted,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextFormFieldRow(
              controller: controller,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 10,
              ),
            ),
          )
        : TextFormField(
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
