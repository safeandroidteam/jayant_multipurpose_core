import 'package:xml/xml.dart' as xml;

class ProprietorModal {
  String name;
  String address;
  String panCardNo;

  ProprietorModal({this.name = '', this.address = '', this.panCardNo = ''});

  xml.XmlElement toXml() {
    return xml.XmlElement(xml.XmlName('Data'), [], [
      xml.XmlElement(xml.XmlName('Name'), [], [xml.XmlText(name.toString())]),
      xml.XmlElement(xml.XmlName('address'), [], [
        xml.XmlText(address.toString()),
      ]),
      xml.XmlElement(xml.XmlName('panCardNo'), [], [
        xml.XmlText(panCardNo.toString()),
      ]),
    ]);
  }
}
