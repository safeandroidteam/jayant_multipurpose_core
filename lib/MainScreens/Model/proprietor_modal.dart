class ProprietorModel {
  String name;
  String dob;
  String fatherName;
  String motherName;
  String mobile;
  String email;

  ProprietorModel({
    this.name = '',
    this.dob = '',
    this.fatherName = '',
    this.motherName = '',
    this.mobile = '',
    this.email = '',
  });

  Map<String, dynamic> toJson() => {
    "Name": name,
    "DOB": dob,
    "FatherName": fatherName,
    "MotherName": motherName,
    "Mobile": mobile,
    "Email": email,
  };

  String toXml() => '''
<Proprietor>
  <Name>${name}</Name>
  <DOB>${dob}</DOB>
  <FatherName>${fatherName}</FatherName>
  <MotherName>${motherName}</MotherName>
  <Mobile>${mobile}</Mobile>
  <Email>${email}</Email>
</Proprietor>
''';
}
