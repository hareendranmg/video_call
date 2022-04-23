import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller.channelTextController,
            decoration: InputDecoration(
              labelText: 'Channel Name',
            ),
          ),
          ElevatedButton(
            onPressed: controller.joinChannel,
            child: Text('Join Channel'),
          )
        ],
      ),
    );
  }
}
