const functions = require("firebase-functions");
const admin = require("firebase-admin");

// initialize admin , make sure this code is called
admin.initializeApp();

exports.myFunction = functions.firestore
  .document("chat/{message}")
  .onWrite((snapshot, context) => {
    //   this code will print piece of data about fields on chat collection
    // console.log(snapshot.data());

    return admin.messaging().sendToTopic("chat", {
      notification: {
        title: snapshot.data().username,
        body: snapshot.data().text,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
