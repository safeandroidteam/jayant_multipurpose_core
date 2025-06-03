import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/FundTransfer/Receipt.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_bloc.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_event.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_state.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnBankTransfer extends StatefulWidget {
  const OwnBankTransfer({super.key});

  @override
  _OwnBankTransferState createState() => _OwnBankTransferState();
}

class _OwnBankTransferState extends State<OwnBankTransfer> {
  TextEditingController mob = TextEditingController(),
      accNo = TextEditingController(),
      name = TextEditingController(),
      amt = TextEditingController();
  String userName = "",
      userAcc = "",
      custId = "",
      userBal = "",
      cmpCode = "",
      custTypeCode = "";
  bool mobVal = false, accNoVal = false, nameVal = false, amtVal = false;
  List fromAc = [];
  bool fromAcLoading = false;
  String acType = "";
  List accNos = [];
  String payerName = "";
  double amtBoxSize = 70.0;
  int toGroupValue = 0;
  int fromGroupValue = 0;
  GlobalKey toKey = GlobalKey();

  final FocusNode _mobFocusNode = FocusNode();

  final ScrollController _customScrollController = ScrollController();

  late SharedPreferences preferences;

  final TransferBloc _transferBloc = TransferBloc();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String _minTransferAmt = "0.0", _maxTransferAmt = "0.0";

  Map<String, dynamic> _referanceNo = {};

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
      print(
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
                  title: Text(
                    "Own Bank Transfer",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
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
                        Icon(Icons.person, size: 56.0, color: Colors.white),
                        SizedBox(height: 5.0),
                        TextView(
                          text:
                              "Paying ${payerName.isEmpty ? "____" : payerName}",
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

                        // BlocBuilder<TransferBloc, TransferState>(
                        //   buildWhen:
                        //       (previous, current) =>
                        //           current is FetchUserLimitLoading ||
                        //           current is FetchUserLimitResponse,
                        //   builder: (context, state) {
                        //     if (state is FetchUserLimitLoading) {
                        //       return const CircularProgressIndicator();
                        //     } else if (state is FetchUserLimitResponse) {
                        //       final minTransferAmt =
                        //           state.userLimitList.first.minFundTranBal;
                        //       return Text(
                        //         "Minimum amount ${StaticValues.rupeeSymbol}$minTransferAmt",
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //           color: Colors.red,
                        //         ),
                        //       );
                        //     } else if (state is FetchUserLimitError) {
                        //       return Text("Error: ${state.error}");
                        //     }
                        //     return const SizedBox();
                        //   },
                        // ),
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
                          Row(
                            key: toKey,
                            children: [
                              TextView(
                                text: "To",
                                size: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 20.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .75,
                                child: EditTextBordered(
                                  setBorder: true,
                                  borderColor: Theme.of(context).primaryColor,
                                  setDecoration: true,
                                  controller: mob,
                                  hint: "Enter payer mobile no.",
                                  errorText:
                                      mobVal
                                          ? "Mobile number is invalid"
                                          : null,
                                  keyboardType: TextInputType.number,
                                  focusNode: _mobFocusNode,
                                  obscureIcon: InkWell(
                                    onTap: () {
                                      customPrint(
                                        "blue button clicked with icon",
                                      );
                                      if (mob.text.isNotEmpty && !mobVal) {
                                        _transferBloc.add(
                                          FetchCustomerAccNo(mob.text),
                                        );
                                      } else {
                                        GlobalWidgets().showSnackBar(
                                          context,
                                          "Mobile number is invalid",
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).dividerColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[400]!,
                                            blurRadius: 3,
                                            spreadRadius: 2.0,
                                            offset: Offset(1.5, 1.5),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 2.0,
                                      ),
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  onChange: (value) {
                                    setState(() {
                                      mobVal = value.trim().length != 10;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          BlocListener<TransferBloc, TransferState>(
                            bloc: _transferBloc,
                            listenWhen:
                                (previous, current) =>
                                    current is LoadingTransferState ||
                                    current is FetchCustAccNoResponse ||
                                    current is FetchCustAccNoError,
                            listener: (context, snapshot) {
                              if (snapshot is FetchCustAccNoResponse) {
                                setState(() {
                                  if (snapshot.response["Table"][0]["ACCNO"] ==
                                      "N") {
                                    mobVal = true;
                                    GlobalWidgets().showSnackBar(
                                      context,
                                      "Mobile number does not exist",
                                    );
                                  } else {
                                    accNos = snapshot.response["Table"];
                                    //   payerName = snapshot.response["Table"][0]["Cust_Name"];
                                  }
                                });
                              }
                            },
                            child:
                                accNos.isNotEmpty
                                    ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: accNos.length,
                                      itemBuilder: (context, index) {
                                        return RadioListTile(
                                          value: index,
                                          groupValue: toGroupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              toGroupValue = value!;
                                            });
                                          },
                                          title: TextView(
                                            text: accNos[index]["ACCNO"],
                                            size: 24,
                                          ),
                                          subtitle: TextView(
                                            //  "SB INDIVIDUAL",
                                            text: accNos[index]["Cust_Name"],
                                            size: 12.0,
                                          ),
                                        );
                                      },
                                    )
                                    : SizedBox.shrink(),
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
                          if (fromAcLoading == true)
                            Center(child: CircularProgressIndicator()),
                          if (fromAcLoading == false && fromAc.isEmpty)
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
                                    userAcc =
                                        fromAc[index]["Acc_No"].toString();
                                    warningPrint("UserAcc=$userAcc");
                                    userBal =
                                        fromAc[index]["Balance"].toString();
                                    warningPrint("UserBal=$userBal");
                                  });
                                },
                                title: TextView(
                                  text: fromAc[index]["Acc_No"] ?? "",
                                  size: 24,
                                ),
                                subtitle: TextView(
                                  text: fromAc[index]["Sch_Name"] ?? "",
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
                bloc: _transferBloc,
                listener: (context, snapshot) {
                  if (accNos[toGroupValue]["ACCNO"].toString() == userAcc) {
                    Fluttertoast.showToast(
                      msg: "You cannot send money to the same account",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (snapshot is DetailsResponse) {
                    print(
                      "object __ ${snapshot.response["Table"][0]["Column1"]}",
                    );
                    if (snapshot.response["Table"][0]["Column1"]
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
                          debugPrint("passval=$passVal");
                          debugPrint("otpVal=$otpVal");
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
                                    debugPrint("passVal $pass otpCtrl : $otp");
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
                                              APis.fundTransferOTPValidation({
                                                "Acc_No": userAcc,
                                                "OTP": otp,
                                              }),
                                            );
                                        if (otpValidateResponse["Table"][0]["status"]
                                                .toString()
                                                .toLowerCase() ==
                                            "y") {
                                          Map<String, String> params = {
                                            "Customer_AccNo":
                                                userAcc.toString(),
                                            "Customer_Mobileno": "",
                                            "ShopAccno":
                                                accNos[toGroupValue]["ACCNO"]
                                                    .toString(),
                                            "PayAmount": amt.text,
                                            "st_otp": otp,
                                            "RefNo":
                                                _referanceNo["Table"][0]["Tran_No"],
                                          };

                                          setState(() {
                                            isLoading = true;
                                          });

                                          try {
                                            Map response = await RestAPI().get<
                                              Map
                                            >(APis.ownBankFundTrans2(params));

                                            setState(() {
                                              isLoading = false;
                                            });

                                            if ((response["Table"][0]["Status"]
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
                                                            response["Table"][0]["TranNO"]
                                                                .toString(),
                                                        paidTo: payerName,
                                                        accTo:
                                                            accNos[toGroupValue]["ACCNO"]
                                                                .toString(),
                                                        message:
                                                            "Transaction Sucess",
                                                        accFrom: userAcc,
                                                      ),
                                                ),
                                                (Route<dynamic> route) => false,
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
                                                              payerName,
                                                            ).toString(),
                                                        accTo:
                                                            accNos[toGroupValue]["ACCNO"]
                                                                .toString(),
                                                        message:
                                                            "Transaction Failed",
                                                        accFrom: userAcc,
                                                      ),
                                                ),
                                                (Route<dynamic> route) => false,
                                              );
                                            }
                                          } on RestException catch (e) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.of(context).pop();
                                            GlobalWidgets().showSnackBar(
                                              context,
                                              e.message,
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            isLoading = false;
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
                                    } else if (pass.isEmpty && otp.isEmpty) {
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
                  bloc: _transferBloc,
                  buildWhen:
                      (previous, current) =>
                          current is DetailsLoadingState ||
                          current is DetailsResponse ||
                          current is DetailsError,
                  builder: (context, snapshot) {
                    print("snapshot :: $snapshot");
                    return CustomRaisedButton(
                      loadingValue: snapshot is DetailsLoadingState,
                      onPressed: () async {
                        print("accNos.length :: ${accNos.length}");
                        if (amt.text.isNotEmpty &&
                            int.parse(amt.text) >= int.parse(_minTransferAmt) &&
                            double.parse(amt.text) <=
                                int.parse(_maxTransferAmt) &&
                            double.parse(amt.text) <=
                                double.parse(userBal ?? "")) {
                          if (mob.text.isEmpty || !mobVal && accNos.isEmpty) {
                            GlobalWidgets().showSnackBar(
                              context,
                              ("Enter Payer Mobile number and select an account to transfer"),
                              actions: SnackBarAction(
                                label: "Okay",
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                          } else {
                            print(
                              "selectedAccNo :: ${accNos[toGroupValue]["ACCNO"]}",
                            );
                            setState(() {
                              payerName = accNos[toGroupValue]["Cust_Name"];
                            });
                            print(
                              "selectedCUSTNAME :: ${accNos[toGroupValue]["Cust_Name"]}",
                            );
                            Map<String, dynamic> params = {
                              "Customer_AccNo": userAcc,
                              "BankId": "",
                              "Customer_Mobileno": "",
                              "ShopAccno": accNos[toGroupValue]["ACCNO"],
                              "PayAmount": amt.text,
                            };
                            _transferBloc.add(
                              SendDetails(APis.ownFundTransferOTP(params)),
                            );
                            _referanceNo = await RestAPI().get(
                              APis.generateRefID("ownBankTransfer"),
                            );

                            print("REFNO$_referanceNo");
                          }
                        } else {
                          if (double.parse(amt.text == "" ? "0" : amt.text) >
                              double.parse(userBal ?? "")) {
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
                      buttonText: "PROCEED",
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

  loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      fromAcLoading = true;
      userName = preferences.getString(StaticValues.accName) ?? "";
      custId = preferences.getString(StaticValues.custID) ?? "";
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      custTypeCode = preferences.getString(StaticValues.custTypeCode) ?? "";
    });

    // Map balanceResponse = await RestAPI().get(
    //   APis.fetchFundTransferBal(userId),
    // );

    try {
      Map<String, dynamic> fetchCustomerSBBody = {
        "Cmp_Code": cmpCode,
         "Cust_ID": custId,
       // "Cust_ID": "3629",
      };
      Map balanceResponse = await RestAPI().post(
        APis.fetchCustomerSB,
        params: fetchCustomerSBBody,
      );

      successPrint("balance Response=$balanceResponse");
      final data = balanceResponse["Data"];

      if (data != null && data is List && data.isNotEmpty) {
        setState(() {
          userBal = balanceResponse["Data"][0]["Balance"].toString();
          userAcc = balanceResponse["Data"][0]["Acc_No"].toString();
          acType = balanceResponse["Data"][0]["Sch_Name"].toString();
          // fromAc = balanceResponse["Data"];
          fromAc = data;
          fromAcLoading = false;
          // fromAc.add({"Balance": 12.0, "Acc_No": "10", "Sch_Name": "ff"});

          warningPrint("UserAcc=$userAcc");
        });
      } else {
        setState(() {
          fromAcLoading = false;
        });
        warningPrint("No data found");
      }
    } on RestException catch (e) {
      e.message.toString();
      errorPrint("Error : ${e.message.toString()}");
    }

    // Map transDailyLimit = await RestAPI().get(APis.checkFundTransAmountLimit);
    Map<String, dynamic> fetchUserLimitBody = {
      "Cmp_Code": cmpCode,
      "Cust_Type": custTypeCode,
    };
    Map transDailyLimit = await RestAPI().post(
      APis.fetchUserLimit,
      params: fetchUserLimitBody,
    );
    alertPrint("transDailyLimit::: $transDailyLimit");
    setState(() {
      _minTransferAmt = transDailyLimit["Data"][0]["Min_fundtranbal"];
      _maxTransferAmt = transDailyLimit["Data"][0]["Max_interfundtranbal"];
      //      userBal = balanceResponse["Table"][0]["BalAmt"].toString();
    });
    warningPrint("min trans limit =$_minTransferAmt");
    warningPrint("max trans limit =$_maxTransferAmt");
    // fetchCustomerFromAccNo();
    // fetchUserLimit();
  }

  // fetchCustomerFromAccNo() async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     custId = preferences.getString(StaticValues.custID) ?? "";
  //     final transferBloc = TransferBloc.get(context);
  //     transferBloc.add(FetchCustomerFromAccNo(cmpCode, custId));
  //     setState(() {
  //       fromAcLoading = false;
  //     });
  //   });
  // }
  //
  // fetchUserLimit() async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     custTypeCode = preferences.getString(StaticValues.custTypeCode) ?? "";
  //     final transferBloc = TransferBloc.get(context);
  //     transferBloc.add(FetchUserLimitevent(cmpCode, custTypeCode));
  //   });
  // }
}
