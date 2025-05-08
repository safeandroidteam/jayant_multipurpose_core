import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/bloc.dart';
import 'package:passbook_core_jayant/MainScreens/home_page.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/passbook_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KSEBNKWA extends StatefulWidget {
  final String title;

  const KSEBNKWA({Key? key, required this.title}) : super(key: key);

  @override
  _KSEBNKWAState createState() => _KSEBNKWAState();
}

class _KSEBNKWAState extends State<KSEBNKWA> {
  TextEditingController consumerNo = TextEditingController(),
      mobNo = TextEditingController(),
      name = TextEditingController(),
      amt = TextEditingController(),
      accNo = TextEditingController();
  bool amtVal = false;
  double amtBoxSize = 70.0;
  String? userName, userId, userBal = "";
  TransferBloc _transferBloc = TransferBloc();
  FocusNode _mobFocusNode = FocusNode();
  SharedPreferences? preferences;
  ScrollController _customScrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isProcessing = false;
  Map? sendOTPParams;
  double? _minRechargeAmt = 0.0, _maxRechargeAmt = 0.0;
  final _formKey = GlobalKey<FormState>();

  String? str_OrderId, str_Message, str_Status;

  Map<String, dynamic>? _referanceNo = Map();
 
  @override
  void dispose() {
    _transferBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        //  widget.title == "KSEB"
                        widget.title == "Dakshin Haryana Bijili Vitran Nigam"
                            ? "assets/electricity.png"
                            : "assets/water.png",

                        color: Colors.white,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Text(widget.title, style: TextStyle(color: Colors.white)),
                  ],
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  stretchModes: [
                    StretchMode.fadeTitle,
                    StretchMode.blurBackground,
                  ],
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.0),
                      TextView(
                        text:
                            "Consumer number\n${consumerNo.text.isEmpty ? "____" : consumerNo.text}",
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        size: 16.0,
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: amtBoxSize,
                        child: EditTextBordered(
                          controller: amt,
                          hint: "0",
                          keyboardType: TextInputType.number,
                          color: Colors.white,
                          autoFocus: true,
                          focusNode: _mobFocusNode,
                          maxLength: 8,
                          maxLines: 1,
                          hintColor: Colors.white60,
                          size: 56,
                          setDecoration: false,
                          setBorder: false,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.words,
                          prefix: TextView(
                            text: StaticValues.rupeeSymbol,
                            size: 24,
                            color: Colors.white,
                          ),
                          onChange: (value) {
                            setState(() {
                              amtVal = value.isEmpty || int.parse(value) < 1;
                              amtBoxSize = 70 + (value.length * 25).toDouble();
                              print(amtBoxSize);
                            });
                          },
                        ),
                      ),
                      TextView(
                        text:
                            "Minimum amount ${StaticValues.rupeeSymbol} $_minRechargeAmt",
                        size: 10,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20.0),
                      TextView(
                        text: userBal ?? "",
                        size: 24,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(height: 10.0),
                      TextView(text: "Available Balance", color: Colors.white),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: Column(
                        children: [
                          TextFormBordered(
                            enabled: false,
                            controller: accNo,
                            hint: "A/c No",
                            keyboardType: TextInputType.number,
                            validator: (string) {
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormBordered(
                            controller: name,
                            hint: "Enter name",
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            validator: (string) {
                              return string!.isEmpty ? "Invalid name" : null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormBordered(
                            controller: consumerNo,
                            hint: "Enter consumer no.",
                            keyboardType: TextInputType.number,
                            /*validator: (string) {
                                return string.trim().length < 13
                                    ? "Consumer number is invalid"
                                    : null;
                              },*/
                            onChange: (value) {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormBordered(
                            controller: mobNo,
                            hint: "Enter mobile no.",
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            validator: (string) {
                              return string!.trim().length != 10
                                  ? "Mobile number is invalid"
                                  : null;
                            },
                          ),
                          SizedBox(height: 100.0),
                        ],
                      ),
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
                  loadingValue: snapshot is LoadingTransferState,
                  onPressed: () async {
                    if (amt.text.isNotEmpty &&
                        int.parse(amt.text) >= _minRechargeAmt! &&
                        double.parse(amt.text) <= _maxRechargeAmt!) {
                      if (_formKey.currentState!.validate()) {
                        if (widget.title == "KWA") {
                          kwaConfirmation();
                          _referanceNo = await RestAPI().get(
                            APis.generateRefID("kwaRefNo"),
                          );
                          // _scaffoldKey.currentState!.showSnackBar(
                          ScaffoldMessenger.of(
                            _scaffoldKey.currentState!.context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                _referanceNo!["Table"][0]["Tran_No"],
                              ),
                            ),
                          );
                        } else {
                          ksebConfirmation();
                          _referanceNo = await RestAPI().get(
                            APis.generateRefID("ksebRefNo"),
                          );
                          // _scaffoldKey.currentState!.showSnackBar(
                          ScaffoldMessenger.of(
                            _scaffoldKey.currentState!.context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                _referanceNo!["Table"][0]["Tran_No"],
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      GlobalWidgets().showSnackBar(
                        context,
                        ("Minimum amount is ${StaticValues.rupeeSymbol}$_minRechargeAmt and Maximum amount is $_maxRechargeAmt"),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
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
      accNo.text = balanceResponse["Table"][0]["AccNo"].toString();
    });
    Map? transDailyLimit = await RestAPI().get(APis.checkFundTransAmountLimit);
    print("transDailyLimit::: $transDailyLimit");
    setState(() {
      _minRechargeAmt = transDailyLimit!["Table"][0]["Min_rcghbal"];
      _maxRechargeAmt = transDailyLimit["Table"][0]["Max_rcghbal"];
      //      userBal = balanceResponse["Table"][0]["BalAmt"].toString();
    });
  }

  void ksebConfirmation() {
    var isLoading = false;
    var _pass;
    GlobalWidgets().billPaymentModal(
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
          TextView(text: "${StaticValues.rupeeSymbol}${amt.text}", size: 24.0),
          SizedBox(height: 10.0),
          TextView(text: "A/c No : ${accNo.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Name : ${name.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Consumer No: ${consumerNo.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Mob no: ${mobNo.text}", size: 14.0),
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
                        if (_pass != null &&
                            _pass ==
                                preferences!.getString(StaticValues.userPass)) {
                          Map<String, String?> params = {
                            "AccNo": accNo.text,
                            "ContactMobile": mobNo.text,
                            "CustName": name.text,
                            "Amount": amt.text,
                            "ConsumerNo": consumerNo.text,
                            "RefNo": _referanceNo!["Table"][0]["Tran_No"],
                          };

                          print("object////// $params");
                          setState(() {
                            isLoading = true;
                          });
                          /*try {
                        //  RestAPI().post<Map>(APis.payKSEB(params));
                        Map response =
                            await RestAPI().post<Map>(APis.payKSEB(params));
                        setState(() {
                          isLoading = false;
                        });
                        if (response["Table"][0]["Status"]
                                .toString()
                                .toLowerCase() !=
                            "failure") {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Receipt(
                                pushReplacementName: "/HomePage",
                                amount: amt.text,
                                transID:
                                    response["Table"][0]["orderId"].toString(),
                                paidTo: "KSEB",
                                accTo: "",
                                accFrom: accNo.text,
                                message: response["Table"][0]["Message"],
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Receipt(
                                isFailure: true,
                                pushReplacementName: "/HomePage",
                                amount: amt.text,
                                paidTo: "KSEB",
                                accTo: "",
                                accFrom: accNo.text,
                                message:
                                    ("${response["Table"][0]["status"]} : ${response["Table"][0]["Message"]}"),
                              ),
                            ),
                          );
                        }
                      }*/
                          try {
                            var response = await RestAPI().post(
                              APis.mobileRecharge,
                              params: {
                                "accno": accNo.text,
                                "number": consumerNo.text,
                                "amount": amt.text,
                                "provider_id":
                                    widget.title ==
                                            "Dakshin Haryana Bijili Vitran Nigam"
                                        ? "131"
                                        : "212",
                                //  "provider_id": "1",
                                "client_id":
                                    _referanceNo!["Table"][0]["Tran_No"],
                              },
                            );
                            print("rechargeResponse::: $response");
                            str_OrderId = response[0]["orderId"];
                            str_Message = response[0]["message"];
                            str_Status = response[0]["status"];
                            print("MESSAGE : ${str_Message}");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(str_Message!)),
                            );
                            //  RestAPI().get(APis.rechargeMobile(params));
                            /*    Map response =
                            await RestAPI().get(APis.rechargeMobile(params));*/
                            //   getMobileRecharge();
                            setState(() {
                              isLoading = false;
                            });
                            if (response[0]["message"]
                                    .toString()
                                    .toLowerCase() !=
                                "failure") {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder:
                                      (context) => Receipt(
                                        pushReplacementNamed:
                                        "/HomePage",

                                        amount: amt.text,
                                        transID:
                                            response[0]["orderId"].toString(),
                                        paidTo: widget.title,
                                        accTo: "",
                                        accFrom: accNo.text,
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
                                        pushReplacementNamed:
                                           "/HomePage",

                                        amount: amt.text,
                                        paidTo: widget.title,
                                        accTo: "",
                                        accFrom: accNo.text,
                                        message:
                                            ("${response[0]["status"]} : ${response[0]["message"]}"),
                                      ),
                                ),
                              );
                            }
                          } on RestException catch (e) {
                            GlobalWidgets().showSnackBar(context, e.message);
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Incorrect password",
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

  void kwaConfirmation() {
    var isLoading = false;
    var _pass;
    GlobalWidgets().billPaymentModal(
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
          TextView(text: "${StaticValues.rupeeSymbol}${amt.text}", size: 24.0),
          SizedBox(height: 10.0),
          TextView(text: "A/c No : ${accNo.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Name : ${name.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Consumer No: ${consumerNo.text}", size: 14.0),
          SizedBox(height: 10.0),
          TextView(text: "Mob no: ${mobNo.text}", size: 14.0),
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
                        if (_pass != null &&
                            _pass ==
                                preferences!.getString(StaticValues.userPass)) {
                          Map<String, String?> params = {
                            "AccNo": accNo.text,
                            "ContactMobile": mobNo.text,
                            "CustId": preferences!.getString(
                              StaticValues.custID,
                            ),
                            "Amount": amt.text,
                            "ConsumerNo": consumerNo.text,
                            "Remarks": "",
                            "RefNo": _referanceNo!["Table"][0]["Tran_No"],
                          };

                          print("object////// $params");
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            //   RestAPI().post<Map>(APis.payKWA(params));
                            Map response =
                                await (RestAPI().post<Map>(APis.payKWA(params))
                                    as FutureOr<Map<dynamic, dynamic>>);
                            setState(() {
                              isLoading = false;
                            });
                            if (response["Table"][0]["status"]
                                    .toString()
                                    .toLowerCase() !=
                                "failure") {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder:
                                      (context) => Receipt(
                                        pushReplacementNamed:
                                         "/HomePage",

                                        amount: amt.text,
                                        transID:
                                            response["Table"][0]["orderId"]
                                                .toString(),
                                        paidTo: "KWA",
                                        accTo: "",
                                        accFrom: accNo.text,
                                        message:
                                            response["Table"][0]["message"],
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
                                        pushReplacementNamed:
                                          "/HomePage",

                                        amount: amt.text,
                                        paidTo: "KWA",
                                        accTo: "",
                                        accFrom: accNo.text,
                                        message:
                                            ("${response["Table"][0]["status"]} : ${response["Table"][0]["message"]}"),
                                      ),
                                ),
                              );
                            }
                          } on RestException catch (e) {
                            GlobalWidgets().showSnackBar(context, e.message);
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
                      },
            ),
      ),
    );
  }
}
