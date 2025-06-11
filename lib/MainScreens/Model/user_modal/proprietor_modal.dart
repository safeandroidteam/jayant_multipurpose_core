import 'package:xml/xml.dart';

class ProprietorModal {
  String name;
  String address;
  String panCardNo;

  ProprietorModal({this.name = '', this.address = '', this.panCardNo = ''});

  XmlElement toXmlElement() {
    final builder = XmlBuilder();
    builder.element(
      'Proprietor',
      nest: () {
        builder.element('Name', nest: name);
        builder.element('Address', nest: address);
        builder.element('PanCardNo', nest: panCardNo);
      },
    );
    return builder.buildDocument().rootElement;
  }
}
