import 'package:flutter/material.dart';

AppBar customAppBarWidget({
  required String title,
}) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
        ),
      ),
    ],
  );
}
