import 'package:xml/xml.dart';

class XMLParse{
  final XmlDocument xml;
  XMLParse(this.xml);


  getCommissionRATIO(){
    const String  xml = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <soap:Body>
        <TP_Ozel_Oran_SK_ListeResponse xmlns="https://turkpos.com.tr/">
            <TP_Ozel_Oran_SK_ListeResult>
                <DT_Bilgi>
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

    final XmlDocument xmlDocument =XmlDocument.parse(xml);
    final result = xmlDocument.document!.children.last.text;    
    //final result = xmlDocument.findAllElements("TP_Ozel_Oran_SK_ListeResult").first.findElements("DT_Bilgi").first.findElements("MO_01");
    print(result.toString());
    //print(result.toXmlString());
    //print(key1!.toXmlString());
    // final key2 = result("SanalPOS_ID");
    // print(key2!.toXmlString());
    
    // final String getCommissionRATIO = key2.getElement("MO_01")!.text;
    // return double.parse(getCommissionRATIO);
   

  }

  getHASH(){
    final result = xml.findAllElements("SHA2B64Response").first;
    String hash = result.getElement("SHA2B64Result")!.text;
    return hash;
  }

  getResult(){
    final result = xml.findAllElements("Pos_OdemeResponse").first.findElements("Pos_OdemeResult").first;
    String ucdURL = result.getElement("UCD_URL")!.text;
    String islemID = result.getElement("Islem_ID")!.text;
    String sonuc = result.getElement("Sonuc")!.text;
    String sonucSTR = result.getElement("Sonuc_Str")!.text;
    String bankaSonucKOD = result.getElement("Banka_Sonuc_Kod")!.text;
    final Map resultMap = {"Islem_ID":islemID, "UCD_URL":ucdURL, "Sonuc": sonuc, "Sonuc_Str": sonucSTR, "Banka_Sonuc_Kod":bankaSonucKOD};
    return resultMap;
  }
}