import 'package:xml/xml.dart' as xml;

class ProprietorModal {
  String name;
  String address;
  String panCardNo;

  ProprietorModal({this.name = '', this.address = '', this.panCardNo = ''});

  xml.XmlElement toXml() {
    return xml.XmlElement(xml.XmlName('Data'), [], [
      xml.XmlElement(xml.XmlName('Own_OperName'), [], [
        xml.XmlText(name.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Own_OperAdd'), [], [
        xml.XmlText(address.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Own_Pan'), [], [
        xml.XmlText(panCardNo.toString()),
      ]),
    ]);
  }
}
