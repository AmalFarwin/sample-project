import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/provider/contact_provider.dart';
import 'package:flutter_application_1/view/widgets/contact_field.dart';
import 'package:flutter_application_1/view/widgets/header_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final name = TextEditingController();
  final number = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProvider);
    return Scaffold(
      appBar: HeaderWidget(onTapNew: () {
        number.clear();
        name.clear();
        showModalBottomSheet(
            scrollControlDisabledMaxHeightRatio: 1,
            context: context,
            builder: (context) => ContactFieldSheet(
                name: name,
                number: number,
                image: null,
                formKey: formKey,
                onSubmit: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(contactProvider.notifier).addContact(ContactModel(
                        imageFile: ref.watch(imageProvider) == null
                            ? null
                            : File(ref.watch(imageProvider)!.path),
                        name: name.text,
                        number: number.text));
                    name.clear();
                    number.clear();
                    ref.read(imageProvider.notifier).state = null;
                    Navigator.pop(context);
                  }
                },
                onTapImage: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Pick Image From"),
                            content: Row(
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    final imagePicker = ImagePicker();
                                    XFile? image = await imagePicker.pickImage(
                                        source: ImageSource.camera);
                                    if (image != null) {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                    ref.read(imageProvider.notifier).state =
                                        image;
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text("Camera"),
                                ),
                                TextButton.icon(
                                    onPressed: () async {
                                      final imagePicker = ImagePicker();
                                      XFile? image =
                                          await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                      if (image != null) {
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      }
                                      ref.read(imageProvider.notifier).state =
                                          image;
                                    },
                                    icon: const Icon(Icons.photo),
                                    label: const Text("Gallery"))
                              ],
                            ),
                          ));
                }));
      }),
      body: contacts.isEmpty
          ? Center(
              child: Text(
                "Add a new contact",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: contacts[index].imageFile == null
                        ? null
                        : FileImage(contacts[index].imageFile!),
                    child: contacts[index].imageFile == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  title: Text(contacts[index].name),
                  subtitle: Text(contacts[index].number),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            name.text = contacts[index].name;
                            number.text = contacts[index].number;
                            showModalBottomSheet(
                                scrollControlDisabledMaxHeightRatio: 1,
                                context: context,
                                builder: (context) => ContactFieldSheet(
                                    name: name,
                                    number: number,
                                    image: contacts[index].imageFile,
                                    formKey: formKey,
                                    onSubmit: () {
                                      if (formKey.currentState!.validate()) {
                                        ref
                                            .read(contactProvider.notifier)
                                            .editContact(
                                              name.text,
                                              number.text,
                                              index,
                                              ref.watch(imageProvider) == null
                                                  ? null
                                                  : File(ref
                                                      .watch(imageProvider)!
                                                      .path),
                                            );
                                        name.clear();
                                        number.clear();
                                        ref.read(imageProvider.notifier).state =
                                            null;
                                        Navigator.pop(context);
                                      }
                                    },
                                    onTapImage: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Pick Image From"),
                                                content: Row(
                                                  children: [
                                                    TextButton.icon(
                                                      onPressed: () async {
                                                        final imagePicker =
                                                            ImagePicker();
                                                        XFile? image =
                                                            await imagePicker
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .camera);
                                                        if (image != null) {
                                                          if (context.mounted) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                        ref
                                                            .read(imageProvider
                                                                .notifier)
                                                            .state = image;
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera),
                                                      label:
                                                          const Text("Camera"),
                                                    ),
                                                    TextButton.icon(
                                                        onPressed: () async {
                                                          final imagePicker =
                                                              ImagePicker();
                                                          XFile? image =
                                                              await imagePicker
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                          if (image != null) {
                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          }
                                                          ref
                                                              .read(
                                                                  imageProvider
                                                                      .notifier)
                                                              .state = image;
                                                        },
                                                        icon: const Icon(
                                                            Icons.photo),
                                                        label: const Text(
                                                            "Gallery"))
                                                  ],
                                                ),
                                              ));
                                    }));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(contactProvider.notifier)
                                .deleteContact(index);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
