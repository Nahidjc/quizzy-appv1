import 'package:flutter/material.dart';
import 'package:quizzy/pages/leaderboard.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 48, // Image radius
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      Text(
                        "Shahin",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.edit_rounded),
                    title: const Text('Update Profile'),
                    onTap: () {
                      // Handle the drawer item tap here
                      Navigator.pop(context);
                      // Implement your logic here
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.add_chart),
                    title: const Text('Statistics'),
                    onTap: () {
                      // Handle the drawer item tap here
                      Navigator.pop(context);
                      // Implement your logic here
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.currency_exchange),
                    title: const Text('Accounts'),
                    onTap: () {
                      // Handle the drawer item tap here
                      Navigator.pop(context);
                      // Implement your logic here
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.history_edu),
                    title: const Text('Quiz History'),
                    onTap: () {
                      // Handle the drawer item tap here
                      Navigator.pop(context);
                      // Implement your logic here
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.leaderboard),
                    title: const Text('Leader Board'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LeaderboardPage(),
                      ));
                    },
                  ),
                ),
                // const Divider(
                //   color: Colors.grey,
                //   indent: 16,
                // ),
              ],
            ),
          ),
          Card(
            color: Colors.redAccent,
            child: ListTile(
              leading: const Icon(Icons.logout,color: Colors.white,),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle the drawer item tap here
                Navigator.pop(context);
                // Implement your logic here
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Version: 1.0.0',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
