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
  rNickName= TextEditingController(),
      rMob = TextEditingController(),
      ifsc = TextEditingController(),
      accNo = TextEditingController(),
      bankName = TextEditingController(),
      bankAddress = TextEditingController();
  bool rNameVal = false,
  rNickNameVal= false,
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
        rNickName.text.isNotEmpty&&
        rMob.text.isNotEmpty &&
        ifsc.text.isNotEmpty &&
        accNo.text.isNotEmpty &&
        bankName.text.isNotEmpty &&
        bankAddress.text.isNotEmpty) {
      print("TRUE ::::");
      Map<String, String> params = {
        "Cmp_Code": preference!.getString(StaticValues.cmpCodeKey)??"",
        // "Cust_ID": "1139",
        "Cust_ID": preference!.getString(StaticValues.custID)??"",
        "Beni_Accno": accNo.text,
        "Beni_NickName": rNickName.text,
        "Beni_AccountHolderName": rName.text,
        "Mobile_No": rMob.text,
        "IFSC_Code": ifsc.text,
        "Bank_Name": bankName.text,
        "Bank_Address": bankAddress.text,
        "User_ID": preference.getString(StaticValues.userID)??""
      };
      try {
        // _isLoading = true;
        final response = await (RestAPI().post(APis.saveBeneficiary,params: params));
        _isLoading = true;
        String proceedStatus = response["ProceedStatus"];
        String proceedMessage = response["Data"][0]["Proceed_Message"];
        GlobalWidgets().showSnackBar(context, proceedMessage);
        if (proceedStatus == "Y") {
          Navigator.of(context).pop(true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FundTransfer()),
          );
          _isLoading = false;
        }
        _isLoading = false;
      } on RestException catch (e) {
        _isLoading = false;
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
                  controller: rNickName,
                  hint: "Enter Receiver Nickname",
                  errorText: rNickNameVal ? "Nick Name is invalid" : null,
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    setState(() {
                      rNickNameVal = value.trim().length < 3;
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
                      bankName.clear();
                      bankAddress.clear();
                      strBankName = "";
                    });
                  },
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strBankName!,
                      style: TextStyle(color: Colors.green, fontSize: 16.0),
                    ),
                    InkWell(
                      onTap: () async {
                        if (ifsc.text.trim().isEmpty || ifsc.text.trim().length != 11) {
                          Fluttertoast.showToast(msg: "Please enter valid IFSC");
                          return;
                        }

                        try {
                          var response = await RestAPI().post(
                            APis.fetchBeneficiaryBankDetails,
                            params: {"IFSC_Code": ifsc.text.trim()},
                          );

                          if (response["ProceedStatus"] == "Y") {
                            var data = response["Data"][0];
                            String bank = data["Bnk_Name"];
                            String address = data["Br_District"];

                            setState(() {
                              strBankName = bank;
                              bankName.text = bank;
                              bankAddress.text = address;
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: response["ProceedMessage"] ?? "Bank not found",
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                            );
                          }
                        } catch (e) {
                          debugPrint("Error: $e");
                          Fluttertoast.showToast(
                            msg: "Failed to fetch bank details",
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                          );
                        }
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
                  _isLoading
                      ? "Loading"
                      : "Add Beneficiary",
              onPressed: () async {
                if (rName.text.isNotEmpty &&
                    rMob.text.isNotEmpty &&
                    ifsc.text.isNotEmpty &&
                    accNo.text.isNotEmpty &&
                    bankName.text.isNotEmpty &&
                    bankAddress.text.isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                  });
                  addBeneficiary();
                  // var response = await RestAPI().post(
                  //   APis.GenerateOTP,
                  //   params: {
                  //     "MobileNo": mobileNo,
                  //     // "MobileNo": "7904308386",
                  //     "Amt": "0",
                  //     "SMS_Module": "GENERAL",
                  //     "SMS_Type": "GENERAL_OTP",
                  //     "OTP_Return": "Y",
                  //   },
                  // );

                  // print("rechargeResponse::: $response");
                  // str_Otp = response[0]["OTP"];
                  //
                  // setState(() {
                  //   otpLoading = false;
                  //   Timer(Duration(minutes: 5), () {
                  //     setState(() {
                  //       str_Otp = "";
                  //     });
                  //   });
                  // });

                 // _beneficiaryConfirmation();
                } else {
                  print("FALSE ::::");
                  GlobalWidgets().showSnackBar(
                    context,
                    "All fields are mandatory",
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
