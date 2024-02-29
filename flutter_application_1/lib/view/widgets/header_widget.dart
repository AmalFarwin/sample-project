import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTapNew;
  const HeaderWidget({
    super.key,
    required this.onTapNew,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Contacts",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
            onPressed: onTapNew,
            icon: const Icon(
              Icons.person_add,
              color: Colors.white,
              size: 25,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
