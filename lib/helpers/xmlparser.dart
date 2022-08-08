import 'package:xml/xml.dart';

class XMLParse{
  final XmlDocument xml;
  XMLParse(this.xml);


  getCommissionRATIO(){
    print(xml.toXmlString());
   

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