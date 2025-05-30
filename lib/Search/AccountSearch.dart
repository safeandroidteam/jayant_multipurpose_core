import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Search/bloc/search_bloc.dart';
import 'package:passbook_core_jayant/Search/modal/AccStatementSearchModel.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  TextEditingController fromDateDDMMYYYYCtrl = TextEditingController();
  TextEditingController toDateDDMMYYYYCtrl = TextEditingController();
  List<AccStatementSearchData> depositTable = [];
  SharedPreferences? preferences;
  String? userId, schemeCode1, branchCode1, custName, cmpCode;

  final _forkKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    preferences = StaticValues.sharedPreferences;
    custName = preferences?.getString(StaticValues.accName);
    if (widget.accType == "Account") {
      str_accType = "DP";
    } else if (widget.accType == "Loan") {
      str_accType = "LN";
    }

    getAccDeposit();
  }

  getAccDeposit() async {
    preferences = StaticValues.sharedPreferences;
    cmpCode = preferences?.getString(StaticValues.cmpCodeKey) ?? "";
    userId = preferences?.getString(StaticValues.custID) ?? "";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final searchBloc = SearchBloc.get(context);
      searchBloc.add(AccNoDepositEvent(cmpCode ?? "", userId ?? ""));
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
          "dd-MM-yyyy",
        ).format(selectedFromDate);

        fromDateDDMMYYYYCtrl.text = DateFormat(
          'MM-dd-yyyy',
        ).format(selectedFromDate);
        depositTable.clear();
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

        toDateController.text = DateFormat("dd-MM-yyyy").format(selectedToDate);

        toDateDDMMYYYYCtrl.text = DateFormat(
          'MM-dd-yyyy',
        ).format(selectedToDate);
        depositTable.clear();
      });
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = SearchBloc.get(context);
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
      floatingActionButton:
          depositTable.isEmpty
              ? SizedBox.shrink()
              : BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  final isLoading = state is PdfDownloadLoading;

                  warningPrint("isloading in fab =$isLoading");
                  return FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: CircleBorder(),
                    tooltip: 'Download PDF',
                    onPressed:
                        isLoading
                            ? null
                            : () {
                              searchBloc.add(
                                PdfDownloadEvent(
                                  depositTable,
                                  fromDateController.text,
                                  toDateController.text,
                                  context,
                                ),
                              );
                            },
                    child:
                        isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : Icon(Icons.download, color: Colors.white),
                  );
                },
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
                    buildWhen:
                        (previous, current) =>
                            current is SearchInitial ||
                            current is AccDepositLoading ||
                            current is AccDepositResponse ||
                            current is AccDepositErrorException,
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AccDepositLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AccDepositResponse) {
                        if (state.accNoData.isNotEmpty) {
                          return DropdownButton(
                            hint: Text("Account No"),
                            value: _mySelection,
                            items:
                                state.accNoData.map((item) {
                                  return DropdownMenuItem(
                                    // value: item.accNo,
                                    value: item.accId.toString(),
                                    child: Text(item.accNo!),
                                  );
                                }).toList(),
                            onChanged: (dynamic newVal) {
                              setState(() {
                                _mySelection = newVal.toString();
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Select Date";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "From Date",

                            hintStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black),

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
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Select Date";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "To Date",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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

                      try {
                        Map<String, dynamic> fetchAccStatementBody = {
                          "Cmp_Code": cmpCode,
                          "Acc_ID": _mySelection,
                          "StartDate": fromDateDDMMYYYYCtrl.text,
                          "EndDate": toDateDDMMYYYYCtrl.text,
                        };

                        var response = await RestAPI().post(
                          APis.fetchAccountStatement,
                          params: fetchAccStatementBody,
                        );

                        setState(() {
                          AccStatementSearchModel accStatementSearchModel =
                              AccStatementSearchModel.fromJson(response);

                          depositTable = accStatementSearchModel.data ?? [];
                          warningPrint(
                            "deposit List length: ${depositTable.length}",
                          );

                          _isDepositTableEmpty = depositTable.isEmpty;
                          _isAccSearch = false;
                        });
                      } on RestException catch (e, stackTrace) {
                        setState(() {
                          _isAccSearch = false;
                          _isDepositTableEmpty = true;
                        });
                        GlobalWidgets().showSnackBar(
                          context,
                          "${e.message["ProceedMessage"]}",
                        );
                        errorPrint("Error fetching account statement: $e");
                        debugPrintStack(stackTrace: stackTrace);
                      }
                    }
                  },

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
                  : (_isDepositTableEmpty)
                  ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Center(child: Text("No Data Found")),
                    ],
                  )
                  : Expanded(
                    child: ListView.builder(
                      itemCount: depositTable.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String s = depositTable[index].trDate.toString();

                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //   Text(depositTable[index].trDate.toString()),
                                Text(s),
                                Text(
                                  depositTable[index].amount.toStringAsFixed(2),
                                  style: TextStyle(
                                    color:
                                        depositTable[index].tranType
                                                    .toString() ==
                                                "1"
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ),
                                Text(
                                  depositTable[index].balAmt.toStringAsFixed(
                                        2,
                                      ) ??
                                      "",
                                ),
                              ],
                            ),
                            subtitle: Text(depositTable[index].remarks ?? ""),
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
