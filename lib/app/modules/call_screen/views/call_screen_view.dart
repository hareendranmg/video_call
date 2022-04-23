import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/call_screen_controller.dart';

class CallScreenView extends GetView<CallScreenController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(client: controller.client),
              AgoraVideoButtons(client: controller.client)
            ],
          ),
        ),
      ),
    );
  }
}
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: GetBuilder<CallScreenController>(
  //       builder: (_) {
  //         return SafeArea(
  //           child: Stack(
  //             children: [
  //               Center(
  //                 child: _.switched
  //                     ? _.renderRemoteVideo()
  //                     : _.renderLocalPreview(),
  //               ),
  //               Align(
  //                 alignment: Alignment.topLeft,
  //                 child: Container(
  //                   width: 100,
  //                   height: 100,
  //                   color: Colors.blue,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       _.switched = !_.switched;
  //                     },
  //                     child: Center(
  //                       child: _.switched
  //                           ? _.renderLocalPreview()
  //                           : _.renderRemoteVideo(),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: ElevatedButton(
  //                     onPressed: _.endCall, child: Text('End Call')),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
