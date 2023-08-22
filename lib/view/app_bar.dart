import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

PreferredSizeWidget topAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logos/small_monke.png',
          fit: BoxFit.contain,
          height: 32, // You can adjust the size as needed.
        ),
        const SizedBox(width: 8), // Add a little spacing between logo and title
        const Text(
          "Alec's Sports",
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.menu, color: Colors.lightBlue),
      onPressed: () {},
    ),
    actions: [
      PopupMenuButton<String>(
        onSelected: (String result) {
          if (result == 'logout') {
            FirebaseAuth.instance.signOut();
            // Optionally, navigate to another page after logging out.
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'logout',
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
          ),
          // You can add more items here
        ],
        child: const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.person, color: Colors.black),
        ),
      ),
      const SizedBox(width: 10),
      // IconButton(
      //   icon: const Icon(Icons.notifications, color: Colors.lightBlue),
      //   onPressed: () {},
      // ),
    ],
  );
}
