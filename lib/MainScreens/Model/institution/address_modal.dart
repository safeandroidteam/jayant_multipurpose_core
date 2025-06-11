import 'package:xml/xml.dart' as xml;

class InstitutionAddressModal {
  final String add1;
  final String add2;
  final String add3;
  final String cityTownVillage;
  final String taluk;
  final String district;
  final String state;
  final String country;
  final String pinCode;

  InstitutionAddressModal(
    this.add1,
    this.add2,
    this.add3,
    this.cityTownVillage,
    this.taluk,
    this.district,
    this.state,
    this.country,
    this.pinCode,
  );

  xml.XmlElement toXml() {
    return xml.XmlElement(xml.XmlName('Data'), [], [
      xml.XmlElement(xml.XmlName('Add1'), [], [xml.XmlText(add1.toString())]),
      xml.XmlElement(xml.XmlName('Add2'), [], [xml.XmlText(add2.toString())]),
      xml.XmlElement(xml.XmlName('Add3'), [], [xml.XmlText(add3)]),
      xml.XmlElement(xml.XmlName('City'), [], [
        xml.XmlText(cityTownVillage.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Taluk'), [], [xml.XmlText(taluk.toString())]),
      xml.XmlElement(xml.XmlName('District'), [], [
        xml.XmlText(district.toString()),
      ]),
      xml.XmlElement(xml.XmlName('State'), [], [xml.XmlText(state.toString())]),
      xml.XmlElement(xml.XmlName('Country'), [], [
        xml.XmlText(country.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Pincode'), [], [
        xml.XmlText(pinCode.toString()),
      ]),
    ]);
  }
}
