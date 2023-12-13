import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/config/app_id.dart';
import 'package:live_streaming/controllers/setup_controller.dart';
import 'package:live_streaming/controllers/stream_controller.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:live_streaming/widgets/dialogs/end_live.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'home.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen(
      {super.key, required this.isBroadcaster, required this.channelId});
  static const String routeName = "/streaming";
  final bool isBroadcaster;
  final String channelId;

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  bool micOn = true;
  bool cameraOn = true;
  late final RtcEngine _engine;
  List<int> remoteUids = [];

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    //create the engine
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();

    //enable video
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }

    //join channel
    _joinChannel();
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint('joinChannelSuccess $channel $uid $elapsed');
      },
      userJoined: (uid, elapsed) {
        debugPrint('userJoined $uid $elapsed');
        setState(() {
          remoteUids.add(uid);
        });
      },
      userOffline: (uid, reason) {
        debugPrint('userOffline $uid $reason');
        setState(() {
          remoteUids.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        debugPrint('leaveChannel $stats');
        setState(() {
          remoteUids.clear();
        });
      },
      // tokenPrivilegeWillExpire: (token) async {
      //   await getToken();
      //   await _engine.renewToken(token);
      // }
    ));
  }

  void _joinChannel() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    await _engine.joinChannelWithUserAccount(
      tempToken,
      widget.channelId,
      SetupController().user.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _leaveChannel();
        return Future.value(true);
      },
      child: Scaffold(
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
            _renderVideo(),
            Positioned(
              right: 20,
              bottom: 40,
              child: Column(
                children: [
                  // mic button
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
                  // camera button
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
                  // leave live button
                  GestureDetector(
                    onTap: () async {
                      await _leaveChannel();
                      return Future.value();
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
      ),
    );
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    if ("${SetupController().user.uid}${SetupController().user.username}" ==
        widget.channelId) {
      showDialog(
        context: context,
        builder: (context) => EndLiveDialog(channelId: widget.channelId),
      );
    } else {
      await StreamController().updateViewCount(widget.channelId, false);
    }
    Get.offNamed(HomeScreen.routeName);
  }

  _renderVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child:
          "${SetupController().user.uid}${SetupController().user.username}" ==
                  widget.channelId
              ? const RtcLocalView.SurfaceView(
                  zOrderMediaOverlay: true,
                  zOrderOnTop: true,
                )
              : remoteUids.isNotEmpty
                  ? RtcRemoteView.TextureView(
                      uid: remoteUids[0],
                      channelId: widget.channelId,
                    )
                  : Container(),
    );
  }
}
