// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:wseen/helpers/xmlparser.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class XMLPayment{
  // final String CLIENT_CODE = '48921';
  // final String CLIENT_USERNAME = 'TP10080962';
  // final String CLIENT_PASSWORD = 'F450DB4A74318115';
  // final String GUID = '0B1C720E-48A6-4B17-BED3-D4163F6A901E';
  final String CLIENT_CODE = '10738';
  final String CLIENT_USERNAME = 'Test';
  final String CLIENT_PASSWORD = 'Test';
  final String GUID = '0c13d406-873b-403b-9c09-a5766840d98c';
  final String KK_Sahibi;
  final String KK_No;
  final String KK_SK_Ay;
  final String KK_SK_Yil;
  final String KK_CVC;
  final String KK_Sahibi_GSM = '';
  final String Hata_URL = 'https://www.w-seen.com/success/';
  final String Basarili_URL = 'https://www.facebook.com';
  final String Siparis_ID;
  final String Siparis_Aciklama = '';
  final String Taksit = '1';
  final String Islem_Tutar = '10,00';
  final String Toplam_Tutar = '10,35';
  final String Islem_Guvenlik_Tip = '3D';
  final String Islem_ID;
  final String IPAdr = '199.36.158.100';
  final String Ref_URL = 'www.facebook.com'; 
  late String Islem_Hash;

  XMLPayment(this.KK_Sahibi, this.KK_No, this.KK_SK_Ay, this.KK_SK_Yil, this.KK_CVC, this.Islem_ID, this.Siparis_ID);

  request() async {

    Uri paymentURL = Uri.parse('https://test-dmz.param.com.tr:4443/turkpos.ws/service_turkpos_test.asmx?wsdl');
    //Uri paymentURL = Uri.parse('https://posws.param.com.tr/turkpos.ws/service_turkpos_prod.asmx?wsdl');
    final String SHA2B64 = CLIENT_CODE + GUID + Taksit + Islem_Tutar + Toplam_Tutar + Siparis_ID + Hata_URL + Basarili_URL;

    final requestXMLSHA2B64 = '''<?xml version="1.0" encoding="utf-8"?> <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body>
    <SHA2B64 xmlns="https://turkpos.com.tr/">
    <Data>$SHA2B64</Data>
    </SHA2B64>
    </soap:Body>
    </soap:Envelope>''';

    final responseSHA2B64 = await http.post(paymentURL, body: requestXMLSHA2B64, headers: {"Content-Type": "text/xml", "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD"});
    final XmlDocument responseSHA2B64XML = XmlDocument.parse(responseSHA2B64.body);
    Islem_Hash = XMLParse(responseSHA2B64XML).getHASH();

    final requestKOM = '''<?xml version="1.0" encoding="utf-8"?> <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body>
    <TP_Ozel_Oran_SK_Liste xmlns="https://turkpos.com.tr/">
    <G>
    <CLIENT_CODE>$CLIENT_CODE</CLIENT_CODE>
    <CLIENT_USERNAME>$CLIENT_USERNAME</CLIENT_USERNAME>
    <CLIENT_PASSWORD>$CLIENT_PASSWORD</CLIENT_PASSWORD>
    </G>
    <GUID>$GUID</GUID>
    </TP_Ozel_Oran_SK_Liste>
    </soap:Body>
    </soap:Envelope>
    ''';

    final responseKOM = await http.post(paymentURL, body: requestKOM, headers: {"Content-Type": "text/xml", "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD"});
    final XmlDocument responseKOMXML = XmlDocument.parse(responseKOM.body);
    XMLParse(responseKOMXML).getCommissionRATIO();

    final requestXMLPayment = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
    <Pos_Odeme xmlns="https://turkpos.com.tr/">
    <G>
    <CLIENT_CODE>$CLIENT_CODE</CLIENT_CODE>
    <CLIENT_USERNAME>$CLIENT_USERNAME</CLIENT_USERNAME>
    <CLIENT_PASSWORD>$CLIENT_PASSWORD</CLIENT_PASSWORD>
    </G>
    <GUID>$GUID</GUID>
    <KK_Sahibi>$KK_Sahibi</KK_Sahibi>
    <KK_No>$KK_No</KK_No>
    <KK_SK_Ay>$KK_SK_Ay</KK_SK_Ay>
    <KK_SK_Yil>$KK_SK_Yil</KK_SK_Yil>
    <KK_CVC>$KK_CVC</KK_CVC>
    <KK_Sahibi_GSM>$KK_Sahibi_GSM</KK_Sahibi_GSM>
    <Hata_URL>$Hata_URL</Hata_URL>
    <Basarili_URL>$Basarili_URL</Basarili_URL>
    <Siparis_ID>$Siparis_ID</Siparis_ID>
    <Siparis_Aciklama>$Siparis_Aciklama</Siparis_Aciklama>
    <Taksit>$Taksit</Taksit>
    <Islem_Tutar>$Islem_Tutar</Islem_Tutar>
    <Toplam_Tutar>$Toplam_Tutar</Toplam_Tutar>
    <Islem_Hash>$Islem_Hash</Islem_Hash>
    <Islem_Guvenlik_Tip>$Islem_Guvenlik_Tip</Islem_Guvenlik_Tip>
    <Islem_ID>$Islem_ID</Islem_ID>
    <IPAdr>$IPAdr</IPAdr>
    <Ref_URL>$Ref_URL</Ref_URL>
    <Data1></Data1>
    <Data2></Data2>
    <Data3></Data3>
    <Data4></Data4>
    <Data5></Data5>
    <Data6></Data6>
    <Data7></Data7>
    <Data8></Data8>
    <Data9></Data9>
    <Data10></Data10>
    </Pos_Odeme>
    </soap:Body>
    </soap:Envelope>
    ''';

    final responsePayment = await http.post(paymentURL, body: requestXMLPayment, headers: {"Content-Type": "text/xml", "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD"});
    final XmlDocument responsePaymentXML = XmlDocument.parse(responsePayment.body);
    final Map resultMap = XMLParse(responsePaymentXML).getResult();
    return resultMap;
  }
}







