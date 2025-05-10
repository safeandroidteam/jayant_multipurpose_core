import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Search/bloc/search_bloc.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modal/AccNoModel.dart';
import 'DepositSearchModel.dart';

class AccountSearch extends StatefulWidget {
  final String accType;

  const AccountSearch(this.accType, {super.key});

  @override
  _AccountSearchState createState() => _AccountSearchState();
}

class _AccountSearchState extends State<AccountSearch> {
  String? str_accNo;
  String? str_accType;
  String? _mySelection;

  bool _isAccSearch = false;
  bool _isDepositTableEmpty = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  List<DepositTable>? depositTable = [];
  SharedPreferences? preferences;
  String? userId, schemeCode1, branchCode1;

  final _forkKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.accType == "Account") {
      str_accType = "DP";
    } else if (widget.accType == "Loan") {
      str_accType = "LN";
    }

    getAccDeposit();
  }

  getAccDeposit() async {
    preferences = StaticValues.sharedPreferences;

    userId = preferences?.getString(StaticValues.custID) ?? "";
    schemeCode1 = preferences?.getString(StaticValues.schemeCode) ?? "";
    branchCode1 = preferences?.getString(StaticValues.branchCode) ?? "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final searchBloc = SearchBloc.get(context);

      searchBloc.add(AccNoDepositEvent(userId ?? "", str_accType ?? ""));
    });
  }

  void _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;

        fromDateController.text = DateFormat(
          "yyyy-MM-dd",
        ).format(selectedFromDate);
        depositTable?.clear();
      });
  }

  void _selectedToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;

        toDateController.text = DateFormat("yyyy-MM-dd").format(selectedToDate);
        depositTable?.clear();
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
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AccDepositLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AccDepositResponse) {
                        if (state.accTable.isNotEmpty) {
                          return DropdownButton(
                            hint: Text("Account No"),
                            value: _mySelection,
                            items:
                                state.accTable.map((item) {
                                  return DropdownMenuItem(
                                    value: item.accNo,
                                    child: Text(item.accNo!),
                                  );
                                }).toList(),
                            onChanged: (dynamic newVal) {
                              setState(() {
                                _mySelection = newVal;
                              });
                            },
                          );
                        } else {
                          return Center(child: Text("No Account Found"));
                        }
                      } else if (state is AccDepositErrorException) {
                        return Text("Error ${state.error}");
                      } else {
                        return Text("Something went Wrong");
                      }
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
                      child: SizedBox(
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
                      child: SizedBox(
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
              SizedBox(
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
                      setState(() {
                        _isAccSearch = true;
                        _isDepositTableEmpty = false;
                      });

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
                      DepositSearchModel depositList =
                          DepositSearchModel.fromJson(response);

                      print("deposit List : $depositTable");

                      setState(() {
                        depositTable = depositList.depositTable;
                        if (depositTable!.isEmpty) {
                          _isDepositTableEmpty = true;
                        } else {
                          _isDepositTableEmpty = false;
                        }

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
                          ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.white,
                          )
                          : Text(
                            "Fetch Data",
                            style: TextStyle(color: Colors.white),
                          ),
                ),
              ),
              SizedBox(height: 15.0),
              _isAccSearch
                  ? SizedBox.shrink()
                  : ((_isDepositTableEmpty))
                  ? Center(child: Text("No Data Found"))
                  : Expanded(
                    child: ListView.builder(
                      itemCount: depositTable!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String s = depositTable![index].trDate
                            .toString()
                            .substring(
                              0,
                              depositTable![index].trDate.toString().indexOf(
                                ' ',
                              ),
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
                                        depositTable![index].tranType
                                                    .toString() ==
                                                "C"
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                                Text(
                                  depositTable![index].tranBalance.toString(),
                                ),
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
