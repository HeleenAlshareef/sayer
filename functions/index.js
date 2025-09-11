const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotificationOnNewCarSuggestion = functions.firestore
  .document("SuggestionCars/{docId}")
  .onCreate(async (snap, context) => {
    const orderData = snap.data();

    const payload = {
      notification: {
        title: "طلب جديد",
        body: `المصدر: ${orderData.formWhere || "غير معروف"}`,
      },
      token: "dDqNB1Rl10pbo4Mu5JuLxL:APA91bHqRVscyLyXrDiUvBCGrnDixLsztgEo7IiwLmGh3JzcWF4JoexTENi41r2qG6Ck5RTml8lTsU_FQo68yU1bIeWdCc4uizdtP0jAlXzy8SS6z67Sa4s", // Device FCM token for test device
    };

    try {
      const response = await admin.messaging().send(payload);
      console.log("تم إرسال الإشعار:", response);
    } catch (error) {
      console.error("فشل إرسال الإشعار:", error);
    }
  });
