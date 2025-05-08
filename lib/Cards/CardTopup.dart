import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/Cards/CardReset.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CardStatement.dart';

class CardTopup extends StatefulWidget {
  const CardTopup({Key? key}) : super(key: key);

  @override
  _CardTopupState createState() => _CardTopupState();
}

class _CardTopupState extends State<CardTopup> {
  int? intStatusCode, intBalance, intStatusCode1;

  SharedPreferences? preferances;
  TextEditingController amntCtroller = TextEditingController();
  late bool _isLoading;
  bool _isTopUp = false;
  String? strMsg, strMsg1, strMsg2, strErrorMsg;
  int count = 0;
  var isLoading = false;
  String? str_Otp;
  SharedPreferences? preferences;
  String? userName,
      userAcc = "",
      userId,
      userBal = "",
      _hint = "",
      _errorhint = "",
      operatorName = "",
      operatorId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getAccountBalance();
  }

  Future<void> getAccountBalance() async {
    preferances = StaticValues.sharedPreferences;
    setState(() {
      _isLoading = true;
    });

    var response = await RestAPI().post(APis.getCardBalance, params: {
      // "strAgentMobileNo": preferances?.getString(StaticValues.mobileNo) ?? "",
     // "strAgentMobileNo": preferances!.getString(StaticValues.mobileNo)
       "strAgentMobileNo": "9650712712"
    });

    setState(() {
      intStatusCode = response["statusCode"];

      if (intStatusCode == 200) {
        intBalance = response["data"][0]["balance"];
        strMsg1 = response["successMessage"];
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: new Text(strMsg1!)));
      } else {
        strMsg1 = response["errorMessage"];
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: new Text("Failed")));
        Navigator.pop(context);
      }
      _isLoading = false;
    });

    return;

    // print("Response$response");
    print("Response${intBalance.toString()}");
  }

  Future<void> cardTopUp() async {
    _isTopUp = true;

    print("START$_isTopUp");
    var response = await RestAPI().post(APis.cardTopUp, params: {
      //  "strAgentMobileNo":"9650712712",
      "strAgentMobileNo": preferances!.getString(StaticValues.mobileNo),
      "dblAmount": amntCtroller.text
    });
    strMsg = response["successMessage"];
    strErrorMsg = response["errorMessage"];

    setState(() {
      intStatusCode1 = response["statusCode"];
      _isTopUp = false;

      print("STOP$_isTopUp");
    });

    if (intStatusCode1 == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text(strMsg!)));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      Navigator.pushNamedAndRemoveUntil(context, '/HomePage', (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text("Failed")));
      Navigator.pushNamedAndRemoveUntil(context, '/HomePage', (route) => false);
      //  Navigator.pop(context);
    }

    print("LJT${response["successMessage"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Card Topup",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Container(
                    height: 20.0,
                    width: 25.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardReset()));
                      },
                      child: Image.asset(
                        "assets/reset.png",
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  width: 24.0,
                ),
                Container(
                    height: 20.0,
                    width: 25.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardStatement()));
                      },
                      child: Image.asset(
                        "assets/transaction_2.png",
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          ],
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Card Balance",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        intBalance.toString(),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border:
                            Border.all(style: BorderStyle.solid, width: 0.80),
                      ),
                      child: Text(
                          "${preferances!.getString(StaticValues.mobileNo)}")),
                  SizedBox(
                    height: 12,
                  ),
                  EditTextBordered(
                    hint: "Enter Amount",
                    controller: amntCtroller,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      if (double.parse(amntCtroller.text) <=
                          double.parse(userBal!)) {
                        if (amntCtroller.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(
                                  content: new Text("Please Enter Amount")));
                        } else {
                          var response =
                              await RestAPI().post(APis.GenerateOTP, params: {
                            "MobileNo":
                                preferances!.getString(StaticValues.mobileNo),
                            "Amt": amntCtroller.text,
                            "SMS_Module": "GENERAL",
                            "SMS_Type": "GENERAL_OTP",
                            "OTP_Return": "Y"
                          });
                          print("rechargeResponse::: $response");
                          str_Otp = response[0]["OTP"];

                          //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str_Message)));
                          //  RestAPI().get(APis.rechargeMobile(params));
                          /*    Map response =
                            await RestAPI().get(APis.rechargeMobile(params));*/
                          //   getMobileRecharge();
                          setState(() {
                            isLoading = false;

                            Timer(Duration(minutes: 5), () {
                              setState(() {
                                str_Otp = "";
                              });
                            });
                          });

                          _topupConfirmation();

                          /* setState(() {
                  count = count+1;

                  if( count == 1){
                  //  cardTopUp();
                    _topupConfirmation();
                  }
                  else{
                    return null;
                  }

                });*/
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: new Text("Insufficient Balance")));
                      }

                      /* ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  content: new Text("Helloo")));*/
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40.0,
                          child: Center(
                            child: _isTopUp
                                ? CircularProgressIndicator()
                                : Text(
                                    "TopUp",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _topupConfirmation() {
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
          TextView(
            text: 
            "Enter OTP",
            size: 24.0,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
      actionButton: StatefulBuilder(
        builder: (context, setState) => CustomRaisedButton(
            loadingValue: isLoading,
            buttonText:
                isLoading ? CircularProgressIndicator() as String : "TOPUP",
            onPressed: isLoading
                ? () {}
                : () async {
                    if (_pass == str_Otp) {
                      count = count + 1;
                      if (count == 1) {
                        cardTopUp();
                      } else {
                        return null;
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "OTP Miss match",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }),
      ),
    );
  }

  void loadData() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      userName = preferences?.getString(StaticValues.accName) ?? "";
      userId = preferences?.getString(StaticValues.custID) ?? "";
    });
    Map? balanceResponse =
        await RestAPI().get(APis.fetchFundTransferBal(userId));
    setState(() {
      userBal = balanceResponse!["Table"][0]["BalAmt"].toString();
      userAcc = balanceResponse["Table"][0]["AccNo"].toString();
      print("BALANCE${userBal}");
    });
    Map? transDailyLimit = await RestAPI().get(APis.checkFundTransAmountLimit);
    print("transDailyLimit::: $transDailyLimit");
  }
}
