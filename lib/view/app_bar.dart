import 'package:flutter/material.dart';

PreferredSizeWidget topAppBar() {
  return AppBar(
    title: const Text(
      "Alec's Sports",
      style: TextStyle(
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.black
        // gradient: LinearGradient(
        //   colors: [Colors.blue, Colors.black],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.menu, color: Colors.lightBlue),
      onPressed: () {},
    ),
    actions: [
      const CircleAvatar(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.person, color: Colors.black),
      ),
      const SizedBox(width: 10),
      IconButton(
        icon: const Icon(Icons.notifications, color: Colors.lightBlue),
        onPressed: () {},
      ),
    ],
  );
}