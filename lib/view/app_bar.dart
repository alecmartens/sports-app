import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login/login_page.dart';
import 'dropdown_menu.dart';
import 'favorites/favorites_page.dart';
import 'home_page.dart';

PreferredSizeWidget topAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != 'HomePage') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
                settings: const RouteSettings(name: 'HomePage'),
              ));
            }
          },
          child: Row(
            // Inner row for image and text
            children: [
              Image.asset(
                'assets/images/logos/logo_small_light_mode.png',
                fit: BoxFit.contain,
                height: 32, // You can adjust the size as needed.
              ),
              const SizedBox(
                  width: 8), // Add a little spacing between logo and title
              const Text(
                "Alec's Sports",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
    leading: const SizedBox(
      width: 400, // or any other width you deem appropriate
      child: Dropdown_Menu(),
    ),
    actions: [
      PopupMenuButton<String>(
        onSelected: (String result) {
          switch (result) {
            case 'logout':
              FirebaseAuth.instance.signOut();
              // Navigate to another page after logging out.
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage(),
              ));
              break;
            // case 'favorites':
            //   // Navigate to the FavoritesPage when "Favorites" is selected.
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => const FavoritesPage(),
            //   ));
            //   break;
            // // Add more cases for other menu items if needed.
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          // const PopupMenuItem<String>(
          //   value: 'favorites',
          //   child: ListTile(
          //     leading: Icon(Icons.favorite),
          //     title: Text('Favorites'),
          //   ),
          // ),
          const PopupMenuItem<String>(
            value: 'logout',
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
          ),
          // Add more items to the dropdown menu if needed.
        ],
        child: const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.person, color: Colors.black),
        ),
      ),
      const SizedBox(width: 10),
    ],
  );
}
