import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Search/modal/AccNoModel.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<AccNoDepositEvent>(_onAccNoDepositEventEvent);
  }

  Future<void> _onAccNoDepositEventEvent(
    AccNoDepositEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(AccDepositLoading());

    try {
      // final response = await RestAPI().get(
      //   APis.getAccNoDeposit({
      //     "Cust_id": event.cust_id,
      //     "Acc_Type": event.acc_Type,
      //   }),
      // );

      Map<String, dynamic> accSearchBody = {
        "Cmp_Code": event.cmp_Code,
        "Cust_ID": event.cust_Id,
      };

      final response = await RestAPI().post(
        APis.fillAccountList,
        params: accSearchBody,
      );

      // final accDepList =
      //     (response["Table"] as List<dynamic>)
      //         .map(
      //           (e) => AccTable(
      //             custId: e["Cust_Id"],
      //             column1: column1Values.map[e["Column1"]],
      //             adds: addsValues.map[e["Adds"]],
      //             brName: brNameValues.map[e["Br_Name"]],
      //             accNo: e["Acc_No"],
      //             schCode: e["Sch_Code"],
      //             schName: e["Sch_Name"],
      //             brCode: e["Br_Code"],
      //             depBranch: brNameValues.map[e["Dep_Branch"]],
      //             balance: e["Balance"].toDouble(),
      //             module: moduleValues.map[e["Module"]],
      //           ),
      //         )
      //         .toList();

      final accList =
          (response["Data"] as List<dynamic>)
              .map((e) => AccNoData(accId: e["Acc_ID"], accNo: e["Acc_No"]))
              .toList();
      // customPrint("response=$response");
      emit(AccDepositResponse(accList));

      successPrint("AccDeposit Response =$response");
      successPrint("AccDeposit Length =${accList.length}");
    } on RestException catch (e) {
      emit(AccDepositErrorException(e));
      errorPrint("Acc Dep Response Error=$e");
    }
  }

  static SearchBloc get(context) => BlocProvider.of(context);
}
