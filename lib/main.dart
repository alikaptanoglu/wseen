import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wseen/helpers/xmlparser.dart';
import 'package:wseen/models/homepage.dart';
import 'package:wseen/models/utils.dart';
import 'package:wseen/screens/failed.dart';
import 'package:wseen/screens/lastseen.dart';
import 'package:wseen/screens/main.dart';
import 'package:wseen/screens/onlinechecker.dart';
import 'package:wseen/screens/privacypolicy.dart';
import 'package:wseen/screens/screens.dart';
import 'package:wseen/screens/success.dart';
import 'package:wseen/screens/termsofservice.dart';
import 'package:xml/xml.dart';
import 'providers/providers.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get_ip_address/get_ip_address.dart';

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

  final String xml = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <soap:Body>
        <TP_Ozel_Oran_SK_ListeResponse xmlns="https://turkpos.com.tr/">
            <TP_Ozel_Oran_SK_ListeResult>
                <DT_Bilgi>
                    <xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
                        <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:MainDataTable="DT_Ozel_Oranlar_SK" msdata:UseCurrentLocale="true">
                            <xs:complexType>
                                <xs:choice minOccurs="0" maxOccurs="unbounded">
                                    <xs:element name="DT_Ozel_Oranlar_SK">
                                        <xs:complexType>
                                            <xs:sequence>
                                                <xs:element name="Ozel_Oran_SK_ID" type="xs:long" minOccurs="0" />
                                                <xs:element name="GUID" msdata:DataType="System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" type="xs:string" minOccurs="0" />
                                                <xs:element name="SanalPOS_ID" type="xs:int" minOccurs="0" />
                                                <xs:element name="Kredi_Karti_Banka" type="xs:string" minOccurs="0" />
                                                <xs:element name="Kredi_Karti_Banka_Gorsel" type="xs:string" minOccurs="0" />
                                                <xs:element name="MO_01" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_02" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_03" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_04" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_05" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_06" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_07" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_08" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_09" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_10" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_11" type="xs:decimal" minOccurs="0" />
                                                <xs:element name="MO_12" type="xs:decimal" minOccurs="0" />
                                            </xs:sequence>
                                        </xs:complexType>
                                    </xs:element>
                                </xs:choice>
                            </xs:complexType>
                        </xs:element>
                    </xs:schema>
                    <diffgr:diffgram xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1">
                        <NewDataSet xmlns="">
                            <DT_Ozel_Oranlar_SK diffgr:id="DT_Ozel_Oranlar_SK1" msdata:rowOrder="0">
                                <Ozel_Oran_SK_ID>0</Ozel_Oran_SK_ID>
                                <GUID>0b1c720e-48a6-4b17-bed3-d4163f6a901e</GUID>
                                <SanalPOS_ID>1029</SanalPOS_ID>
                                <Kredi_Karti_Banka>Diğer Banka Kartları</Kredi_Karti_Banka>
                                <Kredi_Karti_Banka_Gorsel>https://param.com.tr/images/banka/diger_kredi_kart.png</Kredi_Karti_Banka_Gorsel>
                                <MO_01>1.7500</MO_01>
                                <MO_02>-2.0000</MO_02>
                                <MO_03>-2.0000</MO_03>
                                <MO_04>-2.0000</MO_04>
                                <MO_05>-2.0000</MO_05>
                                <MO_06>-2.0000</MO_06>
                                <MO_07>-2.0000</MO_07>
                                <MO_08>-2.0000</MO_08>
                                <MO_09>-2.0000</MO_09>
                                <MO_10>-2.0000</MO_10>
                                <MO_11>-2.0000</MO_11>
                                <MO_12>-2.0000</MO_12>
                            </DT_Ozel_Oranlar_SK>
                        </NewDataSet>
                    </diffgr:diffgram>
                </DT_Bilgi>
                <Sonuc>1</Sonuc>
                <Sonuc_Str>Başarılı</Sonuc_Str>
            </TP_Ozel_Oran_SK_ListeResult>
        </TP_Ozel_Oran_SK_ListeResponse>
    </soap:Body>
</soap:Envelope>''';

  @override
  void initState() {
    _getIp();
    _getPermission();
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final XmlDocument xmlDocument = XmlDocument.parse(xml);
    XMLParse(xmlDocument).getCommissionRATIO();
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context) => const Main(),
          '/online-checker':(context) => const OnlineChecker(),
          '/terms':(context) => const TermsOfService(),
          '/privacy-policy':(context) => const PrivacyPolicy(),
          '/last-seen':(context) => const LastSeen(),
          '/sign':(context) => const Sign(),
          '/monitor':(context) => const Monitor(),
          '/monitor/details':(context) => const Details(number: ''),
          '/payment':(context) => const Payment(isFreeTrialOver: true),
          '/payment-success':(context) => const Success(),
          '/payment-failed':(context) => const Failed()
        },
        // initialRoute: RouteGenerator.initialRoute,
        // onGenerateRoute: RouteGenerator.generateRoute,
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
        );
  }

  _getToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  _getIp() async {
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
    if(!mounted) return;
    setState(() {
      
    });
  }
}