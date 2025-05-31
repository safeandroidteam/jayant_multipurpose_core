import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Search/modal/AccNoModel.dart';
import 'package:passbook_core_jayant/Search/modal/AccStatementSearchModel.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_alert_dialogue.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<AccNoDepositEvent>(_onAccNoDepositEventEvent);
    on<PdfDownloadEvent>(_pdfDownloadEvent);
  }

  Future<void> _onAccNoDepositEventEvent(
    AccNoDepositEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(AccDepositLoading());

    try {
      Map<String, dynamic> accSearchBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custId,
      };
      final response = await RestAPI().post(
        APis.fillAccountList,
        params: accSearchBody,
      );
      final accList =
          (response["Data"] as List<dynamic>)
              .map((e) => AccNoData(accId: e["Acc_ID"], accNo: e["Acc_No"]))
              .toList();
      customPrint("response=$response");
      emit(AccDepositResponse(accList));

      successPrint("AccDeposit Response =$response");
      successPrint("AccDeposit Length =${accList.length}");
    } on RestException catch (e) {
      emit(AccDepositErrorException(e));
      errorPrint("Acc Dep Response Error=$e");
    }
  }

  void _pdfDownloadEvent(
    PdfDownloadEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(PdfDownloadStateInitial());
    try {
      emit(PdfDownloadLoading());
      final pdf = pw.Document();
      SharedPreferences pref = await SharedPreferences.getInstance();
      String custName = pref.getString(StaticValues.accName) ?? "";
      String searchedDate = "From(${event.fromDate})-To(${event.toDate})";
      if (event.transList.isNotEmpty &&
          (event.transList.first.accNo.isNotEmpty)) {
        String searchedReportDate =
            (event.fromDate == event.toDate)
                ? "of ${event.fromDate}"
                : "from  ${event.fromDate} to ${event.toDate}";

        final depAccNo =
            event.transList.isNotEmpty && event.transList.first.accNo.isNotEmpty
                ? event.transList.first.accNo.toString()
                : 'N/A';

        String last4Digits =
            (event.transList.first.accNo.length >= 4)
                ? event.transList.first.accNo.substring(
                  event.transList.first.accNo.length - 4,
                )
                : "0000"; // or any fallback value
        // fallback if accNo has fewer than 4 digits

        /// Can't add image directly in pdf, need to convert it to bytes
        final imageBytes = await rootBundle.load('assets/mini-logo.png');
        final logoImage = pw.MemoryImage(imageBytes.buffer.asUint8List());

        if (event.transList.isEmpty) {
          alertPrint("No transactions available to generate PDF.");
          return;
        } else if (event.transList.isNotEmpty) {
          alertPrint("Transactions available to generate PDF.");
          alertPrint("Transaction count: ${event.transList.length}");
          for (var e in event.transList) {
            print(e.toJson());
          }
        }

        try {
          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              // Show footer only if more than one page
              footer: (context) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Divider(),
                    pw.Text(
                      'This is a computer-generated report. It does not require any signature or stamp. '
                      'This document is intended solely for personal account reference and should not be used '
                      'for any official or legal purpose.',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        'Page ${context.pageNumber} of ${context.pagesCount}',
                        style: pw.TextStyle(fontSize: 9, color: PdfColors.grey),
                      ),
                    ),
                  ],
                );
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
                        pw.Text('Name : ', style: pw.TextStyle(fontSize: 14)),
                        pw.Text(
                          custName.toUpperCase(),
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
                      headerDecoration: pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      cellAlignment: pw.Alignment.centerLeft,
                      columnWidths: {
                        0: const pw.FlexColumnWidth(3), // Date
                        1: const pw.FlexColumnWidth(4), // Acc No
                        2: const pw.FlexColumnWidth(2), // Type
                        3: const pw.FlexColumnWidth(4), // Amount
                        4: const pw.FlexColumnWidth(4), //Balance
                        5: const pw.FlexColumnWidth(
                          7,
                        ), // Narration (longer text)
                      },
                      data: <List<String>>[
                        <String>[
                          'Date',
                          'Account No',
                          'Type',
                          'Amount',
                          'Balance',
                          'Narration',
                        ],
                        ...event.transList.map(
                          (e) => [
                            e.trDate.toString() ?? '',
                            e.accNo.toString() ?? "",
                            e.tranType.toString() == "1" ? "Credit" : "Debit",

                            e.amount.toString() ?? '0.00',
                            e.balAmt.toString() ?? '0.00',
                            e.remarks.toString() ?? '',
                          ],
                        ),
                      ],
                    ),
                  ],
            ),
          );
        } catch (e) {
          errorPrint("Error while creating table in PDF: $e");
        }

        customPrint(
          "Transactions: ${event.transList.map((t) => t.toString()).toList()}",
        );

        final pdfBytes = await pdf.save();

        // Add password protection using Syncfusion
        final doc = sf.PdfDocument(inputBytes: pdfBytes);

        //Add security to the document.
        final sf.PdfSecurity security = doc.security;

        security.userPassword = last4Digits;
        security.ownerPassword = 'owner@$last4Digits';

        //Set the encryption algorithm.
        security.algorithm = sf.PdfEncryptionAlgorithm.aesx256Bit;

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

        //Save the document.
        final protectedBytes = await doc.save();
        final file = File(
          "${downloadsDirectory!.path}/transactions_$searchedDate.pdf",
        );
        await file.writeAsBytes(protectedBytes);
        emit(PdfDownloadSucess());
        showCustomAlertDialog(
          context: event.context,
          title: "Success",
          content:
              "Your PDF has been downloaded successfully and is password-protected.\n\n🔐 *Password*: Last 4 digits of your Account Number",
          onConfirm: () {
            Navigator.of(event.context).pop();
          },
          confirmText: "OK",
        );

        customPrint("Password-protected PDF saved at ${file.path}");

        //Dispose the document.
        doc.dispose();

        ///Without password protected file using pdf package
        // Get the Downloads directory
        // Directory? downloadsDirectory;
        // if (Platform.isAndroid) {
        //   downloadsDirectory = Directory('/storage/emulated/0/Download');
        // } else if (Platform.isIOS) {
        //   // iOS doesn't have a direct Downloads folder
        //   downloadsDirectory = await getApplicationDocumentsDirectory();
        // } else {
        //   // For other platforms
        //   downloadsDirectory = await getDownloadsDirectory();
        // }
        //
        // ///Store in cache directory of app
        // // final output = await getTemporaryDirectory();
        // // final file = File("${output.path}/transactions_$searchedDate.pdf");
        // final file = File(
        //   path.join(downloadsDirectory!.path, "transactions_$searchedDate.pdf"),
        // );
        // await file.writeAsBytes(await pdf.save());
        // debugPrint("PDF saved at ${file.path}");
      } else {
        emit(PdfDownloadError());
      }
    } catch (e) {
      emit(PdfDownloadError());
      GlobalWidgets().showSnackBar(event.context, "PDF Generation Failed $e");
    }
  }

  static SearchBloc get(context) => BlocProvider.of(context);
}
