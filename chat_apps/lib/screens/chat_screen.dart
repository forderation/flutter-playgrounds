import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    // above code is need for ask permission on IOS
    fbm.configure(onMessage: (msg) {
      // todo
      return;
    }, onLaunch: (msg) {
      // todo
      return;
    }, onResume: (msg) {
      // todo
      return;
    });

    // subscribe to some fcm topic, that already define on cloud function code
    fbm.subscribeToTopic('chat');

    // this code get token from fcm so this can be used to send notification
    // fbm.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Chat'), actions: [
        DropdownButton(
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          items: [
            DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ))
          ],
          icon: Icon(Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color),
        )
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
