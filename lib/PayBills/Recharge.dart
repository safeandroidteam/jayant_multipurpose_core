import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/bloc.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recharge extends StatefulWidget {
  final String title;

  const Recharge({Key? key, required this.title}) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  double? amtBoxSize = 70.0, _minRechargeAmt = 0.0, _maxRechargeAmt = 0.0;
  int payModeGroupValue = 0;
  String? userName,
      userAcc = "",
      userId,
      userBal = "",
      _hint = "",
      _errorhint = "",
      operatorName = "",
      operatorId = "";
  bool accNoVal = false, nameVal = false, amtVal = false, isProcessing = false;
  List? paymentType = [], operators;
  List<String> accNos = [];
  Map? sendOTPParams;
  Future<Map?>? _future;
  GlobalKey _mobKey = GlobalKey(), _amtKey = GlobalKey();
  TransferBloc _transferBloc = TransferBloc(
    initialState: LoadingTransferState(),
  );
  FocusNode _mobFocusNode = FocusNode(), _amtFocusNode = FocusNode();
  SharedPreferences? preferences;
  ScrollController _customScrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController mob = TextEditingController(),
      amt = TextEditingController();

  int count = 0;

  var _operator = <String>[];
  var _operatorId = <String>[];

  String? str_OrderId = "", str_Message = "", str_Status = "", str_Otp = "";

  Map<String, dynamic>? _referanceNo = Map();

  @override
  void dispose() {
    _transferBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    // listen to focus changes
    loadData();
    /*   _hint =
        "${widget.title.trim().toLowerCase().contains("mobile") ? "Enter pre-paid mobile no" : "Enter Customer ID"}";*/
    _hint =
        "${widget.title.trim().toLowerCase().contains("mobile")
            ? "Enter mobile no"
            : widget.title.trim().toLowerCase().contains("postpaid")
            ? "Enter mobile no"
            : widget.title.trim().toLowerCase().contains("dth")
            ? "Enter Subscriber Code"
            : widget.title.trim().toLowerCase().contains("Electricity")
            ? "Enter Consumer Number"
            : "Enter Consumer Number"}";

    _errorhint =
        "${widget.title.trim().toLowerCase().contains("mobile")
            ? "Enter mobile no"
            : widget.title.trim().toLowerCase().contains("postpaid")
            ? "Enter mobile no"
            : widget.title.trim().toLowerCase().contains("dth")
            ? "Enter Subscriber Code"
            : widget.title.trim().toLowerCase().contains("Electricity")
            ? "Enter Consumer Number"
            : "Enter Consumer Number"}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _customScrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width,
                  pinned: true,
                  stretch: true,
                  centerTitle: true,
                  elevation: 3.0,
                  title: Container(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            /*widget.title.toLowerCase().contains("mobile")
                                    ? "assets/recharge.png"
                                    : "assets/dishTv.png",*/
                            widget.title.toLowerCase().contains("mobile")
                                ? "assets/sim_card.png"
                                : widget.title.toLowerCase().contains(
                                  "postpaid",
                                )
                                ? "assets/sim_card.png"
                                : widget.title.toLowerCase().contains("dth")
                                ? "assets/dishTv.png"
                                : widget.title.toLowerCase().contains(
                                  "electricity",
                                )
                                ? "assets/electricity.png"
                                : "assets/water.png",
                            color: Colors.white,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                    ],
                    background: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextView(
                          "To ${mob.text.isEmpty ? "____" : mob.text}",
                          color: Colors.white,
                          size: 16.0,
                        ),
                        SizedBox(height: 10.0),
                        TextView(operatorName, color: Colors.white),
                        SizedBox(
                          key: _amtKey,
                          width: amtBoxSize,
                          child: EditTextBordered(
                            controller: amt,
                            hint: "0",
                            keyboardType: TextInputType.number,
                            color: Colors.white,
                            maxLength: 8,
                            maxLines: 1,
                            focusNode: _amtFocusNode,
                            hintColor: Colors.white60,
                            size: 56,
                            setDecoration: false,
                            setBorder: false,
                            borderColor: Colors.transparent,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            prefix: TextView(
                              StaticValues.rupeeSymbol,
                              size: 24,
                              color: Colors.white,
                            ),
                            onChange: (value) {
                              setState(() {
                                amtVal = value.isEmpty || int.parse(value) < 1;
                                amtBoxSize =
                                    70 + (value.length * 25).toDouble();
                                print(amtBoxSize);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextView(
                          "Minimum amount ${StaticValues.rupeeSymbol} $_minRechargeAmt",
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20.0),
                        TextView(userBal, size: 24, color: Colors.greenAccent),
                        SizedBox(height: 10.0),
                        TextView("Available Balance", color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Map?>(
                            future: _future,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              operators = snapshot.data!["Table"];
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 16.0),
                                  EditTextBordered(
                                    key: _mobKey,
                                    //  enabled: operatorName.isNotEmpty,
                                    controller: mob,
                                    /*     hint: operatorName.isNotEmpty
                                            ? _changeHint(operatorName)
                                            : _hint,
                                        errorText: operatorName.isNotEmpty
                                            ? validateNumber(
                                            operatorName, mob.text)
                                            : null,*/
                                    hint: _hint,
                                    errorText: null,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    focusNode: _mobFocusNode,
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (string) {
                                      _mobFocusNode.unfocus();
                                    },
                                    onChange: (value) {
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  TextView(
                                    "Select Operator",
                                    size: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff707070),
                                  ),
                                  GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1,
                                        ),
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: operators!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GlobalWidgets().btnWithText(
                                            icon: Image.asset(
                                              /*        widget.title
                                                          .toLowerCase()
                                                          .contains("mobile")
                                                      ? "assets/recharge.png"
                                                      : "assets/dishTv.png",*/
                                              widget.title
                                                      .toLowerCase()
                                                      .contains("mobile")
                                                  ? "assets/sim_card.png"
                                                  : widget.title
                                                      .toLowerCase()
                                                      .contains("postpaid")
                                                  ? "assets/sim_card.png"
                                                  : widget.title
                                                      .toLowerCase()
                                                      .contains("dth")
                                                  ? "assets/dishTv.png"
                                                  : widget.title
                                                      .toLowerCase()
                                                      .contains("electricity")
                                                  ? "assets/electricity.png"
                                                  : "assets/water.png",
                                              height: 30.0,
                                              width: 30.0,
                                              color:
                                                  operators![index]["Operater_Id"] ==
                                                          operatorId
                                                      ? Colors.green
                                                      : Theme.of(
                                                        context,
                                                      ).primaryColor,
                                            ),
                                            name:
                                                operators![index]["Operater_Name"],
                                            textColor:
                                                operators![index]["Operater_Id"] ==
                                                        operatorId
                                                    ? Colors.green
                                                    : Colors.black,
                                            onPressed: () {
                                              setState(() {
                                                operatorName =
                                                    operators![index]["Operater_Name"];
                                                operatorId =
                                                    operators![index]["Operater_Id"];
                                                print(
                                                  "OPERATOR ID : $operatorId  $operatorName",
                                                );
                                                /* Scrollable.ensureVisible(_mobKey.currentContext,
                                                        duration: Duration(milliseconds: 350),
                                                        curve: Curves.easeIn);*/
                                                _mobFocusNode.requestFocus();
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 100.0),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: BlocBuilder<TransferBloc, TransferState>(
                bloc: _transferBloc,
                builder: (context, snapshot) {
                  return CustomRaisedButton(
                    buttonText: "PROCEED",
                    // loadingValue: snapshot is LoadingTransferState,
                    loadingValue: snapshot is SendDetails,
                    onPressed: () async {
                      if (double.parse(amt.text) <= double.parse(userBal!)) {
                        if (amt.text.isNotEmpty &&
                            int.parse(amt.text) >= _minRechargeAmt! &&
                            double.parse(amt.text) <= _maxRechargeAmt!) {
                          final s = validateNumber(operatorName!, mob.text);
                          /*  if (s != null) {
                            GlobalWidgets().showSnackBar(_scaffoldKey, (s));
                            return;
                          }*/
                          if (mob.text.isEmpty) {
                            GlobalWidgets().showSnackBar(_scaffoldKey, _hint!);
                            return;
                          }
                          if (operatorName!.isEmpty) {
                            GlobalWidgets().showSnackBar(
                              _scaffoldKey,
                              ("Select an Operator"),
                            );
                            return;
                          }

                          _referanceNo = await RestAPI().get(
                            APis.generateRefID("mblRecharge"),
                          );
                          print("RechargeRef$_referanceNo");

                          var response = await RestAPI().post(
                            APis.GenerateOTP,
                            params: {
                              "MobileNo": preferences!.getString(
                                StaticValues.mobileNo,
                              ),
                              "Amt": amt.text,
                              "SMS_Module": "GENERAL",
                              "SMS_Type": "GENERAL_OTP",
                              "OTP_Return": "Y",
                            },
                          );
                          print("rechargeResponse::: $response");
                          str_Otp = response[0]["OTP"];

                          setState(() {
                            Timer(Duration(minutes: 5), () {
                              setState(() {
                                str_Otp = "";
                              });
                            });
                          });

                          _rechargeConfirmation();
                        } else {
                          _customScrollController.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                          _amtFocusNode.requestFocus();

                          GlobalWidgets().showSnackBar(
                            _scaffoldKey,
                            ("Minimum amount is ${StaticValues.rupeeSymbol}$_minRechargeAmt and Maximum amount is $_maxRechargeAmt"),
                          );
                        }
                      } else {
                        _customScrollController.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                        _amtFocusNode.requestFocus();

                        GlobalWidgets().showSnackBar(
                          _scaffoldKey,
                          ("Insufficient Balance"),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      userName = preferences?.getString(StaticValues.accName) ?? "";
      userId = preferences?.getString(StaticValues.custID) ?? "";
    });
    Map? balanceResponse = await RestAPI().get(
      APis.fetchFundTransferBal(userId),
    );
    setState(() {
      userBal = balanceResponse!["Table"][0]["BalAmt"].toString();
      userAcc = balanceResponse["Table"][0]["AccNo"].toString();
    });
    Map? transDailyLimit = await RestAPI().get(APis.checkFundTransAmountLimit);
    print("transDailyLimit::: $transDailyLimit");
    setState(() {
      _minRechargeAmt = transDailyLimit!["Table"][0]["Min_rcghbal"];
      _maxRechargeAmt = transDailyLimit["Table"][0]["Max_rcghbal"];
      //      userBal = balanceResponse["Table"][0]["BalAmt"].toString();
    });
    print(
      "Which title : ${widget.title.trim().toLowerCase().contains("mobile")}",
    );
    _future =
        widget.title.trim().toLowerCase().contains("mobile")
            ? loadMobOperators()
            : loadDTHOperators();

    if (widget.title.trim().toLowerCase().contains("mobile")) {
      _future = loadMobOperators();
    } else if (widget.title.trim().toLowerCase().contains("dth")) {
      _future = loadDTHOperators();
    } else if (widget.title.trim().toLowerCase().contains("electricity")) {
      _future = loadElectricityOperators();
    } else if (widget.title.trim().toLowerCase().contains("postpaid")) {
      _future = loadMobPostOperators();
    } else if (widget.title.trim().toLowerCase().contains("water")) {
      _future = loadWaterOperators();
    }
  }

  Future<Map?> getPaymentMode() async {
    return await RestAPI().get(APis.fetchFundTransferType);
  }

  Future<Map?> loadMobOperators() async {
    final response = await RestAPI().get(APis.rechargeOperators);
    print(response);
    return response;
  }

  Future<Map?> loadMobPostOperators() async {
    final response = await RestAPI().get(APis.mobPostpaidOperators);
    print(response);
    return response;
  }

  Future<Map?> loadDTHOperators() async {
    final response = await RestAPI().get(APis.dishTvOperators);
    print(response);
    return response;
  }

  Future<Map?> loadElectricityOperators() async {
    final response = await RestAPI().get(APis.electricityOperators);
    print(response);
    return response;
  }

  Future<Map?> loadWaterOperators() async {
    final response = await RestAPI().get(APis.waterOperators);
    print(response);
    return response;
  }

  String? validateNumber(String operatorName, String value) {
    /// in regex the first number is already taken and it is count as 1 and rest of the
    /// number will be count. For eg: airtel tv start with 3 and have only 10 digit,
    /// So in validation there have to be 10 digits so in regex we have
    /// to give as {9} instead of {10} ."^[3][0-9]{9}\$"

    switch (operatorName.trim().toLowerCase()) {
      case 'airtel tv':
        _hint = "Enter Customer ID";
        if (RegExp('^[3][0-9]{9}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid customer id";
      case 'dish tv':
        _hint = "Enter Card Number";
        if (RegExp('^[0][0-9]{10}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid card Number";
      case 'bigtv':
        _hint = "Enter Card number";
        if (RegExp('^[2][0-9]{11}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid card number";
      case 'sun':
        _hint = "Enter Card Number";
        print("Validate : ${RegExp('^[4,1][0-9]{10}\$').hasMatch(value)}");
        if (RegExp('^[4,1][0-9]{10}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid card number";
      case 'tatasky':
        _hint = "Enter Subscriber ID";
        print("Validate : ${RegExp('^[1][0-9]{9}\$').hasMatch(value)}");
        if (RegExp('^[1][0-9]{9}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid subscriber id";
      case 'videocon d2h':
        _hint = "Enter Subscriber ID";
        print("Validate : ${RegExp('^[0-9]{2,14}\$').hasMatch(value)}");
        if (RegExp('^[0-9]{2,14}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid subscriber id";

      /* default:
        _hint = "Enter pre-paid mobile no";
        print("Validate : ${RegExp('^[0-9]{10}\$').hasMatch(value)}");
        if (RegExp('^[0-9]{10}\$').hasMatch(value)) {
          return null;
        }
        return "Invalid mobile number";*/
    }
    return null;
  }

  String _changeHint(String operatorName) {
    switch (operatorName.trim().toLowerCase()) {
      case 'airtel tv':
        return _hint = "Enter Customer ID";
      case 'dish tv':
      case 'bigtv':
      case 'sun':
        return _hint = "Enter Card Number";
      case 'tatasky':
      case 'videocon d2h':
        return _hint = "Enter Subscriber ID";
      default:
        return _hint = "Enter no";
    }
  }

  void _rechargeConfirmation() {
    var isLoading = false;
    var _pass;
    var _otp;
    GlobalWidgets().billPaymentModal(
      context,
      getValue: (passVal) {
        setState(() {
          _pass = passVal;
        });
      },
      getValue1: (otpVal) {
        setState(() {
          _otp = otpVal;
        });
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView("${StaticValues.rupeeSymbol}${amt.text}", size: 24.0),
          SizedBox(height: 10.0),
          TextView("Pay from : $userAcc", size: 14.0),
          SizedBox(height: 10.0),
          TextView("${_hint!.substring(6)}: ${mob.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView("Operator : $operatorName", size: 14.0),
          SizedBox(height: 30.0),
        ],
      ),
      actionButton: StatefulBuilder(
        builder:
            (context, setState) => CustomRaisedButton(
              loadingValue: isLoading,
              buttonText: "PAY",
              onPressed:
                  isLoading
                      ? () {}
                      : () async {
                        print("passVal $_pass");
                        if (_otp == str_Otp) {
                          if (_pass != null &&
                              _pass ==
                                  preferences!.getString(
                                    StaticValues.userPass,
                                  )) {
                            count = count + 1;

                            String count1 = count.toString();
                            print("count////// $count1");
                            /*  Map<String, String> params = {
                        "AccNo": userAcc,
                        "MobileNo": mob.text,
                        "Provider": operatorId,
                        "Amount": amt.text,
                        "RefNo": _referanceNo["Table"][0]["Tran_No"]
                      };*/

                            //   print("object////// $params");
                            print("LIJITH");
                            //   getMobileRecharge();
                            setState(() {
                              isLoading = true;
                            });

                            if (count == 1) {
                              try {
                                var response = await RestAPI().post(
                                  APis.mobileRecharge,
                                  params: {
                                    "accno": userAcc,
                                    "number": mob.text,
                                    "amount": amt.text,
                                    "provider_id": operatorId,
                                    //  "provider_id": "1",
                                    "client_id":
                                        _referanceNo!["Table"][0]["Tran_No"],
                                  },
                                );
                                print("rechargeResponse::: $response");
                                str_OrderId = response[0]["orderId"];
                                str_Message = response[0]["message"];
                                str_Status = response[0]["status"];
                                print("MESSAGE : ${str_Status}");

                                //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str_Message)));
                                //  RestAPI().get(APis.rechargeMobile(params));
                                /*    Map response =
                            await RestAPI().get(APis.rechargeMobile(params));*/
                                //   getMobileRecharge();
                                setState(() {
                                  isLoading = false;
                                });
                                if (response[0]["status"]
                                        .toString()
                                        .toLowerCase() !=
                                    "failed") {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Receipt(
                                            pushReplacementName: "/HomePage",
                                            amount: amt.text,
                                            transID:
                                                response[0]["orderId"]
                                                    .toString(),
                                            paidTo: operatorName,
                                            accTo: "",
                                            accFrom: userAcc,
                                            message:
                                                ("${response[0]["status"]} : ${response[0]["message"]}"),
                                          ),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Receipt(
                                            isFailure: true,
                                            pushReplacementName: "/HomePage",
                                            amount: amt.text,
                                            paidTo: operatorName,
                                            accTo: "",
                                            accFrom: userAcc,
                                            message:
                                                ("${response[0]["status"]} : ${response[0]["message"]}"),
                                          ),
                                    ),
                                  );
                                }
                              } on RestException catch (e) {
                                GlobalWidgets().showSnackBar(
                                  _scaffoldKey,
                                  e.message,
                                );
                              }
                            } else {
                              return null;
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Password is incorrect",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "OTP Miss Match",
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

  /*
  void rechargeConfirm() {
    GlobalWidgets().dialogTemplate(
        context: context,
        barrierDismissible: false,
        title: "Recharge",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              "${StaticValues.rupeeSymbol}${amt.text}",
              size: 24.0,
            ),
            TextView(
              mob.text,
              size: 18.0,
            ),
            TextView(
              operatorName,
              size: 18.0,
            ),
          ],
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context),
              child: TextView(
                "Cancel",
                color: Theme.of(context).primaryColor,
              )),
          StatefulBuilder(
            builder: (context, setState) {
              return CustomRaisedButton(
                buttonText: "Recharge",
                textSize: 14.0,
                buttonPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                loadingValue: _isRechargeLoading,
                onPressed: () async {
                  Map<String, String> params = {
                    "AccNo": userAcc,
                    "MobileNo": mob.text,
                    "Provider": operatorId,
                    "Amount": amt.text,
                  };
                  setState(() {
                    _isRechargeLoading = true;
                  });
                  try {
                    Map response = await RestAPI().get(APis.rechargeMobile(params));
                    setState(() {
                      _isRechargeLoading = false;
                    });
                    Navigator.of(context).pop();
                    rechargeStatus(response);
                  } on RestException catch (e) {
                    GlobalWidgets().showSnackBar(_scaffoldKey, e.message);
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              );
            },
          )
        ]);
  }
*/
  /*  void rechargeStatus(Map<String, dynamic> response) {
    GlobalWidgets().dialogTemplate(
        barrierDismissible: false,
        context: context,
        title: "${response["Table"][0]["status"].toString()} #${response["Table"][0]["orderId"]}",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              "${StaticValues.rupeeSymbol}${amt.text}",
              size: 24.0,
            ),
            TextView(
              mob.text,
              size: 18.0,
            ),
            TextView(
              operatorName,
              size: 18.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextView(
              response["Table"][0]["message"],
            ),
          ],
        ),
        actions: [
          CustomRaisedButton(
            buttonText: "Okay",
            loadingValue: false,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: "/HomePage",
              ));
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          )
        ]);
  }*/
}
