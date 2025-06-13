import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passbook_core_jayant/MainScreens/Model/LoginModel.dart';
import 'package:passbook_core_jayant/MainScreens/Model/register_acc_modal.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/sim_sender.dart';
import 'package:passbook_core_jayant/Util/sim_ui.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class RegisterUI extends StatefulWidget {
  final GestureTapCallback? onTap;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const RegisterUI({super.key, this.onTap, required this.scaffoldKey});

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI>
    with SingleTickerProviderStateMixin {
  TextEditingController mobCtrl = TextEditingController(),
      otpCtrl = TextEditingController(),
      accCtrl = TextEditingController(),
      passCtrl = TextEditingController(),
      rePassCtrl = TextEditingController(),
      mpinCtrl = TextEditingController(),
      reMpinCtrl = TextEditingController(),
      usernameCtrl = TextEditingController();
  List<RegisterAccData> accNos = [];
  FocusNode chapass = FocusNode();
  bool isSendOTP = false, isOtpValid = false;
  bool mobVal = false,
      passVal = false,
      rePassVal = false,
      mpinVal = false,
      reMpinVal = false,
      accVal = false,
      userNameVal = false,
      otpVal = false;
  LoginModel login = LoginModel();
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  bool _isLoading = false;

  final _listController = ScrollController();

  //SharedPreferences? pref;

  void loadSims() async {
    // Request permission
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      debugPrint("Phone permission not granted");
      return;
    }

    try {
      // Fetch SIM list
      final simList = await SimSender.getSimList();
      successPrint("SIM list length: ${simList.length}");

      if (simList.isEmpty) {
        debugPrint("No SIM cards found");
        return;
      }

      setState(() {
        // Optionally update UI with sim list (if needed elsewhere)
      });

      // Show bottom sheet and handle selection
      showSimGridBottomSheet(context, simList, (selectedNumber) {
        successPrint("Selected phone number: $selectedNumber");
        if (selectedNumber.startsWith('+91')) {
          selectedNumber = selectedNumber.substring(3);
        } else if (selectedNumber.length == 12 &&
            selectedNumber.startsWith('91')) {
          selectedNumber = selectedNumber.substring(2);
        }

        mobCtrl.text = selectedNumber;

        final trimmed = mobCtrl.text.trim();
        customPrint("trimmed length=${trimmed.length}");

        alertPrint("mobval=$mobVal");
        setState(() {
          mobVal = trimmed.length != 10;
          isOtpValid = false;
          isSendOTP = false;
          _controller.reverse();
        });

        // Trigger registration
        onRegister();
      });
    } catch (e) {
      debugPrint("Error loading SIMs: $e");
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _fadeIn = Tween(begin: 0.5, end: 1.0).animate(_controller);
    loadSims();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: widget.onTap,
          child: Card(
            elevation: 3.0,
            margin: EdgeInsets.all(10.0),
            color: Theme.of(context).focusColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.chevron_left, color: Colors.white, size: 20.0),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * .15,
          left: 20.0,
          child: TextView(
            text: "Sign Up",
            size: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).focusColor,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * .25,
          left: 0.0,
          right: 0.0,
          height: MediaQuery.of(context).size.width * 1.31,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              controller: _listController,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  EditTextBordered(
                    // onTap: () {
                    //   print("tapped");
                    //   loadSims();
                    // },
                    readOnly: false,
                    controller: mobCtrl,
                    hint: "Mobile No",
                    keyboardType: TextInputType.number,
                    errorText: mobVal ? "Mobile number is invalid" : null,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      onRegister();
                      FocusScope.of(context).nextFocus();
                    },

                    onChange: (value) {
                      setState(() {
                        print(value.trim().length != 10);

                        mobVal = value.trim().length != 10;
                        setState(() {
                          isOtpValid = false;
                          isSendOTP = false;
                          _controller.reverse();
                        });
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  EditTextBordered(
                    controller: otpCtrl,
                    hint: "Enter OTP",
                    keyboardType: TextInputType.number,
                    errorText: otpVal ? "OTP length should be 6" : null,
                    onChange: (value) {
                      setState(() {
                        otpVal = value.trim().length < 6;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  FadeTransition(
                    opacity: _fadeIn,
                    child: IgnorePointer(
                      ignoring: false /*!isOtpValid && !isSendOTP*/,
                      child: Column(
                        children: <Widget>[
                          LabelWithDropDownField<RegisterAccData>(
                            enabled: isOtpValid,
                            textDropDownLabel: "Select A/C No",
                            items: accNos,
                            itemAsString: (p0) => p0.accNo,
                            onChanged: (value) {
                              accCtrl.text = value.accId;
                            },
                            padding: 20,
                          ),

                          SizedBox(height: 20.0),
                          EditTextBordered(
                            readOnly: isOtpValid == true ? false : true,
                            controller: usernameCtrl,
                            hint: "Enter a user name",
                            errorText: userNameVal ? "Invalid username" : null,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChange: (value) {
                              setState(() {
                                userNameVal =
                                    value.trim().length <= 3 ||
                                    value.trim().length >= 11;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          EditTextBordered(
                             readOnly: isOtpValid == true ? false : true,
                            controller: passCtrl,
                            hint: "Password",
                            errorText:
                                passVal
                                    ? "Please include special characters"
                                    : null,
                            obscureText: true,
                            showObscureIcon: true,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChange: (value) {
                              setState(() {
                                //  passVal = value.trim().length < 4;
                                //   passVal = RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value);
                                passVal = RegExp(
                                  r"^[a-zA-Z0-9]+$",
                                ).hasMatch(value);
                                //    passVal = RegExp(r"^([a-zA-Z])(0-9)+$").hasMatch(value);
                                //   passVal = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{4,}$').hasMatch(value);
                                //  passVal = RegExp("^(.{8,32}\$)(.*[A-Z])(.*[a-z])(.*[0-9])(.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(value);
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          EditTextBordered(
                             readOnly: isOtpValid == true ? false : true,
                            controller: rePassCtrl,
                            hint: "Confirm Password",
                            focusNode: chapass,
                            textInputAction: TextInputAction.next,
                            errorText:
                                rePassVal ? "Password not matching" : null,
                            obscureText: true,
                            showObscureIcon: true,
                            onChange: (value) {
                              setState(() {
                                rePassVal = rePassCtrl.text != passCtrl.text;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),

                          ///MPIN
                          EditTextBordered(
                             readOnly: isOtpValid == true ? false : true,
                            controller: mpinCtrl,
                            hint: "MPIN",
                            keyboardType: TextInputType.number,

                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            obscureText: true,
                            showObscureIcon: true,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChange: (value) {
                              setState(() {
                                mpinVal = RegExp(r"^[0-9]{4}$").hasMatch(value);
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          EditTextBordered(
                             readOnly: isOtpValid == true ? false : true,
                            controller: reMpinCtrl,
                            hint: "Confirm MPIN",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textInputAction: TextInputAction.done,
                            errorText: reMpinVal ? "MPIN not matching" : null,
                            obscureText: true,
                            showObscureIcon: true,
                            onChange: (value) {
                              setState(() {
                                reMpinVal = RegExp(
                                  r"^[0-9]{4}$",
                                ).hasMatch(value);
                                reMpinVal = reMpinCtrl.text != mpinCtrl.text;
                              });
                            },
                          ),
                          SizedBox(height: 120.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: CustomRaisedButton(
            loadingValue: _isLoading,
            buttonText:
                !isSendOTP
                    ? "Send OTP"
                    : isSendOTP && !isOtpValid
                    ? "Validate OTP"
                    : "Register",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            onPressed: () async {
              onRegister();
            },
          ),
        ),
      ],
    );
  }

  Future<void> saveMpin(String mpin) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(StaticValues.Mpin, "Y");
    await pref.setString(StaticValues.fullMpin, mpin);

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  void onRegister() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
    if (!isSendOTP && !isOtpValid) {
      if (mobCtrl.text.trim().length == 10) {
        _isLoading = true;
        try {
          ///otp sent api call
          Map<String, dynamic> validateMobNoBody = {
            "Cmp_Code": cmpCode,
            "Mobile_No": mobCtrl.text.trim(),
          };

          Map response = await (RestAPI().post(
            APis.getRegisterOTP,
            params: validateMobNoBody,
          ));
          setState(() {
            _isLoading = false;
            alertPrint("mob no validating =$_isLoading");
          });

          if (response["ProceedStatus"].toString().toLowerCase() == 'y') {
            warningPrint("mob no otp sent if worked");
            GlobalWidgets().showSnackBar(context, "OTP sent");
            setState(() {
              isSendOTP = true;
            });
          } else {
            warningPrint("mob no otp sent else worked");
            setState(() {
              isSendOTP = false;
            });
            GlobalWidgets().showSnackBar(context, "Invalid mobile number");
          }
        } on RestException catch (e) {
          setState(() {
            _isLoading = false;
          });

          GlobalWidgets().showSnackBar(
            context,
            e.message["ProceedMessage"].toString(),
          );
        }
      } else {
        setState(() {
          isSendOTP = false;
        });
        GlobalWidgets().showSnackBar(context, "Invalid mobile number");
      }
    } else if (isSendOTP && !isOtpValid) {
      if (mobCtrl.text.trim().length == 10 && otpCtrl.text.length >= 6) {
        try {
          ///Validate otp  api call
          setState(() {
            _isLoading = true;
          });
          Map<String, dynamic> validateOTPBody = {
            "Cmp_Code": cmpCode,
            "Mobile_No": mobCtrl.text.trim(),
            "OTP": otpCtrl.text,
          };
          Map response = await (RestAPI().post(
            APis.validateOTP,
            params: validateOTPBody,
          ));

          alertPrint("_isLoading=$_isLoading");
          if (response["ProceedStatus"].toString().toLowerCase() == 'n') {
            GlobalWidgets().showSnackBar(
              context,
              response["ProceedMessage"].toString(),
            );
            setState(() {
              isOtpValid = false;
              isSendOTP = true;
              _isLoading = false;
            });
            alertPrint("_isLoading=$_isLoading");
          } else {
            GlobalWidgets().showSnackBar(
              context,
              response["ProceedMessage"].toString(),
            );
            setState(() {
              accNos.clear();
              for (var f in (response["Data"] as List)) {
                accNos.add(
                  RegisterAccData(accId: f["Acc_ID"], accNo: f["Acc_No"]),
                );
              }
              isOtpValid = true;
              isSendOTP = true;
              _isLoading = false;
              _controller.forward();
            });
          }
          alertPrint("_isLoading after response with accno=$_isLoading");
        } on RestException catch (e) {
          setState(() {
            _isLoading = false;
          });
          GlobalWidgets().showSnackBar(
            context,
            e.message["ProceedMessage"].toString(),
          );
        }
      } else {
        GlobalWidgets().showSnackBar(context, "Invalid OTP or Mobile number");
        setState(() {
          isOtpValid = false;
          isSendOTP = true;
        });
      }
    } else {
      bool passValue = passCtrl.text.contains(RegExp(r"^[a-zA-Z0-9]+$"));

      if (passValue) {
        GlobalWidgets().showSnackBar(
          context,
          "Please include special characters in password",
        );
      } else if (passCtrl.text != rePassCtrl.text) {
        GlobalWidgets().showSnackBar(context, "Password Miss match");
      } else if (usernameCtrl.text.length <= 3 ||
          usernameCtrl.text.length >= 11) {
        GlobalWidgets().showSnackBar(
          context,
          "Max length for username is 10 and Min is 4",
        );
      } else if (passCtrl.text.length <= 3 || passCtrl.text.length >= 11) {
        GlobalWidgets().showSnackBar(
          context,
          "Max length for password is 10 and Min is 4",
        );
      } else if (passCtrl.text.contains(" ") ||
          usernameCtrl.text.contains(" ") ||
          mpinCtrl.text.contains(" ")) {
        GlobalWidgets().showSnackBar(
          context,
          "Please remove space from username or password",
        );
      } else if (mpinCtrl.text != reMpinCtrl.text) {
        GlobalWidgets().showSnackBar(context, "MPIN Mismatch");
      } else {
        if (mobCtrl.text.trim().length == 10 &&
                otpCtrl.text.length >= 4 &&
                accCtrl.text.isNotEmpty &&
                //   usernameCtrl.text.length > 3 &&
                usernameCtrl.text.length >= 3 ||
            usernameCtrl.text.length <= 11 &&
                //  passCtrl.text.length >= 4 &&
                //  passCtrl.text.length>=6 && !passCtrl.text.contains(RegExp(r'\W')) && RegExp(r'\d+\w*\d+').hasMatch(passCtrl.text) &&
                //  passCtrl.text.length>=4 && !passCtrl.text.contains(RegExp(r'\W')) && RegExp(r'\d+\w*\d+').hasMatch(passCtrl.text) &&
                //  passCtrl.text.length>=4 && passCtrl.text.contains(RegExp(r"^[a-zA-Z0-9]+$")) && RegExp(r"^[a-zA-Z0-9]+$").hasMatch(passCtrl.text) &&
                passCtrl.text == rePassCtrl.text &&
                mpinCtrl.text == reMpinCtrl.text) {
          ///Register
          try {
            Map<String, dynamic> registerBody = {
              "Cmp_Code": cmpCode,
              "MobileNo": mobCtrl.text.trim(),
              "Acc_ID": accCtrl.text,
              "User_Name": usernameCtrl.text,
              "User_Password": passCtrl.text,
              "User_MPIN": mpinCtrl.text,
            };

            String url = APis.registerAcc;
            setState(() {
              _isLoading = true;
            });

            Map response = await (RestAPI().post(url, params: registerBody));

            if (response["ProceedStatus"].toString().toLowerCase() == "n") {
              GlobalWidgets().showSnackBar(
                context,
                response["Data"][0]["Proceed_Message"].toString(),
              );
              setState(() {
                _isLoading = false;
              });
            } else {
              GlobalWidgets().showSnackBar(
                context,
                response["Data"][0]["Proceed_Message"].toString(),
              );
              widget.onTap!();
              saveMpin(mpinCtrl.text);
            }
          } on RestException catch (e) {
            setState(() {
              _isLoading = false;
            });

            GlobalWidgets().showSnackBar(
              context,
              e.message["Data"][0]["Proceed_Message"].toString(),
            );
          }
        } else {
          GlobalWidgets().showSnackBar(
            context,
            "Please fill the missing fields",
          );
        }
      }
    }
  }
}
