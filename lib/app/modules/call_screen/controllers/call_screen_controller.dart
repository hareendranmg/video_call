import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/app/config/constants.dart';

import '../../../routes/app_pages.dart';

class CallScreenController extends GetxController {
  late final String token;
  late final String channel;
  late final int uid;

  late final RtcEngine engine;
  late final AgoraClient client;

  bool _joined = false;
  bool get joined => _joined;
  set joined(bool joined) => {_joined = joined, update()};
  int _remoteUid = 0;
  int get remoteUid => _remoteUid;
  set remoteUid(int remoteUid) => {_remoteUid = remoteUid, update()};
  bool _switched = false;
  bool get switched => _switched;
  set switched(bool switched) => {_switched = switched, update()};

  @override
  void onInit() {
    token = Get.arguments['token'] as String;
    channel = Get.arguments['channel'] as String;
    uid = Get.arguments['uid'] as int;
    // initializeCall();

    client = AgoraClient(
      agoraConnectionData:
          AgoraConnectionData(appId: APP_ID, channelName: channel, uid: uid),
      enabledPermission: [Permission.camera, Permission.microphone],
    );

    super.onInit();
  }

  Future<void> initializeCall() async {
    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          joined = true;
        },
        userJoined: (int uid, int elapsed) {
          print('userJoined ${uid}');
          remoteUid = uid;
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline ${uid}');
          remoteUid = 0;
        },
      ),
    );
    // Enable video
    await engine.enableVideo();
    // Join channel with channel name as 123
    await engine.joinChannel(token, channel, null, uid);
    update();
  }

  Future<void> endCall() async {
    await engine.leaveChannel();
    await engine.destroy();
    Get.offNamed(Routes.HOME);
  }

  // Local preview
  Widget renderLocalPreview() {
    if (joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
  Widget renderRemoteVideo() {
    if (remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: remoteUid,
        channelId: channel,
      );
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
