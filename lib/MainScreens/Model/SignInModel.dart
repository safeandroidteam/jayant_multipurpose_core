class SignInModel {
  SignInModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final List<SignInData> data;

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      proceedStatus: json["ProceedStatus"],
      proceedMessage: json["ProceedMessage"],
      data:
          json["Data"] == null
              ? []
              : List<SignInData>.from(
                json["Data"]!.map((x) => SignInData.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": data.map((x) => x?.toJson()).toList(),
  };
}

class SignInData {
  SignInData({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.cmpCode,
    required this.userId,
    required this.custId,
    required this.userName,
    required this.profileName,
    required this.fullAddress,
    required this.brCode,
    required this.brName,
    required this.customerType,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final int? cmpCode;
  final String? userId;
  final String? custId;
  final String? userName;
  final String? profileName;
  final String? fullAddress;
  final String? brCode;
  final String? brName;
  final String? customerType;

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      proceedStatus: json["Proceed_Status"],
      proceedMessage: json["Proceed_Message"],
      cmpCode: json["Cmp_Code"],
      userId: json["User_ID"],
      custId: json["CustID"],
      userName: json["User_Name"],
      profileName: json["ProfileName"],
      fullAddress: json["Full_Address"],
      brCode: json["Br_Code"],
      brName: json["Br_Name"],
      customerType: json["Customer_Type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Proceed_Status": proceedStatus,
    "Proceed_Message": proceedMessage,
    "Cmp_Code": cmpCode,
    "User_ID": userId,
    "CustID": custId,
    "User_Name": userName,
    "ProfileName": profileName,
    "Full_Address": fullAddress,
    "Br_Code": brCode,
    "Br_Name": brName,
    "Customer_Type": customerType,
  };
}
