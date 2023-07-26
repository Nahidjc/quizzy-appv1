import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username = "John Doe";
  final int totalScore = 550;

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('User Profile', style: TextStyle(color: Colors.white)),
        toolbarHeight: 120.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.purple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Score: $totalScore',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  onPressed: () {},
                  child: const Text('Logout',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
              ],
            ),
          ),
          Positioned(
            top: kToolbarHeight + 0.0,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
          ),
        ],
      ),
    );
  }
}
