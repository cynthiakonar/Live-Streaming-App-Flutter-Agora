import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/utils/colors.dart';

class WatchLiveScreen extends StatefulWidget {
  const WatchLiveScreen({super.key});
  static const String routeName = "/watch_live";

  @override
  State<WatchLiveScreen> createState() => _WatchLiveScreenState();
}

class _WatchLiveScreenState extends State<WatchLiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // show image in background when camera off
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 5,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: primaryThemeColor,
                                width: 3,
                              ),
                            ),
                          ),
                          child: const SizedBox(width: 60),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 11,
                          left: 11,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: primaryThemeColor,
                            ),
                            child: const Center(
                              child: Text(
                                "LIVE",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Cynthia Konar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: secondaryThemeColor.withOpacity(0.6),
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "400",
                              style: TextStyle(
                                color: secondaryThemeColor.withOpacity(0.6),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryThemeColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    splashRadius: 0.1,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: bgColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          )),
      body: const Center(
        child: Text("Live"),
      ),
    );
  }
}
