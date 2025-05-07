import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CardStatementModel.dart';

class CardStatement extends StatefulWidget {
  const CardStatement({Key? key}) : super(key: key);

  @override
  _CardStatementState createState() => _CardStatementState();
}

class _CardStatementState extends State<CardStatement> {
  List<CardTransTable>? cardTransactionList = [];
  late bool _isLoading;
  String? strMsg;
  SharedPreferences? preferances;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardStatement();
  }

  Future<void> getCardStatement() async {
    preferances = StaticValues.sharedPreferences;
    _isLoading = true;
    var response = await RestAPI().post(
      APis.getCardStatement,
      params: {
        "strAgentMobileNo": preferances?.getString(StaticValues.mobileNo) ?? "",
        //   "strAgentMobileNo":"9650712712"
      },
    );

    CardStatementModel cardStatementModel = CardStatementModel.fromJson(
      response,
    );

    setState(() {
      cardTransactionList = cardStatementModel.data;
      print("LIJU: $cardTransactionList");
      strMsg = cardStatementModel.successMessage;
      _isLoading = false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            strMsg!,
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      );
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Statement", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: cardTransactionList!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cardTransactionList![index].dtTransactionDate!,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cardTransactionList![index].amount!,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Voucher Type : ${cardTransactionList![index].strVoucherType}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Balance : ${cardTransactionList![index].availableBalance.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Narration : ${cardTransactionList![index].strNarration}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
