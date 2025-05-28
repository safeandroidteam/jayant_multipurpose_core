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
    required this.userName,
    required this.custId,
    required this.accId,
    required this.accNo,
    required this.custMobile,
    required this.profileName,
    required this.fullAddress,
    required this.brCode,
    required this.brName,
    required this.ifscCode,
    required this.customerType,
    required this.transDate,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final int? cmpCode;
  final String? userId;
  final String? userName;
  final String? custId;
  final String? accId;
  final String? accNo;
  final String? custMobile;
  final String? profileName;
  final String? fullAddress;
  final String? brCode;
  final String? brName;
  final String? ifscCode;
  final String? customerType;
  final String? transDate;

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      proceedStatus: json["Proceed_Status"],
      proceedMessage: json["Proceed_Message"],
      cmpCode: json["Cmp_Code"],
      userId: json["User_ID"],
      userName: json["User_Name"],
      custId: json["CustID"],
      accId: json["Acc_ID"],
      accNo: json["Acc_No"],
      custMobile: json["Cust_Mobile"],
      profileName: json["ProfileName"],
      fullAddress: json["Full_Address"],
      brCode: json["Br_Code"],
      brName: json["Br_Name"],
      ifscCode: json["IFSC_Code"],
      customerType: json["Customer_Type"],
      transDate: json["Trans_Date"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Proceed_Status": proceedStatus,
    "Proceed_Message": proceedMessage,
    "Cmp_Code": cmpCode,
    "User_ID": userId,
    "User_Name": userName,
    "CustID": custId,
    "Acc_ID": accId,
    "Acc_No": accNo,
    "Cust_Mobile": custMobile,
    "ProfileName": profileName,
    "Full_Address": fullAddress,
    "Br_Code": brCode,
    "Br_Name": brName,
    "IFSC_Code": ifscCode,
    "Customer_Type": customerType,
    "Trans_Date": transDate,
  };
}
