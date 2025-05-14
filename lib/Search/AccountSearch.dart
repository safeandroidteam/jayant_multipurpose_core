import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Search/bloc/search_bloc.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController fromDateFormattedCtrl = TextEditingController();
  TextEditingController toDateFormattedCtrl = TextEditingController();
  List<DepositTable>? depositTable = [];
  SharedPreferences? preferences;
  String? userId, schemeCode1, branchCode1, custName;

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
        fromDateFormattedCtrl.text = DateFormat(
          'dd MMM yyyy',
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
        toDateFormattedCtrl.text = DateFormat(
          'dd MMM yyyy',
        ).format(selectedFromDate);
        depositTable?.clear();
      });
  }

  Future<void> generatePdf(List<DepositTable> transactionDetails) async {
    final pdf = pw.Document();
    debugPrint("From(${fromDateController.text})_To(${toDateController.text})");
    String searchedDate =
        "From(${fromDateController.text})-To(${toDateController.text})";

    String searchedReportDate =
        (fromDateFormattedCtrl.text == toDateFormattedCtrl.text)
            ? "of ${fromDateFormattedCtrl.text}"
            : "from  ${fromDateFormattedCtrl.text} to ${toDateFormattedCtrl.text}";

    final depAccNo =
        transactionDetails.isNotEmpty && transactionDetails.first.accNo != null
            ? transactionDetails.first.accNo.toString()
            : 'N/A';

    /// Can't add image directly in pdf, need to convert it to bytes
    final imageBytes = await rootBundle.load('assets/mini-logo.png');
    final logoImage = pw.MemoryImage(imageBytes.buffer.asUint8List());

    if (transactionDetails.isEmpty) {
      debugPrint("No transactions available to generate PDF.");
      return;
    } else if (transactionDetails.length > 0) {
      debugPrint("Transactions available to generate PDF.");
      debugPrint("Transaction count: ${transactionDetails.length}");
      transactionDetails.forEach((e) => print(e.toJson()));
    }

    try {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          // Show footer only if more than one page
          footer: (context) {
            if (context.pagesCount > 1) {
              return pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
                ),
              );
            }
            return pw.SizedBox.shrink();
          },
          build:
              (context) => [
                pw.Row(
                  children: [
                    pw.Image(
                      logoImage,
                      height: 50,
                      width: 50,
                      fit: pw.BoxFit.contain,
                    ),
                    pw.Text(
                      // 'Jayant India Nidhi Limited',
                      'JINL',
                      style: pw.TextStyle(
                        fontSize: 48,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Spacer(),
                    pw.Text(
                      'Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'Account Name : ',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      '${custName?.toUpperCase()}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      'Account Number : ',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      depAccNo,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Account Transaction Report $searchedReportDate',
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 10),

                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  cellAlignment: pw.Alignment.centerLeft,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2), // Date
                    1: const pw.FlexColumnWidth(1), // Type
                    2: const pw.FlexColumnWidth(2), // Amount
                    3: const pw.FlexColumnWidth(2), // Balance
                    4: const pw.FlexColumnWidth(5), // Narration (longer text)
                  },
                  data: <List<String>>[
                    <String>[
                      // 'Account No',
                      'Date',
                      'Type',
                      'Amount',
                      'Balance',
                      'Narration',
                    ],
                    ...transactionDetails
                        .map(
                          (transactionDetail) => [
                            // transactionDetail.accNo?.toString() ?? '',
                            // DateFormat('yyyy-MM-dd').format(
                            DateFormat('dd-MM-yyyy').format(
                              transactionDetail.trDate ?? DateTime.now(),
                            ),
                            transactionDetail.tranType
                                        .toString()
                                        .toLowerCase() ==
                                    "trantype.c"
                                ? "Credit"
                                : "Debit" ?? '',
                            transactionDetail.amount?.toStringAsFixed(2) ??
                                '0.00',
                            transactionDetail.tranBalance?.toStringAsFixed(2) ??
                                '0.00',
                            transactionDetail.narration ?? '',
                          ],
                        )
                        .toList(),
                  ],
                ),
              ],
        ),
      );
    } catch (e) {
      debugPrint("Error while creating table in PDF: $e");
    }

    debugPrint(
      "Transactions: ${transactionDetails.map((t) => t.toString()).toList()}",
    );

    // Get the Downloads directory
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      // iOS doesn't have a direct Downloads folder
      downloadsDirectory = await getApplicationDocumentsDirectory();
    } else {
      // For other platforms
      downloadsDirectory = await getDownloadsDirectory();
    }

    ///Store in cache directory of app
    // final output = await getTemporaryDirectory();
    // final file = File("${output.path}/transactions_$searchedDate.pdf");
    final file = File(
      path.join(downloadsDirectory!.path, "transactions_$searchedDate.pdf"),
    );
    await file.writeAsBytes(await pdf.save());
    debugPrint("PDF saved at ${file.path}");
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
      floatingActionButton:
          depositTable!.length == 0
              ? SizedBox.shrink()
              : FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                shape: CircleBorder(),
                tooltip: 'Download PDF',
                child: Icon(Icons.download, color: Colors.white),
                onPressed: () async {
                  await generatePdf(depositTable!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PDF generated successfully!')),
                  );
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => StatementDownload()));
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

                      setState(() {
                        DepositSearchModel depositList =
                            DepositSearchModel.fromJson(response);

                        debugPrint("deposit List : $depositTable");

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
                  : (_isDepositTableEmpty)
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
