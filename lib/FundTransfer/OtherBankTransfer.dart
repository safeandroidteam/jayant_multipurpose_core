import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/beneficiaryResModal.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/FundTransfer/FundTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';

import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherBankTransfer extends StatefulWidget {
  final BeneficiaryDatum peopleTable;

  const OtherBankTransfer({super.key, required this.peopleTable});

  @override
  _OtherBankTransferState createState() => _OtherBankTransferState();
}

class _OtherBankTransferState extends State<OtherBankTransfer> {
  TextEditingController mob = TextEditingController(),
      accNo = TextEditingController(),
      name = TextEditingController(),
      amt = TextEditingController();
  List paymentType = [];
  bool mobVal = false, accNoVal = false, nameVal = false, amtVal = false;
  List<String> accNos = [];
  double amtBoxSize = 70.0;
  int payModeGroupValue = 0;
  String selectedPaymentMode = "";
  String userName = "", userAcc = "", userId = "", userBal = "";
  GlobalKey toKey = GlobalKey();
  final TransferBloc _transferBloc = TransferBloc();
  double _minTransferAmt = 0.0, _maxTransferAmt = 0.0;
  final FocusNode _mobFocusNode = FocusNode();
  late SharedPreferences preferences;
  final ScrollController _customScrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool isProcessing = false;

  Map<String, dynamic> sendOTPParams = {};

  bool _isLoading = false;

  Map<String, dynamic> _referenceNo = {};
  List fromAc = [];
  String acType = "";
  int fromGroupValue = 0;
  @override
  void dispose() {
    _transferBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    // listen to focus changes
    loadData();

    _mobFocusNode.addListener(() {
      customPrint(
        'focusNode updated: hasFocus: ${_mobFocusNode.hasFocus}  ${MediaQuery.of(context).viewInsets.bottom}',
      );
      if (_mobFocusNode.hasFocus &&
          MediaQuery.of(context).viewInsets.bottom == 0.0)
        Scrollable.ensureVisible(
          toKey.currentContext!,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transferBloc = TransferBloc.get(context);
    return WillPopScope(
      onWillPop: () async {
        print("tsdknfbsldkj l;kndsfa;ln");
        if (!_mobFocusNode.hasPrimaryFocus) {
          _mobFocusNode.unfocus();
        }
        return true;
      },
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
                  centerTitle: true,
                  expandedHeight: MediaQuery.of(context).size.width / .8,
                  pinned: true,
                  stretch: true,
                  title: Text("Other Bank Transfer"),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, size: 30.0),
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
                        Card(
                          elevation: 6.0,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/otherBankTransfer.png",
                              height: 30.0,
                              width: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        TextView(
                          text:
                              "Paying ${widget.peopleTable.recieverName.isEmpty ? "____" : widget.peopleTable.recieverName}",
                          color: Colors.white,
                        ),
                        TextView(
                          text: widget.peopleTable.recieverAccno,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: amtBoxSize,
                          child: EditTextBordered(
                            controller: amt,
                            hint: "0",
                            keyboardType: TextInputType.number,
                            color: Colors.white,
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
                                amtBoxSize =
                                    70 + (value.length * 25).toDouble();
                                print(amtBoxSize);
                              });
                            },
                          ),
                        ),
                        TextView(
                          text:
                              "Minimum amount ${StaticValues.rupeeSymbol} $_minTransferAmt",
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20.0),
                        TextView(
                          text: userBal,
                          size: 24,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(height: 10.0),
                        TextView(
                          text: "Available Balance",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          TextView(
                            text: "Payment Mode",
                            size: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20.0),
                          BlocBuilder<TransferBloc, TransferState>(
                            buildWhen:
                                (previous, current) =>
                                    current is FetchFundTransferTypeLoading ||
                                    current is FetchFundTransferTypeResponse ||
                                    current is FetchFundTransferTypeError,
                            builder: (context, state) {
                              customPrint("state is ==$state");
                              if (state is FetchFundTransferTypeLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state
                                  is FetchFundTransferTypeResponse) {
                                if (state.transferTypeList.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.transferTypeList.length,
                                    itemBuilder: (context, index) {
                                      selectedPaymentMode =
                                          state
                                              .transferTypeList[payModeGroupValue]
                                              .typeName;
                                      return RadioListTile(
                                        value: index,
                                        groupValue: payModeGroupValue,
                                        onChanged: (value) {
                                          setState(() {
                                            payModeGroupValue = value!;
                                            selectedPaymentMode =
                                                state
                                                    .transferTypeList[payModeGroupValue]
                                                    .typeName;
                                          });
                                        },
                                        title: TextView(
                                          text:
                                              state
                                                  .transferTypeList[index]
                                                  .typeName,
                                          size: 24,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      "No Data Found",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }
                              } else if (state is FetchFundTransferTypeError) {
                                return Center(
                                  child: Text(
                                    "Error: ${state.error}",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "Something went Wrong",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          Divider(
                            color: Colors.grey[400],
                            height: 1,
                            thickness: 1,
                          ),
                          SizedBox(height: 20.0),
                          TextView(
                            text: "From",
                            size: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          if (fromAc.isEmpty)
                            Center(child: Text("NO Account Found")),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: fromAc.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                value: index,
                                groupValue: fromGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    fromGroupValue = value!;
                                    userAcc = fromAc[index]["AccNo"].toString();
                                    userBal =
                                        fromAc[index]["BalAmt"].toString();
                                    warningPrint("UserAcc=$userAcc");
                                  });
                                },
                                title: TextView(
                                  text: fromAc[index]["AccNo"] ?? "",
                                  size: 24,
                                ),
                                subtitle: TextView(
                                  text: fromAc[index]["Types"] ?? "",
                                  size: 12.0,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 100.0),
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
              child: BlocListener<TransferBloc, TransferState>(
                listenWhen:
                    (previous, current) =>
                        current is DetailsLoadingState ||
                        current is DetailsResponse ||
                        current is DetailsError,
                bloc: _transferBloc,
                listener: (context, snapshot) {
                  warningPrint("listener");
                  if (snapshot is DetailsResponse) {
                    if (snapshot.response["Table"][0]["Status"]
                            .toString()
                            .toLowerCase() ==
                        'y') {
                      String pass = "";

                      String otp = "";
                      String ogPassword =
                          preferences.getString(StaticValues.userPass) ?? "";
                      GlobalWidgets().proceedToPaymentModal(
                        context,
                        getValue: (passVal, otpVal) {
                          setState(() {
                            pass = passVal;
                            otp = otpVal;
                          });
                        },
                        actionButton: StatefulBuilder(
                          builder: (context, setState) {
                            return CustomRaisedButton(
                              loadingValue: _isLoading,
                              buttonText: "PAY",
                              onPressed:
                                  _isLoading
                                      ? null
                                      : () async {
                                        debugPrint(
                                          "passVal $pass otpCtrl : $otp",
                                        );
                                        if ((pass.trim().isNotEmpty) &&
                                            (otp.trim().isNotEmpty)) {
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
                                                  APis.fundTransferOTPValidation(
                                                    {
                                                      "Acc_No": userAcc,
                                                      "OTP": otp,
                                                    },
                                                  ),
                                                );
                                            if (otpValidateResponse["Table"][0]["status"]
                                                    .toString()
                                                    .toLowerCase() ==
                                                "y") {
                                              Map<String, String> params = {
                                                "CustAccNo": userAcc,
                                                "ReceiverId":
                                                    widget
                                                        .peopleTable
                                                        .recieverId
                                                        .toString(),
                                                "PaymentMode": "N",
                                                "PayAmount": amt.text,
                                                "OTP": otp,
                                                "RefNo":
                                                    _referenceNo["Table"][0]["Tran_No"],
                                              };
                                              Uri uri = Uri(
                                                queryParameters: params,
                                              );
                                              customPrint(
                                                "Pay object////// $params\n$uri",
                                              );
                                              try {
                                                Map response = await RestAPI()
                                                    .get(
                                                      APis.otherBankFundTrans2(
                                                        params,
                                                      ),
                                                    );
                                                successPrint(
                                                  "response in pay=$response",
                                                );
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                if ((response["Table1"][0]["Status"]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "y") &&
                                                    (response["Table"][0]["TranNO"]
                                                            .toString()
                                                            .toLowerCase() !=
                                                        "")) {
                                                  Navigator.of(
                                                    context,
                                                  ).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) => Receipt(
                                                            pushReplacementNamed:
                                                                "/FundTransfer",
                                                            amount: amt.text,
                                                            transID:
                                                                response["Table1"][0]["TranNO"]
                                                                    .toString(),
                                                            paidTo:
                                                                toBeginningOfSentenceCase(
                                                                  widget
                                                                      .peopleTable
                                                                      .recieverName,
                                                                ).toString(),
                                                            accTo:
                                                                widget
                                                                    .peopleTable
                                                                    .recieverAccno
                                                                    .toString(),
                                                            message:
                                                                "Transaction Sucess",
                                                            accFrom: userAcc,
                                                          ),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                } else {
                                                  Navigator.pop(context);
                                                  Navigator.of(
                                                    context,
                                                  ).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) => Receipt(
                                                            isFailure: true,
                                                            pushReplacementNamed:
                                                                
                                                                    "/FundTransfer",
                                                            amount: amt.text,
                                                            transID: "",
                                                            paidTo:
                                                                toBeginningOfSentenceCase(
                                                                  widget
                                                                      .peopleTable
                                                                      .recieverName,
                                                                ).toString(),
                                                            accTo:
                                                                widget
                                                                    .peopleTable
                                                                    .recieverAccno
                                                                    .toString(),
                                                            message:
                                                                "Transaction Failed",
                                                            accFrom: userAcc,
                                                          ),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
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
                                              setState(() {
                                                _isLoading = false;
                                              });
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
                                        } else if (pass.isEmpty &&
                                            otp.isEmpty) {
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
                                        }
                                      },
                            );
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
                child: BlocBuilder<TransferBloc, TransferState>(
                  buildWhen:
                      (previous, current) =>
                          current is LoadingTransferState ||
                          current is DetailsResponse ||
                          current is DetailsError,
                  builder: (context, snapshot) {
                    warningPrint("snapshot in proceed:: $snapshot");
                    return CustomRaisedButton(
                      buttonText: "PROCEED",
                      loadingValue: snapshot is LoadingTransferState,
                      onPressed: () async {
                        customPrint("proceed button clicked");
                        if (amt.text.isNotEmpty &&
                            int.parse(amt.text) >= _minTransferAmt &&
                            double.parse(amt.text) <= _maxTransferAmt &&
                            double.parse(amt.text) <= double.parse(userBal)) {
                          customPrint("proceed button inside if");

                          customPrint("payment type=$selectedPaymentMode");
                          String transferType = selectedPaymentMode;
                          warningPrint("ttransfer :: $transferType");
                          if (transferType == "NEFT") {
                            Map<String, String> params = {
                              "Customer_AccNo": userAcc,
                              "BankId": "",
                              "Customer_Mobileno": "",
                              "ShopAccno": "1",
                              "PayAmount": amt.text,
                            };

                            _referenceNo = await RestAPI().get(
                              APis.generateRefID("OtherBankTransfer"),
                            );
                            successPrint("REFRESPONSE$_referenceNo");
                            // print(
                            //     "object////// $params\n${APis.checkFundTransferDailyLimit2(params)}");
                            _transferBloc.add(
                              SendDetails(
                                APis.checkFundTransferDailyLimit2(params),
                              ),
                            );
                          }
                        } else {
                          if (double.parse(amt.text == "" ? "0" : amt.text) >
                              double.parse(userBal)) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Insufficient Balance",
                            );
                          } else
                            GlobalWidgets().showSnackBar(
                              context,
                              ("Minimum amount is ${StaticValues.rupeeSymbol}$_minTransferAmt and Maximum amount is ${StaticValues.rupeeSymbol}$_maxTransferAmt"),
                            );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    final transferBloc = TransferBloc.get(context);
    transferBloc.add(FetchFundTransferType());
    preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString(StaticValues.accName) ?? "";
      userId = preferences.getString(StaticValues.custID) ?? "";
    });
    Map balanceResponse = await RestAPI().get(
      APis.fetchFundTransferBal(userId),
    );
    setState(() {
      userBal = balanceResponse["Table"][0]["BalAmt"].toString();
      userAcc = balanceResponse["Table"][0]["AccNo"].toString();
      acType = balanceResponse["Table"][0]["Types"].toString();
      fromAc = balanceResponse["Table"];

      warningPrint("UserAcc=$userAcc");
    });
    Map transDailyLimit = await RestAPI().get(APis.checkFundTransAmountLimit);
    print("transDailyLimit::: $transDailyLimit");
    setState(() {
      _minTransferAmt = transDailyLimit["Table"][0]["Min_fundtranbal"];
      _maxTransferAmt = transDailyLimit["Table"][0]["Max_fundtranbal"];
      //      userBal = balanceResponse["Table"][0]["BalAmt"].toString();
    });
  }
}
