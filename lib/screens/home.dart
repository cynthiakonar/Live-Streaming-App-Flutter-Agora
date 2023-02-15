import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/widgets/appbar.dart';
import 'package:live_streaming/widgets/dialogs/go_live.dart';
import 'package:live_streaming/widgets/dialogs/watch_live.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // To get user data:
  // final user = FirebaseAuth.instance.currentUser;

  List tabs = [
    "Popular",
    "Trending",
    "Music",
    "Gaming",
    "News",
    "Sports",
    "Movies",
    "Fashion",
    "Food",
    "Travel",
  ];
  List<TabItem> bottomBarItems = [
    TabItem(
      icon: Image.asset(
        "assets/images/earth.png",
        color: secondaryThemeColor,
      ),
      title: "Discover",
    ),
    const TabItem(
      icon: Icons.bookmark_border_outlined,
      title: "Favourites",
    ),
    TabItem(
      icon: Container(
        padding: const EdgeInsets.all(14),
        child: Image.asset(
          "assets/images/camera.png",
          height: 32,
        ),
      ),
      title: "",
    ),
    const TabItem(
      icon: Icons.notifications_none_rounded,
      title: "Notification",
    ),
    const TabItem(
      icon: Icons.person_outlined,
      title: "Profile",
    ),
  ];

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Now Streaming"),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(selected == index ? 16 : 20),
                      color: selected == index
                          ? primaryThemeColor
                          : primaryThemeColor.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: MasonryGridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const WatchLiveDialog(),
                      );
                    },
                    child: Container(
                        height: (index % 3 + 3) * 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryThemeColor
                              .withOpacity((index % 3 + 1) * 0.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryThemeColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Live",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryThemeColor.withOpacity(0.4),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "430",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "Let's talk about the new iPhone 12",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ConvexAppBar(
        height: 62,
        backgroundColor: primaryThemeColor,
        disableDefaultTabController: true,
        items: bottomBarItems
            .map((e) => TabItem(
                  title: e.title,
                  icon: e.icon,
                ))
            .toList(),
        top: -20,
        style: TabStyle.fixedCircle,
        curveSize: 90,
        initialActiveIndex: 2,
        activeColor: secondaryThemeColor,
        color: secondaryThemeColor,
        onTap: (index) {
          if (index == 2) {
            // ask for live stream permission
            showDialog(
              context: context,
              builder: (context) => const GoLiveDialog(),
            );
          }
        },
      ),
    );
  }
}
