import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ContactModel {
  final File? imageFile;
  final String name;
  final String number;
  const ContactModel({
    required this.imageFile,
    required this.name,
    required this.number,
  });
  ContactModel copyWith({
    File? imageFile,
    String? name,
    String? number,
  }) {
    return ContactModel(
        imageFile: imageFile ?? this.imageFile,
        name: name ?? this.name,
        number: number ?? this.number);
  }
}
