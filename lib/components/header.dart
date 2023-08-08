import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api_caller/campaign.dart';
import 'package:quizzy/components/campaign/campaign_quiz_list.dart';
import 'package:quizzy/components/campaign/campaign_skeleton.dart';
import 'package:quizzy/models/campaign.dart';
import 'package:quizzy/provider/login_provider.dart';

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
  final CampaignApi campaignApi = CampaignApi();
  bool isLoading = false;

  Campaign? campaign;
  @override
  void initState() {
    super.initState();
    getCampaign();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getCampaign() async {
    setState(() {
      isLoading = true;
    });
    try {
      Campaign campaignData = await campaignApi.getCampaign();
      setState(() {
        campaign = campaignData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider user = Provider.of<AuthProvider>(context);
    String name = user.name;
    int coin = user.coin;
    String coinString = coin.toString();
    DateTime currentDate = DateTime.now();

    bool isUpcoming = campaign?.startDate != null &&
        campaign?.startDate.isAfter(currentDate) == true;
    bool isRunning = campaign?.startDate != null &&
        campaign?.endDate != null &&
        campaign?.startDate.isBefore(currentDate) == true &&
        campaign?.endDate.isAfter(currentDate) == true;

    bool isClosed = campaign?.endDate != null &&
        campaign?.endDate.isBefore(currentDate) == true;

    // bool isClosed = campaign?.endDate.isBefore(currentDate) ?? false;
    return AppBar(
        toolbarHeight: 190.0,
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: const Color.fromARGB(255, 144, 106, 250),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [Container()],
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
                        // backgroundImage: AssetImage("assets/images/avatar.png"),
                        backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/113003788?v=4"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
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
                          color: const Color.fromARGB(255, 144, 106, 250),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.emoji_events,
                                  color: Color(0xFFFFD700),
                                  size: 20.0,
                                ),
                                const SizedBox(
                                    width:
                                        4.0), // Add some spacing between the icon and text
                                Text(
                                  coinString,
                                  style: const TextStyle(
                                    color: Color(0xFFFFD700),
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
              height: 90.0,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white),
              child: isLoading
                  ? const CampaignSkeleton()
                  : campaign == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.campaign,
                                color: Colors.grey,
                                size: 64.0,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "No active campaigns at the moment",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Please check back later for exciting challenges.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                              children: [
                                Text(
                                  isUpcoming
                                      ? "Upcoming Competition"
                                      : isRunning
                                          ? "Running Competition"
                                          : "Closed Competition",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  campaign?.campaignName ?? 'Loading...',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${DateFormat('d MMM, h:mm a').format(campaign!.startDate)} - ${DateFormat('d MMM, h:mm a').format(campaign!.endDate)}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                              ),
                    ElevatedButton(
                      onPressed: isRunning
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CampaignQuizList(
                                      campaignId: campaign!.id),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRunning
                            ? Colors.orange
                            : (isUpcoming || isClosed)
                                ? Colors.grey
                                : Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                      ),
                      child: const Text(
                        "Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }
}
