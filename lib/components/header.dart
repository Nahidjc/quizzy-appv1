import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(190.0);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 190.0,
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: const Color(0xFF5826E5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Nahid",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF5826E5),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.2,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: const Color(0xFFFFD700),
                                  size: 20.0,
                                ),
                                const SizedBox(
                                    width:
                                        4.0), // Add some spacing between the icon and text
                                Text(
                                  "100",
                                  style: TextStyle(
                                    color: const Color(0xFFFFD700),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 80.0,
              width: 380.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: const Icon(
                          Icons.emoji_events,
                          color: Color(0xFFFFD700),
                          size: 50.0,
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10.0),
                        child: const Column(children: [
                          Text("Upcoming Competitions",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5)),
                          Text("Weekly challenges",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6)),
                          Text("Now 11.00 am - 11.30 pm",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.6))
                        ])),
                    Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(75, 75)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Join\nNow",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                      ),
                    )
                  ]),
            )
          ],
        ));
  }
}
