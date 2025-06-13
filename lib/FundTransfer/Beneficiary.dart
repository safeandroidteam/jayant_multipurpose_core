import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/FundTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/bloc.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Beneficiary extends StatefulWidget {
  final bool isEdit;
  final String? beneficiaryId;

  const Beneficiary({super.key, required this.isEdit, this.beneficiaryId});
  @override
  _BeneficiaryState createState() => _BeneficiaryState();
}

class _BeneficiaryState extends State<Beneficiary> {
  TextEditingController rName = TextEditingController(),
      rNickName = TextEditingController(),
      rMob = TextEditingController(),
      ifsc = TextEditingController(),
      accNo = TextEditingController(),
      bankName = TextEditingController(),
      bankAddress = TextEditingController();
  bool rNameVal = false,
      rNickNameVal = false,
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
    super.setState(fn);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final preference = StaticValues.sharedPreferences;
      final transferBloc = TransferBloc.get(context);
      if (widget.isEdit == true) {
        transferBloc.add(
          FetchBeneficiaryToUpdateevent(
            preference!.getString(StaticValues.cmpCodeKey) ?? "",
            preference.getString(StaticValues.custID) ?? "",
            widget.beneficiaryId ?? "",
          ),
        );
      }
    });
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
        children: [
          TextView(text: "Enter OTP", size: 24.0),
          SizedBox(height: 10.0),
        ],
      ),
      actionButton: StatefulBuilder(
        builder:
            (context, setState) => CustomRaisedButton(
          loadingValue: isLoading,
          buttonText: isLoading
              ? CircularProgressIndicator() as String
              : "Add Beneficiary",
          onPressed: isLoading
              ? () {}
              : () async {
            if (_pass == str_Otp) {
              submitBeneficiary();
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

  Future<void> submitBeneficiary() async {
    SharedPreferences? preference = StaticValues.sharedPreferences;

    if (rName.text.isNotEmpty &&
        rNickName.text.isNotEmpty &&
        rMob.text.isNotEmpty &&
        ifsc.text.isNotEmpty &&
        accNo.text.isNotEmpty &&
        bankName.text.isNotEmpty &&
        bankAddress.text.isNotEmpty) {
      Map<String, String> params = {
        "Cmp_Code": preference!.getString(StaticValues.cmpCodeKey) ?? "",
        "Cust_ID": preference.getString(StaticValues.custID) ?? "",
        "Beni_Accno": accNo.text,
        "Beni_NickName": rNickName.text,
        "Beni_AccountHolderName": rName.text,
        "Mobile_No": rMob.text,
        "IFSC_Code": ifsc.text,
        "Bank_Name": bankName.text,
        "Bank_Address": bankAddress.text,
        "User_ID": preference.getString(StaticValues.userID) ?? "",
      };

      // Add Beneficiary_ID only when updating
      if (widget.isEdit) {
        params["Beneficiary_ID"] = widget.beneficiaryId ?? "";
      }

      try {
        final response = await RestAPI().post(
          widget.isEdit ? APis.updateBeneficiary : APis.saveBeneficiary,
          params: params,
        );

        String proceedStatus = response["ProceedStatus"];
        String proceedMessage = response["Data"][0]["Proceed_Message"];

        GlobalWidgets().showSnackBar(context, proceedMessage);

        if (proceedStatus == "Y") {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FundTransfer()),
            );
          });
        }

        setState(() {
          _isLoading = false;
        });
      } on RestException catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e.toString());
        GlobalWidgets().showSnackBar(context, "Something went wrong");
      }
    } else {
      GlobalWidgets().showSnackBar(context, "All fields are mandatory");
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final h= MediaQuery.of(context).size.height;
    return BlocListener<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state is FetchBeneficiaryToUpdateResponse) {
          final data = state.fetchBeneficiaryToUpdateList.first;

          rName.text = data.accountHolderName ?? '';
          rNickName.text = data.nickName ?? '';
          rMob.text = data.mobileNo ?? '';
          ifsc.text = data.ifscCode ?? '';
          accNo.text = data.accountNo ?? '';
          bankName.text = data.bankName ?? '';
          bankAddress.text = data.bankAddress ?? '';
          strBankName = data.bankName ?? '';
        }

        if (state is FetchBeneficiaryToUpdateError) {
          Fluttertoast.showToast(msg: state.error ?? "Something went wrong");
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.isEdit ? "Update Beneficiary" : "Add Beneficiary",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.all(20), // bottom padding for button height + margin
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EditTextBordered(
                      controller: rName,
                      hint: "Enter Receiver Name",
                      //enabled: !widget.isEdit,
                      errorText: rNameVal ? "Name is invalid" : null,
                      textCapitalization: TextCapitalization.words,
                      onChange: (value) {
                        setState(() {
                          rNameVal = value.trim().length < 3;
                        });
                      },
                    ),
                    const SizedBox(height: 18.0),
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
                    const SizedBox(height: 18.0),
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
                    const SizedBox(height: 18.0),
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
                    const SizedBox(height: 18.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          strBankName ?? '',
                          style: const TextStyle(color: Colors.green, fontSize: 16.0),
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
                                );
                              }
                            } catch (e) {
                              Fluttertoast.showToast(msg: "Failed to fetch bank details");
                            }
                          },
                          child: const Text(
                            "Check",
                            style: TextStyle(color: Colors.red, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18.0),
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
                    const SizedBox(height: 18.0),
                    EditTextBordered(
                      controller: bankName,
                      hint: "Enter Bank Name",
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      errorText: bankNameVal ? "Bank Name is invalid" : null,
                      onChange: (value) {
                        setState(() {
                          bankNameVal = value.trim().isEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 18.0),
                    EditTextBordered(
                      controller: bankAddress,
                      hint: "Enter Bank Address",
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      errorText: bankAddressVal ? "Bank Address is invalid" : null,
                      onChange: (value) {
                        setState(() {
                          bankAddressVal = value.trim().isEmpty;
                        });
                      },
                    ),
                     SizedBox(height: h*0.25),

                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomRaisedButton(
                loadingValue: _isLoading,
                buttonText: _isLoading
                    ? "Loading"
                    : widget.isEdit
                    ? "Update Beneficiary"
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

                    await submitBeneficiary();
                  } else {
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
      ),
    );
  }
}
