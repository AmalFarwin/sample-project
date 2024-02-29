import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/contact_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactFieldSheet extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController number;
  final File? image;
  final GlobalKey<FormState> formKey;
  final void Function() onSubmit;
  final VoidCallback onTapImage;
  const ContactFieldSheet({
    super.key,
    required this.name,
    required this.number,
    required this.image,
    required this.formKey,
    required this.onSubmit,
    required this.onTapImage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * .7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    IconButton(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.check),
                    )
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: onTapImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Consumer(builder: (_, ref, __) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey[850],
                            radius: 65,
                            backgroundImage: ref.watch(imageProvider) == null
                                ? image == null
                                    ? null
                                    : FileImage(image!)
                                : FileImage(
                                    File(ref.watch(imageProvider)!.path)),
                            child: ref.watch(imageProvider) == null
                                ? image == null
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 8 * 7,
                                      )
                                    : null
                                : null,
                          );
                        }),
                        Positioned(
                            child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[800]),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Name",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintText: "Enter Name",
                      prefixIcon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintText: "Enter phone number",
                      prefixIcon: Icon(Icons.phone_android),
                      counterText: ""),
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    if (value.length < 10) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
