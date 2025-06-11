import 'package:xml/xml.dart' as xml;

class AddressModal {
  final String addressType;
  final String houseNoName;
  final String address1;
  final String address2;
  final String cityTownVillage;
  final String pinCode;
  final String country;
  final String state;
  final String district;

  AddressModal({
    required this.addressType,
    required this.houseNoName,
    required this.address1,
    required this.address2,
    required this.cityTownVillage,
    required this.pinCode,
    required this.country,
    required this.state,
    required this.district,
  });

  xml.XmlElement toXml() {
    return xml.XmlElement(xml.XmlName('Data'), [], [
      xml.XmlElement(xml.XmlName('HouseNoName'), [], [
        xml.XmlText(houseNoName.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Add1'), [], [
        xml.XmlText(address1.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Add2'), [], [xml.XmlText(address2)]),
      xml.XmlElement(xml.XmlName('City'), [], [
        xml.XmlText(cityTownVillage.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Pincode'), [], [
        xml.XmlText(pinCode.toString()),
      ]),
      xml.XmlElement(xml.XmlName('Country'), [], [
        xml.XmlText(country.toString()),
      ]),
      xml.XmlElement(xml.XmlName('State'), [], [xml.XmlText(state.toString())]),
      xml.XmlElement(xml.XmlName('District'), [], [
        xml.XmlText(district.toString()),
      ]),
    ]);
  }
}
