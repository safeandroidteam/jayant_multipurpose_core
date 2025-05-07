import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AccNoModel.dart';
import 'DepositSearchModel.dart';

class AccountSearch extends StatefulWidget {
  final String accType;

  AccountSearch(this.accType) : super();

  @override
  _AccountSearchState createState() => _AccountSearchState();
}

class _AccountSearchState extends State<AccountSearch> {
  var _fruits = <AccTable>[];
  var _selectedAccNo;
  String? str_accNo;
  String? str_accType;
  List<AccTable>? accTable = [];
  String? _mySelection;
  bool _isAccNo = false;
  bool _isAccSearch = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  List<DepositTable>? depositTable = [];
  SharedPreferences? preferences;
  String? userId, schemeCode1, branchCode1;
  String url =
      "http://perumannascb.safeandsmartbank.com:6550/Api/Values/get_DepositSearch?Cust_id=31125&Acc_no=0020070001785&Sch_code=007&Br_code=2&Frm_Date=2020-05-14&Todate=2020-11-05";

  var _forkKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getSerchList();

    if (widget.accType == "Account") {
      str_accType = "DP";
    } else if (widget.accType == "Loan") {
      str_accType = "LN";
    }

    getAccDeposit();
  }

  Future<void> getAccDeposit() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      _isAccNo = true;
      userId = preferences?.getString(StaticValues.custID) ?? "";
      schemeCode1 = preferences?.getString(StaticValues.schemeCode) ?? "";
      branchCode1 = preferences?.getString(StaticValues.branchCode) ?? "";
    });
    var response = await RestAPI().get(
      APis.getAccNoDeposit({"Cust_id": userId, "Acc_Type": str_accType}),
    );
    GetAccNo _getAccNo = GetAccNo.fromJson(response);

    accTable = _getAccNo.accTable;

    setState(() {
      _isAccNo = false;
    });
    return;
  }

  /*  Future<void> getSerchList() async{

    var response = await RestAPI().get(url);
    DepositSearchModel _depositList = DepositSearchModel.fromJson(response);


    print("Lijith: $depositTable");

    setState(() {
      depositTable = _depositList.depositTable;
    });
    return;
  }*/

  void _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;

        fromDateController.text = DateFormat(
          "yyyy-MM-dd",
        ).format(selectedFromDate);
      });
  }

  void _selectedToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;

        toDateController.text = DateFormat("yyyy-MM-dd").format(selectedToDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.accType} Search",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _forkKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: DropdownButtonHideUnderline(
                  child:
                      _isAccNo
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButton(
                            hint: Text("Account No"),
                            value: _mySelection,
                            items:
                                accTable!.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.accNo!),
                                    value: item.accNo,
                                  );
                                }).toList(),
                            onChanged: (dynamic newVal) {
                              setState(() {
                                _mySelection = newVal;
                              });
                            },
                          ),
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectFromDate(context);
                      },
                      child: Container(
                        height: 40.0,
                        child: TextFormField(
                          enabled: false,
                          controller: fromDateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Select Date";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "From Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectedToDate(context);
                      },
                      child: Container(
                        height: 40.0,
                        child: TextFormField(
                          enabled: false,
                          controller: toDateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Select Date";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "To Date",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Container(
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (_mySelection != null &&
                                fromDateController.text.isNotEmpty &&
                                toDateController.text.isNotEmpty)
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                  ),
                  onPressed: () async {
                    if (_forkKey.currentState!.validate()) {
                      _isAccSearch = true;
                      // var response = await RestAPI().get(url);
                      var response = await RestAPI().get(
                        APis.getDepositTransactionList({
                          "Cust_id": userId,
                          "Acc_no": _mySelection,
                          "Sch_code": schemeCode1,
                          "Br_code": branchCode1,
                          "Frm_Date": fromDateController.text,
                          "Todate": toDateController.text,
                        }),
                      );
                      DepositSearchModel _depositList =
                          DepositSearchModel.fromJson(response);

                      print("Lijith: $depositTable");

                      setState(() {
                        depositTable = _depositList.depositTable;
                        _isAccSearch = false;
                      });
                      return;
                    }

                    // getSerchList();
                  },
                  /* onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StatementDownload()));
                  },*/
                  child:
                      _isAccSearch
                          ? CircularProgressIndicator()
                          : Text(
                            "Fetch Data",
                            style: TextStyle(color: Colors.white),
                          ),
                ),
              ),
              SizedBox(height: 15.0),
              Expanded(
                child: ListView.builder(
                  itemCount: depositTable!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String s = depositTable![index].trDate.toString().substring(
                      0,
                      depositTable![index].trDate.toString().indexOf(' '),
                    );
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //   Text(depositTable[index].trDate.toString()),
                            Text(s),
                            Text(
                              depositTable![index].amount.toString(),
                              style: TextStyle(
                                color:
                                    depositTable![index].tranType.toString() ==
                                            "C"
                                        ? Colors.red
                                        : Colors.green,
                              ),
                            ),
                            Text(depositTable![index].tranBalance.toString()),
                          ],
                        ),
                        subtitle: Text(depositTable![index].narration!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
