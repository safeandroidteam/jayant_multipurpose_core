import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/FundTransfer.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Beneficiary extends StatefulWidget {
  @override
  _BeneficiaryState createState() => _BeneficiaryState();
}

class _BeneficiaryState extends State<Beneficiary> {
  TextEditingController rName = TextEditingController(),
      rMob = TextEditingController(),
      ifsc = TextEditingController(),
      accNo = TextEditingController(),
      bankName = TextEditingController(),
      bankAddress = TextEditingController();
  bool rNameVal = false,
      rMobVal = false,
      ifscVal = false,
      accNoVal = false,
      bankNameVal = false,
      bankAddressVal = false,
      addBeneficbool = false,
      otpLoading = false;
  String? mobileNo, str_Otp, strBankName = "";

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _isLoading = false;
  var isLoading = false;

  TextInputType changeKeyboardAppearence() {
    return ifsc.text.length < 5 ? TextInputType.text : TextInputType.number;
  }

  SharedPreferences? preferences = StaticValues.sharedPreferences;

  @override
  void setState(VoidCallback fn) {
    mobileNo = preferences?.getString(StaticValues.mobileNo) ?? "";
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _beneficiaryConfirmation() {
    isLoading = false;
    var _pass;
    GlobalWidgets().validateOTP(
      context,
      getValue: (passVal) {
        setState(() {
          _pass = passVal;
        });
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [TextView(text: "Enter OTP", size: 24.0), SizedBox(height: 10.0)],
      ),
      actionButton: StatefulBuilder(
        builder:
            (context, setState) => CustomRaisedButton(
              loadingValue: isLoading,
              buttonText:
                  isLoading
                      ? CircularProgressIndicator() as String
                      : "Add Beneficiary",
              onPressed:
                  isLoading
                      ? () {}
                      : () async {
                        if (_pass == str_Otp) {
                          addBeneficiary();
                        } else {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: "OTP Miss match",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
            ),
      ),
    );
  }

  Future<void> addBeneficiary() async {
    SharedPreferences? preference = StaticValues.sharedPreferences;
    if (rName.text.isNotEmpty &&
        rMob.text.isNotEmpty &&
        ifsc.text.isNotEmpty &&
        accNo.text.isNotEmpty &&
        bankName.text.isNotEmpty &&
        bankAddress.text.isNotEmpty) {
      print("TRUE ::::");
      Map<String, String> params = {
        "CustId": "${preference!.getString(StaticValues.custID)}",
        "reciever_name": rName.text,
        "reciever_mob": rMob.text,
        "reciever_ifsc": ifsc.text,
        "reciever_Accno": accNo.text,
        "BankName": bankName.text,
        "Receiver_Address": bankAddress.text,
      };
      try {
        _isLoading = true;
        Map response = await (RestAPI().get(APis.addBeneficiary(params)));
        _isLoading = true;
        String status = response["Table"][0]["status"];
        GlobalWidgets().showSnackBar(context, status);
        if (status == "Success") {
          Navigator.of(context).pop(true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FundTransfer()),
          );
        }
      } on RestException catch (e) {
        print(e.toString());
        GlobalWidgets().showSnackBar(context, "Something went wrong");
      }
    } else {
      print("FALSE ::::");
      GlobalWidgets().showSnackBar(context, "All fields are mandatory");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Beneficiary", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                EditTextBordered(
                  controller: rName,
                  hint: "Enter Receiver Name",
                  errorText: rNameVal ? "Name is invalid" : null,
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    setState(() {
                      rNameVal = value.trim().length < 3;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: rName,
                  hint: "Enter Receiver Nickname",
                  errorText: rNameVal ? "Name is invalid" : null,
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    setState(() {
                      rNameVal = value.trim().length < 3;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: rMob,
                  hint: "Enter Receiver Mobile no.",
                  keyboardType: TextInputType.number,
                  errorText: rMobVal ? "Number is invalid" : null,
                  onChange: (value) {
                    setState(() {
                      rMobVal = value.trim().length != 10;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: ifsc,
                  hint: "Enter IFSC",
                  keyboardType: changeKeyboardAppearence(),
                  errorText: ifscVal ? "IFSC is invalid" : null,
                  textCapitalization: TextCapitalization.characters,
                  onChange: (value) {
                    setState(() {
                      ifscVal = value.trim().length != 11;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strBankName!,
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                    InkWell(
                      onTap: () async {
                        var response = await RestAPI().post(
                          APis.getBeniBankDetails,
                          params: {"IfscCode": ifsc.text},
                        );

                        setState(() {
                          strBankName = response[0]["BeniBnkName"];
                        });

                        print("BANKNAME : $strBankName");

                        return;
                      },
                      child: Text(
                        "Check",
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: accNo,
                  hint: "Enter Account no.",
                  keyboardType: TextInputType.number,
                  errorText: accNoVal ? "Account number is invalid" : null,
                  onChange: (value) {
                    setState(() {
                      accNoVal = value.trim().length < 8;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: bankName,
                  hint: "Enter Bank Name",
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  errorText: bankNameVal ? "Bank Name is invalid" : null,
                  onChange: (value) {
                    setState(() {
                      bankNameVal = value.trim().length <= 0;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                EditTextBordered(
                  controller: bankAddress,
                  hint: "Enter Bank Address",
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  errorText: bankAddressVal ? "Bank Address is invalid" : null,
                  onChange: (value) {
                    setState(() {
                      bankAddressVal = value.trim().length <= 0;
                    });
                  },
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: CustomRaisedButton(
              loadingValue: _isLoading,
              buttonText:
                  otpLoading
                      ? CircularProgressIndicator() as String
                      : "Add Beneficiary",
              onPressed: () async {
                otpLoading = true;
                if (rName.text.isNotEmpty &&
                    rMob.text.isNotEmpty &&
                    ifsc.text.isNotEmpty &&
                    accNo.text.isNotEmpty &&
                    bankName.text.isNotEmpty &&
                    bankAddress.text.isNotEmpty) {
                  var response = await RestAPI().post(
                    APis.GenerateOTP,
                    params: {
                      "MobileNo": mobileNo,
                      // "MobileNo": "7904308386",
                      "Amt": "0",
                      "SMS_Module": "GENERAL",
                      "SMS_Type": "GENERAL_OTP",
                      "OTP_Return": "Y",
                    },
                  );

                  print("rechargeResponse::: $response");
                  str_Otp = response[0]["OTP"];

                  setState(() {
                    otpLoading = false;
                    Timer(Duration(minutes: 5), () {
                      setState(() {
                        str_Otp = "";
                      });
                    });
                  });

                  _beneficiaryConfirmation();
                } else {
                  print("FALSE ::::");
                  GlobalWidgets().showSnackBar(
                    context,
                    "All fields are mandatory",
                  );
                }

                /*           SharedPreferences preference = StaticValues.sharedPreferences;
                if (rName.text.isNotEmpty &&
                    rMob.text.isNotEmpty &&
                    ifsc.text.isNotEmpty &&
                    accNo.text.isNotEmpty &&
                    bankName.text.isNotEmpty &&
                    bankAddress.text.isNotEmpty) {
                  print("TRUE ::::");
                  Map<String, String> params = {
                    "CustId": preference.getString(StaticValues.custID),
                    "reciever_name": rName.text,
                    "reciever_mob": rMob.text,
                    "reciever_ifsc": ifsc.text,
                    "reciever_Accno": accNo.text,
                    "BankName": bankName.text,
                    "Receiver_Address": bankAddress.text
                  };
                  try {
	                  _isLoading = true;
                    Map response = await RestAPI().get(APis.addBeneficiary(params));
	                  _isLoading = true;
                    String status =  response["Table"][0]["status"];
                    GlobalWidgets().showSnackBar(_scaffoldKey, status);
                    if(status == "Success"){
                      Navigator.of(context).pop(true);
                    }
                  } on RestException catch (e) {
                    print(e.toString());
                    GlobalWidgets().showSnackBar(_scaffoldKey, "Something went wrong");
                  }
                } else {
                  print("FALSE ::::");
                  GlobalWidgets().showSnackBar(_scaffoldKey, "All fields are mandatory");
                }*/
              },
            ),
          ),
        ],
      ),
    );
  }
}
