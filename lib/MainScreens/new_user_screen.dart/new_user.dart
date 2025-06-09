import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/individual/new_user_ind_1.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/institution/new_user_institution.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
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
  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);

    SharedPreferences pref = StaticValues.sharedPreferences!;
    String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";

    warningPrint("CmpCode $cmpCode");
    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // final userBloc = UserBloc.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New User", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
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
            LabelWithDropDownField(
              textDropDownLabel: "Branch",
              items: ["A", "B"],
              onChanged: (value) {
                cntlrs.selectedBranch = value;
              },
            ),

            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {},
              buildWhen:
                  (previous, current) =>
                      previous.isPickupCustomerTypeLoading !=
                      current.isPickupCustomerTypeLoading,
              listenWhen:
                  (previous, current) =>
                      previous.isPickupCustomerTypeLoading !=
                      current.isPickupCustomerTypeLoading,

              builder: (context, state) {
                warningPrint("state in customer type =$state");
                if (state.isPickupCustomerTypeLoading) {
                  return SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  final customerTypeList = state.pickUpCustomerTypeList;
                  alertPrint("customer Type List =$customerTypeList");
                  return LabelWithDropDownField<PickUpTypeResponseModal>(
                    textDropDownLabel: "Customer Type",
                    hintText:
                        cntlrs.selectedCustomerType.isEmpty
                            ? "Select Customer Type"
                            : cntlrs.selectedCustomerType,
                    items: customerTypeList,

                    itemAsString: (item) => item.pkcDescription,
                    onChanged: (value) {
                      cntlrs.selectedCustomerType = value.pkcDescription;
                      successPrint("Selected customer type : $value");
                      userBloc.add(selectCustomerTypeEvent(value.pkcCode));
                    },
                  );
                }
              },
            ),
            SizedBox(height: h * 0.02),
            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      previous.selectedCustomerTypeCode !=
                      current.selectedCustomerTypeCode,

              builder: (context, state) {
                return CustomRaisedButton(
                  buttonText: "Continue",
                  onPressed: () {
                    customPrint(
                      "selected customer Type =${cntlrs.selectedCustomerType}",
                    );
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
                    } else {
                      if (cntlrs.selectedCustomerType == "INDIVIDUAL") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserIndividualCreation(),
                          ),
                        );
                      }
                      if (cntlrs.selectedCustomerType == "INSTITUTION") {
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
    );
  }
}
