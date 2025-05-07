import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/QRScan.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/passbook_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/StaticValue.dart';

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
          titleDecoration.label,
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

  showSnackBar(
    GlobalKey<ScaffoldState> _scaffoldKey,
    String msg, {
    SnackBarAction? actions,
    bool floating = false,
  }) {
    // _scaffoldKey.currentState!.showSnackBar(
    ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        duration: actions == null ? Duration(seconds: 5) : Duration(seconds: 5),
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
          name,
          color: textColor,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget gridWidget({
    required BuildContext context,
    required String imageName,
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
                imageName,
                width: 50.0,
                height: 50.0,
                color: Theme.of(context).focusColor,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.0),
              TextView(name, size: 10),
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
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: color),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              title:
                  title == null
                      ? null
                      : TextView(
                        title,
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
    SharedPreferences pref = StaticValues.sharedPreferences;
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
                        TextView("OTP has sent to your registered number"),
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
    Function(String? password, String? otp)? getValue,
  }) async {
    final gap = 20.0;
    SharedPreferences pref = StaticValues.sharedPreferences!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    String? pass = pref.getString(StaticValues.userPass);
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
                            passCtrl.text = value;
                            print("PassWord TextField1 ${value}");
                            print("PassWord TextField2 ${passCtrl.text}");
                            setState(() {
                              print("PassWord TextField3 ${passCtrl.text}");
                              getValue!(
                                !(passCtrl.text.trim().isEmpty ||
                                        passCtrl.text != pass)
                                    ? passCtrl.text.trim()
                                    // ? null
                                    // : passCtrl.text.trim(),
                                    : null,
                                otpCtrl.text.trim().isNotEmpty
                                    ? otpCtrl.text.trim()
                                    : null,
                              );
                              print("PassWord TextField4 ${passCtrl.text}");
                            });
                          },
                        ),
                        SizedBox(height: 30.0),
                        TextView("OTP has sent to your registered number"),
                        SizedBox(height: 10.0),
                        EditTextBordered(
                          controller: otpCtrl,
                          hint: "Enter OTP",
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onChange: (value) {
                            setState(() {
                              getValue!(
                                !(passCtrl.text.trim().isEmpty ||
                                        passCtrl.text != pass)
                                    ? passCtrl.text.trim()
                                    : null,
                                // !(passCtrl.text.trim().isEmpty ||
                                //         passCtrl.text != pass)
                                //     // ? passCtrl.text.trim()
                                //     ? null
                                //     : passCtrl.text.trim(),
                                otpCtrl.text.trim().isNotEmpty
                                    ? otpCtrl.text.trim()
                                    : null,
                              );
                            });
                          },
                        ),
                        SizedBox(height: 50.0),
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

  void scanPaymentModal(
    BuildContext context,
    String? userName,
    String? userAccNo, {
    Widget? button,
    Function(String otp)? onChange,
  }) async {
    final gap = 20.0;
    bool amtVal = false;
    TextEditingController amtCtrl = TextEditingController();
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
                          title: TextView(userName, size: 18.0),
                          subtitle: TextView(userAccNo),
                        ),
                        SizedBox(height: 10.0),
                        EditTextBordered(
                          controller: amtCtrl,
                          hint: "Enter Amount",
                          autoFocus: true,
                          errorText:
                              amtVal
                                  ? "Minimum amount is ${StaticValues.rupeeSymbol}1"
                                  : null,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onChange: onChange,
                        ),
                        SizedBox(height: 50.0),
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
    GlobalKey<ScaffoldState>? scaffoldKey,
    String acc,
  ) async {
    bool isLoading = false;
    String? result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => QRScanView()));
    print("RESULT :: $result");
    if (result == null) return;

    String _shoppingAmount = "";
    Map shopInfo = await (RestAPI().get(APis.fetchShoppingInfo(result)));
    print("RESULT :: $result  $shopInfo");
    if (shopInfo["Table"][0]["Name"] == 'N') {
      GlobalWidgets().showSnackBar(
        scaffoldKey!,
        "Invalid QR-Code, try to scan our own bank QR-Code",
      );
      return;
    }
    GlobalWidgets().scanPaymentModal(
      context,
      shopInfo["Table"][0]["Name"],
      shopInfo["Table"][0]["AccNo"],
      onChange: (amount) async {
        _shoppingAmount = amount;
      },
      button: CustomRaisedButton(
        buttonText: "PROCEED",
        loadingValue: isLoading,
        onPressed:
            isLoading
                ? null
                : () async {
                  if (int.parse(
                        _shoppingAmount.isEmpty ? "0" : _shoppingAmount,
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
                    "PayAmount": _shoppingAmount,
                  };
                  setState(() {
                    isLoading = true;
                  });
                  Map otpResponse = await (RestAPI().get(
                    APis.ownFundTransferOTP(params),
                  ));

                  Navigator.pop(context);

                  if (otpResponse["Table"][0]["Column1"]
                          .toString()
                          .toLowerCase() ==
                      'y') {
                    bool isLoading = false;
                    String? _pass, _otp;
                    GlobalWidgets().proceedToPaymentModal(
                      context,
                      getValue: (passVal, otpVal) {
                        setState(() {
                          _pass = passVal;
                          _otp = otpVal;
                        });
                      },
                      actionButton: CustomRaisedButton(
                        loadingValue: isLoading,
                        buttonText: "PAY",
                        onPressed:
                            isLoading
                                ? () {}
                                : () async {
                                  print("passVal $_pass otpCtrl : $_otp");
                                  if (_pass != null && _otp != null) {
                                    Map<String, String?> params = {
                                      "Customer_AccNo": acc,
                                      "Customer_Mobileno": "",
                                      "ShopAccno":
                                          shopInfo["Table"][0]["AccNo"],
                                      "PayAmount": _shoppingAmount,
                                      "st_otp": _otp,
                                    };

                                    setState(() {
                                      isLoading = true;
                                    });

                                    try {
                                      Map response =
                                          await (RestAPI().get<Map>(
                                                APis.ownBankFundTrans2(params),
                                              )
                                              as FutureOr<
                                                Map<dynamic, dynamic>
                                              >);

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
                                                  pushReplacementName:
                                                      "/HomePage",
                                                  amount: _shoppingAmount,
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
                                          msg: "Invalid OTP",
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
                                        scaffoldKey!,
                                        e.message,
                                      );
                                    }
                                  } else {
                                    _pass == null && _otp != null
                                        ? Fluttertoast.showToast(
                                          msg: "Incorrect password",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        )
                                        : Fluttertoast.showToast(
                                          msg:
                                              "Password & OTP should not be empty",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                  }
                                },
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                    GlobalWidgets().showSnackBar(
                      scaffoldKey!,
                      ("Something went wrong please try again"),
                    );
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
                "SB INDIVIDUAL",
                size: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 5.0),
              TextView(
                "MAIN BRANCH",
                size: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextView(
              "002007000261".replaceAllMapped(
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
              "${StaticValues.rupeeSymbol}124563",
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
                        "Nominee",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      TextView(
                        "Lijith",
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
                        "Maturity Date",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      TextView(
                        "09-04-2020",
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
}

///Old
// class EditTextBordered extends StatefulWidget {
//   final String? hint, errorText;
//   final double? size, height;
//   final Color? color, hintColor, borderColor;
//   final int? maxLength;
//   final int? maxLines;
//   final bool? obscureText;
//   final bool? enabled, autoFocus;
//   final bool setBorder, setDecoration;
//   final bool showObscureIcon;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final TextAlign? textAlign;
//   final TextInputType? keyboardType;
//   final ValueChanged<String>? onChange, onSubmitted;
//   final VoidCallback? onEditingComplete;
//   final TextEditingController? controller;
//   final Widget? obscureIcon;
//   final TextCapitalization? textCapitalization;
//   final Widget? prefix;
//
//   EditTextBordered(
//       {Key? key,
//       required this.hint,
//       this.size,
//       this.keyboardType,
//       this.maxLength,
//       this.maxLines = 1,
//       this.textAlign,
//       this.onChange,
//       this.hintColor,
//       this.color,
//       this.obscureText,
//       this.onSubmitted,
//       this.onEditingComplete,
//       this.focusNode,
//       this.textInputAction,
//       this.borderColor,
//       this.controller,
//       this.obscureIcon,
//       this.height,
//       this.showObscureIcon = false,
//       this.enabled,
//       this.setBorder = true,
//       this.setDecoration = true,
//       this.errorText,
//       this.textCapitalization,
//       this.prefix,
//       this.autoFocus = false})
//       : super(key: key);
//
//   @override
//   EditTextBorderedState createState() => EditTextBorderedState();
// }
//
// class EditTextBorderedState extends State<EditTextBordered> {
//   bool _isVisibility = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment(1, 0),
//       children: <Widget>[
//         TextField(
//           enabled: widget.enabled == null ? true : widget.enabled,
//           controller: widget.controller,
//           onChanged: widget.onChange,
//           obscureText: widget.obscureText == null ? false : _isVisibility,
//           onSubmitted: widget.onSubmitted,
//           onEditingComplete: widget.onEditingComplete,
//           maxLength: widget.maxLength,
//           maxLines: widget.maxLines,
//           textInputAction: widget.textInputAction,
//           focusNode: widget.focusNode,
//           autofocus: widget.autoFocus!,
//           textAlign:
//               widget.textAlign == null ? TextAlign.left : widget.textAlign!,
//           keyboardType: widget.keyboardType,
//           textCapitalization:
//               widget.textCapitalization ?? TextCapitalization.sentences,
//           decoration: !widget.setDecoration
//               ? InputDecoration(
//                   hintStyle: TextStyle(
//                       inherit: false,
//                       fontSize: widget.size,
//                       color: widget.hintColor != null
//                           ? widget.hintColor
//                           : Theme.of(context).textTheme.bodyText1!.color),
//                   counterText: "",
//                   alignLabelWithHint: true,
//                   hintText: widget.hint,
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   border: InputBorder.none,
//                   errorText: widget.errorText,
//                   errorStyle: TextStyle(
//                     color: Colors.redAccent,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.normal,
//                     fontSize: widget.size,
//                   ),
//                   errorBorder: InputBorder.none,
//                   prefix: widget.prefix)
//               : InputDecoration(
//                   labelStyle: TextStyle(
//                       inherit: false,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.normal,
//                       fontSize: widget.size,
//                       color: widget.hintColor != null
//                           ? widget.hintColor
//                           : Theme.of(context).textTheme.bodyText1!.color),
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: widget.height != null ? widget.height! : 20,
//                     horizontal: 12.0,
//                   ),
//                   focusedBorder: widget.setBorder
//                       ? OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                               width: 1.0,
//                               color: widget.borderColor != null
//                                   ? widget.borderColor!
//                                   : Theme.of(context).focusColor))
//                       : InputBorder.none,
//                   enabledBorder: widget.setBorder
//                       ? OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                               width: 1.0,
//                               color: widget.borderColor != null
//                                   ? widget.borderColor!
//                                   : Theme.of(context).focusColor))
//                       : InputBorder.none,
//                   border: widget.setBorder
//                       ? OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                               width: 1.0,
//                               color: widget.borderColor != null
//                                   ? widget.borderColor!
//                                   : Theme.of(context).focusColor))
//                       : InputBorder.none,
//                   disabledBorder: widget.setBorder
//                       ? OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide:
//                               BorderSide(width: 1.0, color: Color(0xffcacaca)))
//                       : InputBorder.none,
//                   counterText: "",
//                   labelText: widget.hint,
//                   errorText: widget.errorText,
//                   errorStyle: TextStyle(
//                     color: Colors.redAccent,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.normal,
//                     fontSize: widget.size,
//                   ),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide:
//                           BorderSide(width: 1.0, color: Color(0xffff0000)))),
//           style: TextStyle(
//             color: widget.color != null
//                 ? widget.color
//                 : Theme.of(context).textTheme.bodyText1!.color,
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.normal,
//             fontSize: widget.size,
//           ),
//         ),
//         widget.obscureIcon == null
//             ? Container()
//             : Positioned(right: 0.0, top: 5.0, child: widget.obscureIcon!),
//         Positioned(
//           top: 15,
//           right: 10,
//           child: !widget.showObscureIcon
//               ? Container()
//               : Material(
//                   color: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50.0)),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(50.0),
//                     onTap: () {
//                       setState(() {
//                         _isVisibility = !_isVisibility;
//                         print("$_isVisibility");
//                       });
//                     },
//                     child: Container(
//                       width: 30.0,
//                       child: Icon(
//                         _isVisibility ? Icons.visibility_off : Icons.visibility,
//                         color: Theme.of(context).focusColor,
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }

class EditTextBordered extends StatefulWidget {
  final String? hint, errorText;
  final double? size, height, width;
  final FontWeight? hintWeight;
  final Color? color,
      hintColor,
      borderColor,
      fillColor,
      focusColor,
      obscureColor;
  final int? maxLength;
  final int maxLines;
  final bool? obscureText;
  final bool? enabled, autoFocus;
  final bool? setBorder, setDecoration, filled;
  final bool showObscureIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChange, onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final Widget? obscureIcon;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;

  EditTextBordered({
    Key? key,
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
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.textInputAction,
    this.borderColor,
    this.controller,
    this.obscureIcon,
    this.showObscureIcon = false,
    this.enabled,
    this.setBorder = true,
    this.setDecoration = true,
    this.errorText,
    this.textCapitalization,
    this.prefix,
    this.autoFocus = false,
    this.inputFormatters,
    this.fillColor,
    this.filled,
    this.focusColor,
    this.height,
    this.width,
    this.inputBorder,
    this.obscureColor,
    this.hintWeight,
  }) : super(key: key);

  @override
  EditTextBorderedState createState() => EditTextBorderedState();
}

class EditTextBorderedState extends State<EditTextBordered> {
  bool _isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1, 0),
      children: <Widget>[
        TextFormField(
          enabled: widget.enabled ?? true,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: widget.obscureText == null ? false : _isVisibility,
          // onFieldSubmitted: widget.onSubmitted, ///For TextFormField
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus!,
          textAlign:
              widget.textAlign == null ? TextAlign.left : widget.textAlign!,
          keyboardType: widget.keyboardType,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,

          ///Last
          decoration: InputDecoration(
            border:
                widget.inputBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.black,
                  ),
                ),
            enabledBorder:
                widget.inputBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.black,
                  ),
                ),
            focusedBorder:
                widget.inputBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.black,
                  ),
                ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusColor: widget.focusColor,
            filled: widget.filled,
            fillColor: widget.fillColor,
            hintStyle: TextStyle(
              inherit: false,
              fontSize: widget.size,
              color:
                  widget.hintColor != null
                      ? widget.hintColor
                      : Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: widget.hintWeight,
            ),
            counterText: "",
            alignLabelWithHint: true,
            hintText: widget.hint,
            // focusedBorder: InputBorder.none,
            // enabledBorder: InputBorder.none,
            // border: InputBorder.none,
            errorText: widget.errorText,
            errorStyle: TextStyle(
              color: Colors.red,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: widget.size,
            ),
            prefix: widget.prefix,
          ),

          ///Old
          // : InputDecoration(
          //     focusColor: widget.focusColor,
          //     filled: widget.filled,
          //     fillColor: widget.fillColor,
          //     labelStyle: TextStyle(
          //         inherit: false,
          //         fontFamily: 'Roboto',
          //         fontWeight: FontWeight.normal,
          //         fontSize: widget.size,
          //         color: widget.hintColor != null
          //             ? widget.hintColor
          //             : Theme.of(context).textTheme.bodyText1?.color),
          //     contentPadding: EdgeInsets.symmetric(
          //       vertical: widget.height != null ? widget.height! : 20,
          //       horizontal: widget.width != null ? widget.width! : 12.0,
          //     ),
          //     focusedBorder: widget.setBorder == true
          //         ? OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //             borderSide: BorderSide(
          //                 width: 1.0,
          //                 color: widget.borderColor != null
          //                     ? widget.borderColor!
          //                     : Theme.of(context).secondaryHeaderColor
          //                 // : Theme.of(context).accentColor
          //                 ))
          //         : InputBorder.none,
          //     enabledBorder: widget.setBorder == true
          //         ? OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //             borderSide: BorderSide(
          //                 width: 1.0,
          //                 color: widget.borderColor != null
          //                     ? widget.borderColor!
          //                     : Colors.black
          //                 // : Theme.of(context).accentColor
          //                 ))
          //         : InputBorder.none,
          //     border: widget.setBorder == true
          //         ? OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //             borderSide: BorderSide(
          //                 width: 1.0,
          //                 color: widget.borderColor != null
          //                     ? widget.borderColor!
          //                     : Theme.of(context).colorScheme.secondary))
          //         : InputBorder.none,
          //     disabledBorder: widget.setBorder == true
          //         ? OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //             borderSide:
          //                 BorderSide(width: 1.0, color: Color(0xffcacaca)))
          //         : InputBorder.none,
          //     counterText: "",
          //     labelText: widget.hint,
          //     errorText: widget.errorText,
          //     errorStyle: TextStyle(
          //       color: Colors.redAccent,
          //       fontFamily: 'Roboto',
          //       fontWeight: FontWeight.normal,
          //       fontSize: widget.size,
          //     ),
          //     errorBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //         borderSide:
          //             BorderSide(width: 1.0, color: Color(0xffff0000)))),
          style: TextStyle(
            color:
                widget.color != null
                    ? widget.color
                    : Theme.of(context).textTheme.bodyLarge!.color,
            fontFamily: 'Roboto',
            // fontWeight: FontWeight.normal,
            fontWeight: FontWeight.bold,
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
              !widget.showObscureIcon
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
                      child: Container(
                        width: 30.0,
                        child: Icon(
                          _isVisibility
                              ? Icons.visibility_off
                              : Icons.visibility,
                          // color: Theme.of(context).accentColor,
                          color:
                              widget.obscureColor ??
                              // Theme.of(context).secondaryHeaderColor,
                              Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}

class TextFormBordered extends StatefulWidget {
  final String? hint, errorText;
  final double? size, height;
  final Color? color, hintColor, borderColor;
  final int? maxLength;
  final int maxLines;
  final bool? obscureText;
  final bool? enabled, autoFocus;
  final bool setBorder, setDecoration;
  final bool showObscureIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChange, validator;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final Widget? obscureIcon;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;

  TextFormBordered({
    Key? key,
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
  }) : super(key: key);

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
          enabled: widget.enabled == null ? true : widget.enabled,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: widget.obscureText == null ? false : _isVisibility,
          validator: widget.validator as String? Function(String?)?,
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus!,
          textAlign:
              widget.textAlign == null ? TextAlign.left : widget.textAlign!,
          keyboardType: widget.keyboardType,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          decoration:
              !widget.setDecoration
                  ? InputDecoration(
                    hintStyle: TextStyle(
                      inherit: false,
                      fontSize: widget.size,
                      color:
                          widget.hintColor != null
                              ? widget.hintColor
                              : Theme.of(context).textTheme.bodyLarge!.color,
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
                          widget.hintColor != null
                              ? widget.hintColor
                              : Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.height != null ? widget.height! : 20,
                      horizontal: 12.0,
                    ),
                    focusedBorder:
                        widget.setBorder
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).focusColor,
                              ),
                            )
                            : InputBorder.none,
                    enabledBorder:
                        widget.setBorder
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).focusColor,
                              ),
                            )
                            : InputBorder.none,
                    border:
                        widget.setBorder
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 1.0,
                                color:
                                    widget.borderColor != null
                                        ? widget.borderColor!
                                        : Theme.of(context).focusColor,
                              ),
                            )
                            : InputBorder.none,
                    disabledBorder:
                        widget.setBorder
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
            color:
                widget.color != null
                    ? widget.color
                    : Theme.of(context).textTheme.bodyLarge!.color,
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
              !widget.showObscureIcon
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
                      child: Container(
                        width: 30.0,
                        child: Icon(
                          _isVisibility
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).focusColor,
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
  final String? text;
  final double? size, _size, textScaleFactor;
  final Color? color;
  final int? maxLines;
  final double? lineSpacing;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  TextView(
    this.text, {
    Key? key,
    this.size,
    this.textAlign,
    this.color,
    this.textScaleFactor,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.lineSpacing,
    this.decoration,
  }) : _size = size == null ? 12.0 : size,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign != null ? textAlign : TextAlign.start,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        letterSpacing: 1.2,
        decoration: decoration,
        height: lineSpacing,
        color:
            color != null
                ? color
                : Theme.of(context).textTheme.bodyLarge!.color,
        textBaseline: TextBaseline.alphabetic,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
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
    Key? key,
    this.decoration,
    this.lineSpacing,
    this.color,
    this.fontWeight,
    this.size,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          //          letterSpacing: 1.2,
          decoration: decoration,
          height: lineSpacing,
          color:
              color != null
                  ? color
                  : Theme.of(context).textTheme.bodyLarge!.color,
          textBaseline: TextBaseline.alphabetic,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          fontFamily: 'Roboto',
          fontSize: size,
        ),
        children: children,
      ),
    );
  }
}

// class CustomRaisedButton extends StatefulWidget {
//   final bool loadingValue;
//   final Function? onPressed;
//   final String buttonText;
//   final double? textSize;
//   final ShapeBorder? shape;
//   final EdgeInsetsGeometry? buttonPadding;
//
//   const CustomRaisedButton({
//     Key? key,
//     this.loadingValue = false,
//     required this.onPressed,
//     required this.buttonText,
//     this.shape,
//     this.buttonPadding,
//     this.textSize,
//   }) : super(key: key);
//
//   @override
//   _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
// }
//
// class _CustomRaisedButtonState extends State<CustomRaisedButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Theme.of(context).cardColor,
//         disabledBackgroundColor: Theme.of(context).cardColor,
//         padding: widget.buttonPadding ?? EdgeInsets.symmetric(vertical: 20.0),
//         // shape: widget.shape,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.0),
//           ),
//         ),
//       ),
//       onPressed: widget.onPressed == null ? null : () => widget.onPressed!(),
//       // widget.loadingValue ? null : (widget.onPressed as void Function()?),
//       child: widget.loadingValue
//           ? SizedBox(
//               height: 20.0,
//               width: 20.0,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation(Colors.white),
//                 semanticsLabel: "Loading",
//               ),
//             )
//           : TextView(
//               widget.buttonText,
//               color: Colors.white,
//               size: widget.textSize ?? 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//     );
//   }
// }

class CustomRaisedButton extends StatefulWidget {
  final bool loadingValue;
  final Function? onPressed;
  final String buttonText;
  final double? textSize;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? buttonPadding;

  const CustomRaisedButton({
    Key? key,
    this.loadingValue = false,
    required this.onPressed,
    required this.buttonText,
    this.shape,
    this.buttonPadding,
    this.textSize,
  }) : super(key: key);

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
        // shape: widget.shape,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      onPressed:
          widget.loadingValue ? null : widget.onPressed as void Function()?,
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
                widget.buttonText,
                color: Colors.white,
                size: widget.textSize ?? 18.0,
                fontWeight: FontWeight.bold,
              ),
    );
  }
}
