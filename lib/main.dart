import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'constants.dart';

// final navigatorKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    Firebase.initializeApp().then((value) {
      log("initializeApp");
      runApp(MyApp(navigatorKey: navigatorKey));
    });
  });
}

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appID,
      appSign: appSign,
      userID: "123",
      userName: "Umair",
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Call App"),
        ),
        body: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CallButtonWidget(
                isVideoCall: false,
              ),
              CallButtonWidget(
                isVideoCall: true,
              )
            ],
          ),
        ));
  }
}

class CallButtonWidget extends StatelessWidget {
  final bool isVideoCall;
  const CallButtonWidget({
    super.key,
    required this.isVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideoCall,
      verticalLayout: true,
      resourceID: "zego_resource_id_example",
      invitees: [
        ZegoUIKitUser(
          id: "789",
          name: "Wajid",
        ),

        // ZegoUIKitUser(
        //   id: "222",
        //   name: "ikram",
        // )
      ],
    );
  }
}
