import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_event.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_state.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/QRScan.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FundTransfer/bloc/transfer_bloc.dart';
import '../configuration.dart';

class GlobalWidgets {
  addressCorrection(String address) {
    address.matchAsPrefix(",");
  }

  Widget logoWithText(BuildContext context, TitleDecoration titleDecoration) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          height: 75.0,
          width: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: titleDecoration.bgColor ?? Color(0xffffffff),
            image: DecorationImage(
              image: AssetImage(titleDecoration.logoPath!),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextView(
          text: titleDecoration.label ?? "",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          size: 24.0,
          color: titleDecoration.labelColor ?? Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget logoWithoutText(
    BuildContext context,
    TitleDecoration titleDecoration,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          height: 75.0,
          width: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // color: titleDecoration.bgColor ?? Color(0xffffffff),
            color: titleDecoration.bgColor ?? Colors.white.withOpacity(0.1),
            image: DecorationImage(
              image: AssetImage(titleDecoration.logoPath!),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  void showSnackBar(
    BuildContext context,
    String msg, {
    SnackBarAction? actions,
    bool floating = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        duration: const Duration(seconds: 5),
        action: actions,
      ),
    );
  }

  Widget btnWithText({
    Widget? icon,
    String? name,
    VoidCallback? onPressed,
    NeumorphicBoxShape? boxShape,
    Color textColor = Colors.black,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(100.0),
          splashColor: Colors.white,
          child: Neumorphic(
            drawSurfaceAboveChild: true,
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 6,
              intensity: .5,
              surfaceIntensity: .35,
              color: Colors.white,
              lightSource: LightSource(1, -0.8),
              boxShape: boxShape ?? NeumorphicBoxShape.circle(),
            ),
            child: Padding(padding: const EdgeInsets.all(15.0), child: icon),
          ),
        ),
        SizedBox(height: 5.0),
        TextView(
          text: name!,
          color: textColor,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget gridWidget({
    required BuildContext context,
    String? imageName,
    String? name,
    VoidCallback? onPressed,
    NeumorphicBoxShape? boxShape,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Neumorphic(
        margin: EdgeInsets.all(7.0),
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: 6,
          intensity: .5,
          surfaceIntensity: .35,
          color: Colors.white,
          lightSource: LightSource(1, -0.8),
          boxShape:
              boxShape ??
              NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imageName!,
                width: 50.0,
                height: 50.0,
                color: Theme.of(context).dividerColor,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.0),
              TextView(text: name!, size: 10),
            ],
          ),
        ),
      ),
    );
  }

  void dialogTemplate({
    required BuildContext context,
    required title,
    bool barrierDismissible = true,
    Color color = Colors.white,
    Widget? content,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Theme(
            data: Theme.of(
              context,
            ).copyWith(dialogTheme: DialogThemeData(backgroundColor: color)),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              title:
                  title == null
                      ? null
                      : TextView(
                        text: title,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
              content: content,
              actions: actions,
            ),
          ),
        );
      },
    );
  }

  /*
  void proceedToPaymentModal(
    BuildContext context, {
    Function(String otp) onChange,
    Widget button,
  }) async {
    final gap = 20.0;
    bool passVal = false, otpVal = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String pass = pref.getString(StaticValues.userPass);
    TextEditingController passCtrl = TextEditingController(), otpCtrl = TextEditingController();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(gap))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: gap,
                        right: gap,
                        top: gap,
                        bottom: MediaQuery.of(context).viewInsets.bottom == 0
                            ? gap
                            : MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EditTextBordered(
                          controller: passCtrl,
                          hint: "Enter password",
                          obscureText: true,
                          showObscureIcon: true,
                          autoFocus: true,
                          errorText: passVal ? "Password is invalid" : null,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextView(text:"OTP has sent to your registered number"),
                        SizedBox(
                          height: 10.0,
                        ),
                        EditTextBordered(
                          controller: otpCtrl,
                          hint: "Enter OTP",
                          errorText: otpVal ? "OTP is invalid" : null,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    )),
                button,
              ],
            ));
          });
        });
  }
*/
  void proceedToPaymentModal(
    BuildContext context, {
    Widget? actionButton,
    Function(String password, String otp)? getValue,
  }) async {
    final gap = 20.0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String pass = pref.getString(StaticValues.userPass) ?? "";
    TextEditingController passCtrl = TextEditingController(),
        otpCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(gap)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: gap,
                      right: gap,
                      top: gap,
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? gap
                              : MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EditTextBordered(
                          controller: passCtrl,
                          hint: "Enter password",
                          obscureText: true,
                          showObscureIcon: true,
                          autoFocus: true,
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              if (getValue != null) {
                                getValue(
                                  passCtrl.text.trim(),
                                  otpCtrl.text.trim().isNotEmpty
                                      ? otpCtrl.text.trim()
                                      : "",
                                );
                              }
                            });
                          },
                        ),
                        SizedBox(height: 30.0),
                        TextView(
                          text: "OTP has sent to your registered number",
                        ),
                        SizedBox(height: 10.0),
                        EditTextBordered(
                          controller: otpCtrl,
                          hint: "Enter OTP",
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              if (getValue != null) {
                                getValue(
                                  passCtrl.text.trim(),
                                  otpCtrl.text.trim().isNotEmpty
                                      ? otpCtrl.text.trim()
                                      : "",
                                );
                              }
                            });
                          },
                        ),
                        SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                  if (actionButton != null) actionButton,
                ],
              ),
            );
          },
        );
      },
    );
  }

  void billPaymentModal(
    BuildContext context, {
    Widget? actionButton,
    Widget? content,
    Function(String password)? getValue,
    Function(String otp)? getValue1,
  }) async {
    final gap = 20.0;
    TextEditingController passCtrl = TextEditingController();
    TextEditingController otpCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(gap)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: gap,
                      right: gap,
                      top: gap,
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? gap
                              : MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        content!,
                        EditTextBordered(
                          controller: passCtrl,
                          hint: "Enter password",
                          obscureText: true,
                          showObscureIcon: true,
                          autoFocus: true,
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              getValue!(passCtrl.text.trim());
                            });
                          },
                        ),
                        SizedBox(height: 12.0),
                        EditTextBordered(
                          controller: otpCtrl,
                          hint: "Enter OTP",
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              getValue1!(otpCtrl.text.trim());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actionButton!,
                ],
              ),
            );
          },
        );
      },
    );
  }

  void scanPaymentModal(
    BuildContext context,
    String userName,
    String userAccNo, {
    Widget? button,
    ValueChanged<String>? onChange,
  }) async {
    final gap = 20.0;
    bool amtVal = false;
    String acType = "";
    String userAcc = "";
    int fromGroupValue = 0;
    final transferbloc = TransferBloc.get(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString(StaticValues.custID) ?? "";
    transferbloc.add(FetchCustomerFromAccNo(userId));
    TextEditingController amtCtrl = TextEditingController();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(gap)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: gap,
                      right: gap,
                      top: gap,
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? gap
                              : MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: TextView(text: userName, size: 18.0),
                          subtitle: TextView(text: userAccNo),
                        ),
                        SizedBox(height: 10.0),
                        EditTextBordered(
                          controller: amtCtrl,
                          setDecoration: true,
                          hint: "Enter Amount",
                          autoFocus: true,
                          setBorder: true,
                          errorText:
                              amtVal == true
                                  ? "Minimum amount is ${StaticValues.rupeeSymbol}1"
                                  : null,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onChange: onChange!,
                        ),
                        SizedBox(height: 50.0),
                        TextView(
                          text: "From",
                          size: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        BlocBuilder<TransferBloc, TransferState>(
                          buildWhen:
                              (previous, current) =>
                                  current is FromAccResponseLoading ||
                                  current is FromAccResponse,
                          builder: (context, state) {
                            if (state is FromAccResponseError) {
                              return Center(
                                child: Text("Something Went Wrong"),
                              );
                            } else if (state is FromAccResponseLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is FromAccResponse) {
                              if (state.accounts.isEmpty) {
                                return Center(child: Text("NO Account Found"));
                              } else {
                                userAcc = state.accounts[fromGroupValue].accNo;
                                preferences.setString(
                                  StaticValues.selectedAccNo,
                                  userAcc,
                                );
                                warningPrint("UserAcc in first build=$userAcc");
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.accounts.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      value: index,
                                      groupValue: fromGroupValue,
                                      onChanged: (value) {
                                        preferences.setString(
                                          StaticValues.selectedAccNo,
                                          userAcc,
                                        );
                                        setState(() {
                                          fromGroupValue = value!;
                                        });
                                        userAcc = state.accounts[index].accNo;

                                        warningPrint(
                                          "UserAcc in From=$userAcc",
                                        );
                                      },
                                      title: TextView(
                                        text:
                                            state.accounts[index].accNo
                                                .toString() ??
                                            "",
                                        size: 24,
                                      ),
                                      subtitle: TextView(
                                        text:
                                            state.accounts[index].accType
                                                .toString() ??
                                            "",
                                        size: 12.0,
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    left: 0.0,
                    bottom: 0.0,
                    child: button!,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void shoppingPay(
    BuildContext context,
    Function(void Function()) setState,
    GlobalKey<ScaffoldState> scaffoldKey,
    String userBal,
  ) async {
    bool isLoading = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Scan the QR code and handle the result
    Barcode result1 = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => QRScanView()));

    // Extract the code from the Barcode object
    String? result = result1.code;

    // Ensure the result is not null
    if (result == null || result.isEmpty) {
      GlobalWidgets().showSnackBar(
        context,
        "Invalid QR-Code, please try again.",
      );
      return;
    }

    // Clean the result URL
    result = result.replaceAll("http://", "");
    print("RESULTQR :: $result");

    String datetime = DateTime.now().toString();
    String refNo = "OtherBankTranfer$datetime";

    String shoppingAmount = "";
    Map shopInfo = await RestAPI().get(APis.fetchShoppingInfo(result));
    print("RESULTqr :: $result  $shopInfo");

    if (shopInfo["Table"][0]["Name"] == 'N') {
      GlobalWidgets().showSnackBar(
        context,
        "Invalid QR-Code, try to scan our own bank QR-Code",
      );
      return;
    }

    // Proceed with payment modal and rest of the flow
    GlobalWidgets().scanPaymentModal(
      context,
      shopInfo["Table"][0]["Name"],
      shopInfo["Table"][0]["AccNo"],
      onChange: (amount) async {
        shoppingAmount = amount;
      },
      button: CustomRaisedButton(
        buttonText: "PROCEED",
        loadingValue: isLoading,
        onPressed:
            isLoading
                ? null
                : () async {
                  String acc =
                      preferences.getString(StaticValues.selectedAccNo) ?? "";
                  successPrint("acc in shopping pay=$acc");
                  if (acc == shopInfo["Table"][0]["AccNo"]) {
                    Fluttertoast.showToast(
                      msg: "You cannot send money to the same account",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    if (int.parse(
                          shoppingAmount.isEmpty ? "0" : shoppingAmount,
                        ) <=
                        0) {
                      Fluttertoast.showToast(
                        msg: "Minimum amount is ${StaticValues.rupeeSymbol}1",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }
                    Map<String, dynamic> params = {
                      "Customer_AccNo": acc,
                      "BankId": "",
                      "Customer_Mobileno": "",
                      "ShopAccno": shopInfo["Table"][0]["AccNo"],
                      "PayAmount": shoppingAmount,
                    };
                    setState(() {
                      isLoading = true;
                    });
                    Map otpResponse = await RestAPI().get(
                      APis.ownFundTransferOTP(params),
                    );

                    Navigator.pop(context);

                    if (otpResponse["Table"][0]["Column1"]
                            .toString()
                            .toLowerCase() ==
                        'y') {
                      bool isLoading = false;
                      String pass = "";
                      String otp = "";
                      String ogPassword =
                          preferences.getString(StaticValues.userPass) ?? "";
                      GlobalWidgets().proceedToPaymentModal(
                        context,
                        getValue: (passVal, otpVal) {
                          warningPrint("passVal $passVal otpCtrl : $otpVal");
                          setState(() {
                            pass = passVal;
                            otp = otpVal;
                          });
                        },
                        actionButton: CustomRaisedButton(
                          loadingValue: isLoading,
                          buttonText: "PAY",
                          onPressed:
                              isLoading == true
                                  ? null
                                  : () async {
                                    successPrint(
                                      "passVal $pass otpCtrl : $otp",
                                    );
                                    if (pass.isEmpty && otp.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Password & OTP should not be empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } else if (pass.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: "Password is empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } else if (otp.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: "Otp is empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } else {
                                      if (pass != ogPassword) {
                                        Fluttertoast.showToast(
                                          msg: "Invalid password",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      } else {
                                        Map otpValidateResponse =
                                            await RestAPI().get(
                                              APis.fundTransferOTPValidation({
                                                "Acc_No": acc,
                                                "OTP": otp,
                                              }),
                                            );

                                        successPrint(
                                          "otp validate=$otpValidateResponse",
                                        );
                                        if (otpValidateResponse["Table"][0]["status"]
                                                .toString()
                                                .toLowerCase() ==
                                            "y") {
                                          Map<String, String> params = {
                                            "Customer_AccNo": acc,
                                            "Customer_Mobileno": "",
                                            "ShopAccno":
                                                shopInfo["Table"][0]["AccNo"],
                                            "PayAmount": shoppingAmount,
                                            "st_otp": otp,
                                            "RefNo": refNo,
                                          };

                                          setState(() {
                                            isLoading = true;
                                          });

                                          try {
                                            Map? response = await RestAPI().get<
                                              Map
                                            >(APis.ownBankFundTrans2(params));

                                            customPrint(
                                              "response in otp scanpay=$response",
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });

                                            if (response["Table"][0]["Status"]
                                                    .toString()
                                                    .toLowerCase() ==
                                                "y") {
                                              Navigator.of(
                                                context,
                                              ).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => Receipt(
                                                        pushReplacementNamed:
                                                            "/HomePage",
                                                        amount: shoppingAmount,
                                                        transID:
                                                            response["Table"][0]["TranNO"]
                                                                .toString(),
                                                        paidTo:
                                                            shopInfo["Table"][0]["Name"],
                                                        accTo:
                                                            shopInfo["Table"][0]["AccNo"]
                                                                .toString(),
                                                        accFrom: acc,
                                                      ),
                                                ),
                                                (Route<dynamic> route) => false,
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "Transfer Failed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: 16.0,
                                              );
                                            }
                                          } on RestException catch (e) {
                                            Navigator.of(context).pop();
                                            GlobalWidgets().showSnackBar(
                                              context,
                                              e.message,
                                            );
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Invalid OTP",
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black54,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      }
                                    }
                                  },
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                      GlobalWidgets().showSnackBar(
                        context,
                        ("Something went wrong please try again"),
                      );
                    }
                  }
                },
      ),
    );
  }

  Widget hompageCard() {
    double height = 175.0;
    return Container(
      height: height,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          //			  stops: [0.1, 0.5, 0.7, 0.9],
          colors: [Color(0xff3425AF), Color(0xffC56CD6)],
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              TextView(
                text: "SB INDIVIDUAL",
                size: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 5.0),
              TextView(
                text: "MAIN BRANCH",
                size: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextView(
              text: "002007000261".replaceAllMapped(
                RegExp(r".{4}"),
                (match) => "${match.group(0)} ",
              ),
              size: 32,
              color: Colors.white54,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextView(
              text: "${StaticValues.rupeeSymbol}124563",
              color: Colors.white,
              size: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextView(
                        text: "Nominee",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      TextView(
                        text: "Lijith",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextView(
                        text: "Maturity Date",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      TextView(
                        text: "09-04-2020",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateOTP(
    BuildContext context, {
    Widget? actionButton,
    Widget? content,
    Function(String password)? getValue,
  }) async {
    final gap = 20.0;
    TextEditingController passCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(gap)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: gap,
                      right: gap,
                      top: gap,
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? gap
                              : MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        content!,
                        EditTextBordered(
                          controller: passCtrl,
                          keyboardType: TextInputType.number,
                          hint: "Enter OTP",
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              getValue!(passCtrl.text.trim());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actionButton!,
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class EditTextBordered extends StatefulWidget {
  final String hint;
  final String? errorText;
  final double? size, height;
  final Color? color, hintColor, borderColor;
  final int? maxLength;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled, autoFocus;
  final bool? setBorder, setDecoration;
  final bool? showObscureIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChange, onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final Widget? obscureIcon;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;
  final bool? readOnly;
  final void Function()? onTap;

  const EditTextBordered({
    super.key,
    required this.hint,
    this.size,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.textAlign,
    this.onChange,
    this.hintColor,
    this.color,
    this.obscureText = false,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.inputFormatters,
    this.textInputAction,
    this.borderColor,
    this.controller,
    this.obscureIcon,
    this.height,
    this.showObscureIcon = false,
    this.enabled = true,
    this.setBorder = true,
    this.setDecoration = true,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
    this.autoFocus = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  EditTextBorderedState createState() => EditTextBorderedState();
}

class EditTextBorderedState extends State<EditTextBordered> {
  bool _isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          readOnly: widget.readOnly ?? false,
          enabled: widget.enabled ?? true,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: widget.obscureText == true ? _isVisibility : false,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus ?? false,
          textAlign: widget.textAlign ?? TextAlign.left,
          keyboardType: widget.keyboardType,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          decoration:
              widget.setDecoration == false
                  ? InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: widget.size,
                      color:
                          widget.hintColor ??
                          Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.grey,
                    ),
                    counterText: "",
                    alignLabelWithHint: true,
                    hintText: widget.hint,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorText: widget.errorText,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: widget.size,
                    ),
                    prefix: widget.prefix,
                  )
                  : InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: widget.size,
                      color:
                          widget.hintColor ??
                          Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.height ?? 20,
                      horizontal: 12.0,
                    ),
                    focusedBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor ??
                                    Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    enabledBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor ??
                                    Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    border:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor ??
                                    Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    disabledBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1.0,
                                color: Color(0xffcacaca),
                              ),
                            )
                            : InputBorder.none,
                    counterText: "",
                    labelText: widget.hint,
                    errorText: widget.errorText,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: widget.size,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Color(0xffff0000),
                      ),
                    ),
                  ),
          style: TextStyle(
            color:
                widget.color ??
                Theme.of(context).textTheme.bodyLarge?.color ??
                Colors.black,
            fontSize: widget.size,
          ),
        ),
        if (widget.obscureIcon != null)
          Positioned(right: 0.0, top: 5.0, child: widget.obscureIcon!),
        if (widget.showObscureIcon == true)
          Positioned(
            top: 15,
            right: 10,
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  setState(() {
                    _isVisibility = !_isVisibility;
                  });
                },
                child: Icon(
                  _isVisibility ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TextFormBordered extends StatefulWidget {
  final String hint;
  final String? errorText;
  final double? size, height;
  final Color? color, hintColor, borderColor;
  final int? maxLength;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled, autoFocus;
  final bool? setBorder, setDecoration;
  final bool? showObscureIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final Widget? obscureIcon;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;

  TextFormBordered({
    super.key,
    required this.hint,
    this.size,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.textAlign,
    this.onChange,
    this.hintColor,
    this.color,
    this.obscureText,
    this.validator,
    this.onEditingComplete,
    this.focusNode,
    this.textInputAction,
    this.borderColor,
    this.controller,
    this.obscureIcon,
    this.height,
    this.showObscureIcon = false,
    this.enabled,
    this.setBorder = true,
    this.setDecoration = true,
    this.errorText,
    this.textCapitalization,
    this.prefix,
    this.autoFocus = false,
  });

  @override
  TextFormBorderedState createState() => TextFormBorderedState();
}

class TextFormBorderedState extends State<TextFormBordered> {
  bool _isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1, 0),
      children: <Widget>[
        TextFormField(
          scrollPadding: EdgeInsets.only(bottom: 100.0),
          enabled: widget.enabled ?? true,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: widget.obscureText == null ? false : _isVisibility,
          validator: widget.validator!,
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus ?? false,
          textAlign: widget.textAlign ?? TextAlign.left,
          keyboardType: widget.keyboardType,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          decoration:
              widget.setDecoration == true
                  ? InputDecoration(
                    hintStyle: TextStyle(
                      inherit: false,
                      fontSize: widget.size,
                      color:
                          widget.hintColor ??
                          Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    counterText: "",
                    alignLabelWithHint: true,
                    hintText: widget.hint,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorText: widget.errorText,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: widget.size,
                    ),
                    errorBorder: InputBorder.none,
                    prefix: widget.prefix,
                  )
                  : InputDecoration(
                    labelStyle: TextStyle(
                      inherit: false,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: widget.size,
                      color:
                          widget.hintColor ??
                          Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.height ?? 20,
                      horizontal: 12.0,
                    ),
                    focusedBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    enabledBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    border:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).dividerColor,
                              ),
                            )
                            : InputBorder.none,
                    disabledBorder:
                        widget.setBorder == true
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Color(0xffcacaca),
                              ),
                            )
                            : InputBorder.none,
                    counterText: "",
                    labelText: widget.hint,
                    errorText: widget.errorText,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: widget.size,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xffff0000),
                      ),
                    ),
                  ),
          style: TextStyle(
            color: widget.color ?? Theme.of(context).textTheme.bodyLarge!.color,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
            fontSize: widget.size,
          ),
        ),
        widget.obscureIcon == null
            ? Container()
            : Positioned(right: 0.0, top: 5.0, child: widget.obscureIcon!),
        Positioned(
          top: 15,
          right: 10,
          child:
              widget.showObscureIcon == false
                  ? Container()
                  : Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        setState(() {
                          _isVisibility = !_isVisibility;
                          print("$_isVisibility");
                        });
                      },
                      child: SizedBox(
                        width: 30.0,
                        child: Icon(
                          _isVisibility
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}

class TextView extends StatelessWidget {
  final String text;
  final double? size, _size, textScaleFactor;
  final Color? color;
  final int? maxLines;
  final double? lineSpacing;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const TextView({
    required this.text,
    super.key,
    this.size,
    this.textAlign,
    this.color,
    this.textScaleFactor,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.lineSpacing,
    this.decoration,
  }) : _size = size ?? 12.0;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        letterSpacing: 1.2,
        decoration: decoration,
        height: lineSpacing,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
        textBaseline: TextBaseline.alphabetic,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: 'Roboto',
        fontSize: _size,
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final TextDecoration? decoration;
  final double? lineSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final List<TextSpan>? children;

  const CustomText({
    super.key,
    this.decoration,
    this.lineSpacing,
    this.color,
    this.fontWeight,
    this.size,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          //          letterSpacing: 1.2,
          decoration: decoration,
          height: lineSpacing,
          color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
          textBaseline: TextBaseline.alphabetic,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: 'Roboto',
          fontSize: size,
        ),
        children: children,
      ),
    );
  }
}

class CustomRaisedButton extends StatefulWidget {
  final bool loadingValue;
  final Function()? onPressed;
  final String buttonText;
  final double? textSize;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? buttonPadding;

  const CustomRaisedButton({
    super.key,
    this.loadingValue = false,
    required this.onPressed,
    required this.buttonText,
    this.shape,
    this.buttonPadding,
    this.textSize,
  });

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        disabledBackgroundColor: Theme.of(context).cardColor,
        padding: widget.buttonPadding ?? EdgeInsets.symmetric(vertical: 20.0),
        shape: widget.shape,
      ),
      onPressed: widget.loadingValue == true ? () {} : widget.onPressed,
      child:
          widget.loadingValue
              ? SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  semanticsLabel: "Loading",
                ),
              )
              : TextView(
                text: widget.buttonText,
                color: Colors.white,
                size: widget.textSize ?? 18.0,
                fontWeight: FontWeight.bold,
              ),
    );
  }
}

class SingleDigitTextField extends StatelessWidget {
  SingleDigitTextField({
    super.key,
    required this.controller,
    required this.autoFocus,
    this.prevFocusNode,
    required this.focusNode,
    this.nextFocusNode,
    this.obscureText,
    this.onChanged,
  });

  final TextEditingController controller;
  final bool autoFocus;
  final FocusNode? prevFocusNode;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  bool? obscureText = false;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // String? previousValue;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      height: 50,
      width: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          obscureText: obscureText == true ? true : false,
          obscuringCharacter: "*",
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintStyle: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onChanged: (value) {
            // if (value.length == 1) {
            //   FocusScope.of(context).nextFocus();
            //   if (onChanged != null) {
            //     onChanged!(value);
            //   }
            //   previousValue = value;
            // } else if (previousValue != null) {
            //   FocusScope.of(context).previousFocus();
            //   previousValue = null;
            // } else if (value.isEmpty) {
            //   FocusScope.of(context).previousFocus();
            // }
            if (value.isNotEmpty && nextFocusNode != null) {
              nextFocusNode!.requestFocus();
              onChanged?.call(value);
            } else if (value.isEmpty && prevFocusNode != null) {
              prevFocusNode!.requestFocus();
            }
          },
        ),
      ),
    );
  }
}
