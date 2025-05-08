import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Passbook/Model/LoanTransModel.dart';
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
    on<LoanTransEvent>(_onLoanTransEvent);
  }

  Future<void> _onPassBookDPSHCardEvent(
    PassBookDPSHCardEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(DPSHCardLoading());

    try {
      final response = await RestAPI().get(
        "${APis.otherAccListInfo}${event.custID}&Acc_Type=${event.widgetType}",
      );

      final dpshCardList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) => PassbookItem(
                  custId: e['Cust_Id'],
                  custName: e['Cust_Name'],
                  adds: e['Adds'],
                  brName: e['Br_Name'],
                  accNo: e['Acc_No'],
                  address: e["Adds"],
                  schCode: e['Sch_Code'],
                  schName: e['Sch_Name'],
                  brCode: e['Br_Code'],
                  depBranch: e['Dep_Branch'],
                  balance: e['Balance'],
                  module: e['Module'],
                ),
              )
              .toList();
      emit(DPSHCardResponse(dpshCardList));

      successPrint("DPSHCardResponse =$response");
      successPrint("DPSH Card Length =${dpshCardList.length}");
    } on RestException catch (e) {
      emit(DPSHCardErrorException(e));
      errorPrint("DPSHCardResponse Error=$e");
    }
  }

  Future<void> _onDepositShareTransactionEvent(
    DepositShareTransactionEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(DepositShareTransactionLoading());

    try {
      final response = await RestAPI().get(
        "${event.isShare ? APis.getShareTransaction : APis.getDepositTransaction}${event.custID}&Acc_no=${event.accNo}&Sch_code=${event.schCode}&Br_code=${event.brCode}&Frm_Date=${""}",
      );
      alertPrint("requestedData====requestedData");
      alertPrint("isShare====${event.isShare}");
      alertPrint("custID====${event.custID}");
      alertPrint("accNo====${event.accNo}");
      alertPrint("accNo====${event.brCode}");
      final transactionList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) => TransactionItem(
                  id: e['ID'],
                  accNo: e['Acc_No'],
                  schCode: e['Sch_Code'],
                  brCode: e['Br_Code'],
                  trDate: DateTime.parse(e['Tr_Date']),
                  tranType: e['Tran_Type'],
                  display: e['Display'],
                  amount: e['Amount'],
                  narration: e['Narration'],
                  balance: e['balance'],
                  seqNo: e['Seq_No'],
                  show: e['Show'],
                  dailyBalance: e['DailyBalance'],
                  tranBalance: e['TranBalance'],
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
      final response = await RestAPI().get(
        "${APis.otherAccListInfo}${event.custID}&Acc_Type=${event.type ?? "LN"}",
      );

      final chittyLoanList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) => PassbookItem(
                  custId: e['Cust_Id'],
                  custName: e['Cust_Name'],
                  adds: e['Adds'],
                  brName: e['Br_Name'],
                  accNo: e['Acc_No'],
                  address: e["Adds"],
                  schCode: e['Sch_Code'],
                  schName: e['Sch_Name'],
                  brCode: e['Br_Code'],
                  depBranch: e['Dep_Branch'],
                  balance: e['Balance'],
                  module: e['Module'],
                ),
              )
              .toList();
      emit(ChittyLoanResponse(chittyLoanList));

      successPrint("ChittyLoanResponse =$response");
      successPrint("CHitty Loan Length =${chittyLoanList.length}");
    } on RestException catch (e) {
      emit(ChittyLoanErrorException(e));
      errorPrint("DPSHCardResponse Error=$e");
    }
  }

  Future<void> _onLoanTransEvent(
    LoanTransEvent event,
    Emitter<PassBookState> emit,
  ) async {
    emit(LoanTransactionLoading());

    try {
      final response = await RestAPI().get(
        "${APis.getLoanPassbook}${event.accNo}",
      );

      final LoanTransList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) => LoanTransTable(
                   trdate: e["TRDATE"],
                  amount: e["AMOUNT"],
                  drcr: e["DRCR"],
                  interest: e["INTEREST"],
                  charges: e["CHARGES"],
                  total: e["TOTAL"],
                  balance: e["BALANCE"],
                  narration: e["NARRATION"],
                ),
              )
              .toList();
      emit(LoanTransactionResponse(LoanTransList));

      successPrint("Loan Trans Response =$response");
      successPrint("Loan Trans Length =${LoanTransList.length}");
    } on RestException catch (e) {
      emit(LoanTransactionErrorException(e));
      errorPrint("Loan TransResponse Error=$e");
    }
  }

  static PassBookBloc get(context) => BlocProvider.of(context);
}
