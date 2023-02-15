import 'package:flutter/material.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/widgets/dialogs/end_live.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({super.key});
  static const String routeName = "/streaming";

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  bool micOn = true;
  bool cameraOn = true;
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
        ),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text("Live"),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      micOn = !micOn;
                    });
                  },
                  child: Icon(
                    micOn ? Icons.mic_none : Icons.mic_off_outlined,
                    color: micOn
                        ? secondaryThemeColor.withOpacity(0.8)
                        : primaryThemeColor.withOpacity(0.8),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cameraOn = !cameraOn;
                    });
                  },
                  child: Icon(
                    cameraOn
                        ? Icons.videocam_outlined
                        : Icons.videocam_off_outlined,
                    color: cameraOn
                        ? secondaryThemeColor.withOpacity(0.8)
                        : primaryThemeColor.withOpacity(0.8),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const EndLiveDialog(),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryThemeColor,
                    ),
                    child: const Icon(
                      Icons.call_end,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
