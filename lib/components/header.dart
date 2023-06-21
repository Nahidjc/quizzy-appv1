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
                Row(children: [
                  Container(
                    // height: 90.0,
                    // width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      // color: Colors.white
                    ),
                    child: const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage("assets/images/avatar.png"),
                    ),
                  ),
                  const Column(children: [
                    Text(
                      "Hello",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Text("Pradyut",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                Row(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          // alignment: Alignment.centerLeft
                        ),
                        onPressed: () {},
                        child: const Row(children: [
                          Icon(Icons.emoji_events, color: Color(0xFFFFD700)),
                          Text("100",
                              style: TextStyle(color: Color(0xFFFFD700)))
                        ])),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined,
                          color: Colors.white),
                      // alignment: Alignment.centerRight
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 80.0,
              width: 380.0,
              // color: Colors.white,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        child: const Icon(
                      Icons.emoji_events,
                      color: Color(0xFFFFD700),
                      size: 50.0,
                    )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: const Column(children: [
                          Text("Upcoming Competitions",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.4)),
                          Text("Weekly challenges",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5)),
                          Text("Now 11 am - 11.30 pm",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5))
                        ])),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(75, 75)),
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
                    )
                  ]),
            )
          ],
        ));
  }
}
