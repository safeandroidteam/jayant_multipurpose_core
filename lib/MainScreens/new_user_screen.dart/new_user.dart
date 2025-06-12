import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/branch_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/individual/new_user_ind_1.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/institution/new_user_institution.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Util/StaticValue.dart';
import '../../Util/custom_drop_down.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  late UserBloc userBloc;
  final cntlrs = Textcntlrs();
  String cmpCode = "";
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);

    SharedPreferences pref = StaticValues.sharedPreferences!;
    cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
    userBloc.add(ClearRefEvent());
    userBloc.add(ClearDobEvent());
    warningPrint("CmpCode $cmpCode");
    userBloc.add(GetBranchesEvent());
    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.tryParse(cmpCode) ?? 0, pickUpType: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // final userBloc = UserBloc.get(context);
    return SafeArea(
      child: PopScope(
        canPop: false,

        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("New User", style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Text(
                "Basic Details",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: w * 0.042,
                ),
              ),
              SizedBox(height: h * 0.03),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                buildWhen:
                    (previous, current) =>
                        previous.isPickUpBranchLoading !=
                            current.isPickUpBranchLoading ||
                        previous.branchList != current.branchList,

                builder: (context, state) {
                  if (state.isPickUpBranchLoading) {
                    return SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    final branhcList = state.branchList;
                    // alertPrint("branch List =$branhcList");
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: LabelWithDropDownField<BranchData>(
                        textDropDownLabel: "Branch",
                        hintText:
                            cntlrs.selectedBranch.isEmpty
                                ? "Select Branch"
                                : cntlrs.selectedBranch,
                        items: branhcList,
                        itemAsString: (p0) => p0.brName,
                        onChanged: (value) {
                          cntlrs.selectedBranch = value.brCode.toString();
                        },
                      ),
                    );
                  }
                },
              ),

              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                buildWhen:
                    (previous, current) =>
                        previous.isPickupCustomerTypeLoading !=
                            current.isPickupCustomerTypeLoading ||
                        previous.pickUpCustomerTypeList !=
                            current.pickUpCustomerTypeList,

                builder: (context, state) {
                  //  warningPrint("state in customer type =$state");
                  if (state.isPickupCustomerTypeLoading) {
                    return SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    final customerTypeList = state.pickUpCustomerTypeList;
                    alertPrint("customer Type List =$customerTypeList");
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: LabelWithDropDownField<PickUpTypeResponseModal>(
                        textDropDownLabel: "Customer Type",
                        hintText:
                            cntlrs.selectedCustomerType.isEmpty
                                ? "Select Customer Type"
                                : cntlrs.selectedCustomerType,
                        items: customerTypeList,

                        itemAsString: (item) => item.pkcDescription,

                        onChanged: (value) {
                          cntlrs.selectedCustomerType =
                              value.pkcCode.toString();
                          successPrint(
                            "Selected customer type : ${cntlrs.selectedCustomerType}",
                          );
                          userBloc.add(selectCustomerTypeEvent(value.pkcCode));
                        },
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: LabelWithDropDownField<String>(
                  textDropDownLabel: "Account Type",
                  hintText:
                      cntlrs.selectedAccType.isEmpty
                          ? "Select Account Type"
                          : cntlrs.selectedAccType,
                  items: ["SB", "CA"],

                  onChanged: (value) {
                    cntlrs.selectedAccType = value;
                    successPrint("Selected acc type : $value");
                  },
                ),
              ),

              LabelCustomTextField(
                hintText: "Enter Ref ID",
                textFieldLabel: "Ref ID",
                inputType: TextInputType.number,
                controller: cntlrs.newUserRefIDCntlr,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onchanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    userBloc.add(ValidateRefIDEvent(cmpCode, value));
                  });
                },
              ),
              SizedBox(height: h * 0.02),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.validateRefidResponse != null &&
                      state.validateRefidResponse!.proceedStatus == "N") {
                    GlobalWidgets().showSnackBar(
                      context,
                      state.validateRefidResponse!.proceedMessage,
                    );
                  }
                },

                buildWhen:
                    (previous, current) =>
                        previous.validateRefIDLoading !=
                            current.validateRefIDLoading ||
                        previous.validateRefidResponse !=
                            current.validateRefidResponse,
                builder: (context, state) {
                  if (state.validateRefIDLoading) {
                    return SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.validateRefidResponse != null &&
                      state.validateRefidResponse!.data.isNotEmpty) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(w * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Referred By",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  ": ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state
                                    .validateRefidResponse!
                                    .data
                                    .first
                                    .custName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              SizedBox(height: h * 0.02),
              BlocBuilder<UserBloc, UserState>(
                buildWhen:
                    (previous, current) =>
                        previous.selectedCustomerTypeCode !=
                            current.selectedCustomerTypeCode ||
                        previous.referenceID != current.referenceID,

                builder: (context, state) {
                  return CustomRaisedButton(
                    buttonText: "Continue",
                    onPressed: () {
                      if (cntlrs.selectedBranch.isEmpty &&
                          cntlrs.selectedCustomerType.isEmpty) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Select Branch & Customer Type",
                        );
                      } else if (cntlrs.selectedBranch.isEmpty) {
                        GlobalWidgets().showSnackBar(context, "Select Branch");
                      } else if (cntlrs.selectedCustomerType.isEmpty) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Select Customer Type",
                        );
                      } else if (cntlrs.newUserRefIDCntlr.text.isEmpty ||
                          (state.referenceID?.isEmpty ?? true)) {
                        alertPrint("state.referenceid=${state.referenceID}");
                        GlobalWidgets().showSnackBar(
                          context,
                          "Enter a Valid Ref ID",
                        );
                      } else {
                        if (cntlrs.selectedCustomerType == "46") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      UserIndividualCreation(cntlrs: cntlrs),
                            ),
                          );
                        }
                        if (cntlrs.selectedCustomerType == "11473") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserInstitutionCreation(),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
