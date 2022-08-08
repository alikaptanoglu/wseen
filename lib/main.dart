import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wseen/helpers/routegenerator.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/products/colors.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/screens/main.dart';
import 'providers/providers.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get_ip_address/get_ip_address.dart';

dynamic parsedJson;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBK0OWp03Vq3TuD5buwPkqPspeM2khLJs0",
      authDomain: "wseen-3f337.firebaseapp.com",
      projectId: "wseen-3f337",
      storageBucket: "wseen-3f337.appspot.com",
      messagingSenderId: "208179421998",
      appId: "1:208179421998:web:745bd28c6c226770cd50bf",
      measurementId: "G-DC1TVJHPDL"),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent));
  setPathUrlStrategy();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ModelProvider()),
    ChangeNotifierProvider(create: (context) => MouseProvider()),
    ChangeNotifierProvider(create: (context) => FieldProvider()),
  ], child: const App()));
}

class App extends StatefulWidget {
  
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    getIp();
    _getPermission();
    getToken();
    _initializeRemoteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: RouteGenerator.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Wseen - 🥇 ONLİNE WHATSAPP TRACKER',
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown}),
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {}
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15)  ,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15),
          brightness: Brightness.light,
        ),
        home: parsedJson == null
          ? Scaffold(backgroundColor: const Color.fromARGB(255, 20, 22, 25), body: Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(ProjectColors.themeColorMOD5))))
          : const Main());
  }
  
  Future<void> _initializeRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: const Duration(minutes: 1),minimumFetchInterval: const Duration(minutes: 1)));
    await remoteConfig.fetchAndActivate();
    final messages = remoteConfig.getValue('messages').asString();
    parsedJson = jsonDecode(messages);
    setState(() {
      
    });
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  getIp() async {
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.json);
      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();
    } on IpAddressException catch (exception) {
      /// Handle the exception.
    }
  }

  Future<void> _getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    setState(() {
      
    });
  }
}