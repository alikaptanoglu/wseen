importScripts("https://www.gstatic.com/firebasejs/9.6.7/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.7/firebase-messaging-compat.js");

const firebaseConfig = {
    apiKey: "AIzaSyBK0OWp03Vq3TuD5buwPkqPspeM2khLJs0",
    authDomain: "wseen-3f337.firebaseapp.com",
    projectId: "wseen-3f337",
    storageBucket: "wseen-3f337.appspot.com",
    messagingSenderId: "208179421998",
    appId: "1:208179421998:web:745bd28c6c226770cd50bf",
    measurementId: "G-DC1TVJHPDL"
};

firebase.initializeApp(firebaseConfig);

self.addEventListener('notificationclick', function(event) {
    console.log('SW: Clicked notification', event)

    let data = event.notification.data

    event.notification.close()

    self.clients.openWindow(event.notification.data.link)
  })

  self.addEventListener('push', event => {
    let data = {}

    if (event.data) {
      data = event.data.json()
    }

    console.log('SW: Push received', data)

    if (data.notification && data.notification.title) {
      self.registration.showNotification(data.notification.title, {
        body: data.notification.body,
        icon: '/build/web/favicon.png',
        //data:
      })
    } else {
      console.log('SW: No notification payload, not showing notification')
    }
  })




// self.addEventListener('notificationclick', function (event) {
//     console.log('notification received: ', event)
// }); 

// const messaging = firebase.messaging();
// messaging.onBackgroundMessage((payload) => {
// console.log('[firebase-messaging-sw.js] Received background message ', payload);
// const notificationTitle = payload.notification.title;
// const notificationOptions = {body: payload.notification.body};
// return self.registration.showNotification(notificationTitle,
// notificationOptions);
// });

//   const messaging = firebase.messaging();

//   messaging.setBackgroundMessageHandler(function (payload) {
//     const promiseChain = clients
//         .matchAll({
//             type: "window",
//             includeUncontrolled: true
//         })
//         .then(windowClients => {
//             for (let i = 0; i < windowClients.length; i++) {
//                 const windowClient = windowClients[i];
//                 windowClient.postMessage(payload);
//             }
//         })
//         .then(() => {
//             return registration.showNotification("New Message");
//         });
//     return promiseChain;
// });
