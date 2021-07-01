importScripts("https://www.gstatic.com/firebasejs/8.6.8/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.8/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDUqJPl8f00UuBUViRoPQ4FQzBQLYipQME",
  authDomain: "aurask-ca6bb.firebaseapp.com",
  projectId: "aurask-ca6bb",
  storageBucket: "aurask-ca6bb.appspot.com",
  messagingSenderId: "491094163637",
  appId: "1:491094163637:web:3ad248f8504680fb363efc",
  measurementId: "G-0SGCK0SSZC"
});
// For Firebase JS SDK v7.20.0 and later, measurementId is optional


const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});