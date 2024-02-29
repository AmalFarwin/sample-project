import 'dart:io';

import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    return [];
  }

  void addContact(ContactModel contact) {
    state = [contact, ...state];
  }

  void editContact(String name, String number, int index, File? image) {
    final contacts = state;
    contacts[index] =
        contacts[index].copyWith(name: name, number: number, imageFile: image);
    state = List.from(contacts);
  }

  void deleteContact(int index) {
    final contacts = state;
    contacts.removeAt(index);
    state = List.from(contacts);
  }
}

final contactProvider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);

final imageProvider = StateProvider<XFile?>((ref) => null);
