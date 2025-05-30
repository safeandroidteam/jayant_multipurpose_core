import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Passbook/Model/ChittyLoanTransModel.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/Passbook/Model/TransactionModel.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

part 'pass_book_event.dart';
part 'pass_book_state.dart';

class PassBookBloc extends Bloc<PassBookEvent, PassBookState> {
  PassBookBloc() : super(PassBookBlocInitial()) {
    on<PassBookDPSHCardEvent>(_onPassBookDPSHCardEvent);
    on<DepositShareTransactionEvent>(_onDepositShareTransactionEvent);
    on<CurrentPageChanged>(_onCurrentPageChanged);
    on<ChittyLoanEvent>(_onChittyLoanEvent);
    on<ChittyLoanTransEvent>(_onLoanTransEvent);
  }

  Future<void> _onPassBookDPSHCardEvent(
    PassBookDPSHCardEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(DPSHCardLoading());

    try {
      Map<String, dynamic> pasbbokDPSHBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      alertPrint("passbook dpsh card boay =$pasbbokDPSHBody");

      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: pasbbokDPSHBody,
      );
      final dpshCardList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => PassbookItem(
                  custId: e['Cust_ID'] ?? "",
                  custName: e['Cust_Name'] ?? "",
                  adds: e['Full_Address'] ?? "",
                  brName: e['Br_Name'] ?? "",
                  accNo: e['ACC_No'] ?? "",
                  address: e["Full_Address"] ?? "",
                  schCode: e['Sch_Code'] ?? "",
                  schName: e['Sch_Name'] ?? "",
                  brCode: e['Br_Code'] ?? "",
                  depBranch: e['Dep_Branch'] ?? "",
                  balance: e['Balance'] ?? "",
                  module: e['Module'] ?? "",
                  accId: e["Acc_ID"] ?? "",
                ),
              )
              .toList();
      emit(DPSHCardResponse(dpshCardList));

      successPrint("DPSHCardResponse =$response");
      successPrint("DPSH Card Length =${dpshCardList.length}");
    } on RestException catch (e) {
      emit(DPSHCardErrorException(e));
      errorPrint("DPSHCardResponse Error=");
    }
  }

  Future<void> _onDepositShareTransactionEvent(
    DepositShareTransactionEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(DepositShareTransactionLoading());

    try {
      Map<String, dynamic> transactionBody = {
        "Cmp_Code": event.cmpCode,
        "Acc_ID": event.accid,
      };
      final response = await RestAPI().post(
        APis.fetchTransactions,
        params: transactionBody,
      );

      alertPrint("requestedData====$transactionBody");
      final transactionList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => TransactionItem(
                  id: e["Tran_ID"],
                  trDate: e["Tr_Date"],
                  caption: e["Caption"],
                  amount: e["Amount"],
                  tranType: e["Tran_Type"],
                  balance: e["Bal_Amt"],
                  balType: e["Bal_Type"],
                  remarks: e["Remarks"],
                ),
              )
              .toList();
      emit(DepositShareTransactionResponse(transactionList));

      successPrint("Transactions =$response");
      successPrint("Transaction Length =${transactionList.length}");
    } on RestException catch (e) {
      emit(DepositShareTransactionErrorException(e));
      errorPrint("Transaction Error=$e");
    }
  }

  void _onCurrentPageChanged(
    CurrentPageChanged event,
    Emitter<PassBookState> emit,
  ) {
    emit(CurrentPageState(event.currentPage));
    alertPrint("page changed to ${event.currentPage}");
  }

  Future<void> _onChittyLoanEvent(
    ChittyLoanEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(ChittyLoanLoading());

    try {
      Map<String, dynamic> chittyLoanBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      alertPrint("passbook chitty Loan card body =$chittyLoanBody");

      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: chittyLoanBody,
      );

      final chittyLoanList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => PassbookItem(
                  custId: e['Cust_ID'] ?? "",
                  custName: e['Cust_Name'] ?? "",
                  adds: e['Full_Address'] ?? "",
                  brName: e['Br_Name'] ?? "",
                  accNo:
                      event.section.toLowerCase() == "loan"
                          ? e['LoanNo']
                          : e['ACC_No'] ?? "",
                  address: e["Full_Address"] ?? "",
                  schCode: e['Sch_Code'] ?? "",
                  schName:
                      event.section.toLowerCase() == "loan"
                          ? e['Loan_Type']
                          : e['Sch_Name'] ?? "",
                  brCode: e['Br_Code'] ?? "",
                  depBranch:
                      event.section.toLowerCase() == "loan"
                          ? e['Loan_BrName']
                          : e['MSS_Branch'] ?? "",
                  balance: e['Balance'] ?? "",
                  module: e['Module'] ?? "",
                  accId: e["Acc_ID"] ?? "",
                ),
              )
              .toList();
      emit(ChittyLoanResponse(chittyLoanList));

      successPrint("Chitty LoanResponse =$response");
      successPrint("CHitty Loan Length =${chittyLoanList.length}");
    } on RestException catch (e) {
      emit(ChittyLoanErrorException(e));
      errorPrint("DPSHCardResponse Error=$e");
    }
  }

  Future<void> _onLoanTransEvent(
    ChittyLoanTransEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(ChittyLoanTransLoading());

    try {
      // final response = await RestAPI().get(
      //   "${APis.getLoanPassbook}${event.accNo}",
      // );

      Map<String, dynamic> loanBody = {
        "Cmp_Code": event.cmpCode,
        "Acc_ID": event.accID,
      };
      final response = await RestAPI().post(
        APis.fetchLoanPassbookDetails,
        params: loanBody,
      );

      // final LoanTransList =
      //     (response["Table"] as List<dynamic>)
      //         .map(
      //           (e) => LoanTransTable(
      //             trdate: e["TRDATE"],
      //             amount: e["AMOUNT"],
      //             drcr: e["DRCR"],
      //             interest: e["INTEREST"],
      //             charges: e["CHARGES"],
      //             total: e["TOTAL"],
      //             balance: e["BALANCE"],
      //             narration: e["NARRATION"],
      //           ),
      //         )
      //         .toList();

      final LoanTransList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => ChittyLoanTransData(
                  trDate: e["Tr_Date"],
                  creditAmt: e["Credit_Amt"],
                  debitAmt: e["Debit_Amt"],
                  interestCr: e["Interest_Cr"],
                  interestDr: e["Interest_Dr"],
                  chrgCr: e["Chrg_Cr"],
                  chrgDr: e["Chrg_Dr"],
                  totalCr: e["Total_Cr"],
                  totalDr: e["Total_Dr"],
                  totalAmt: e["Total_Amt"],
                  balAmt: e["Bal_Amt"],
                  balType: e["Bal_Type"],
                  remarks: e["Remarks"],
                ),
              )
              .toList();
      emit(ChittyLoanTransResponse(LoanTransList));

      successPrint("Loan Trans Response =$response");
      successPrint("Loan Trans Length =${LoanTransList.length}");
    } on RestException catch (e) {
      emit(ChittyLoanTransErrorException(e));
      errorPrint("Loan TransResponse Error=$e");
    }
  }

  static PassBookBloc get(context) => BlocProvider.of(context);
}
