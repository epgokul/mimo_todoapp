import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final User? user;
  const SettingsPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    "Settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Text('')
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user?.displayName}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text("${user?.email}")
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const RowElement(
                icondata: Icons.notifications, text: "Notifications"),
            const SizedBox(
              height: 10,
            ),
            const RowElement(icondata: Icons.settings, text: "General"),
            const SizedBox(
              height: 10,
            ),
            const RowElement(icondata: Icons.person, text: "Account"),
            const SizedBox(
              height: 10,
            ),
            const RowElement(icondata: Icons.info, text: "About"),
          ],
        ),
      ),
    );
  }
}

class RowElement extends StatelessWidget {
  final IconData icondata;
  final String text;
  const RowElement({super.key, required this.icondata, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icondata,
          size: 30,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
