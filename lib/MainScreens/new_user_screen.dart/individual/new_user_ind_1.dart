import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/individual/new_user_ind_2.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIndividualCreation extends StatefulWidget {
  const UserIndividualCreation({super.key});

  @override
  State<UserIndividualCreation> createState() => _UserIndividualCreationState();
}

class _UserIndividualCreationState extends State<UserIndividualCreation> {
  String? cmpCode;
  late UserBloc userBloc;
  final cntlrs = Textcntlrs();
  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);
    SharedPreferences pref = StaticValues.sharedPreferences!;
    String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
    alertPrint("CmpCode $cmpCode");

    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 5),
    );
    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "New User Individual",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {},
                  buildWhen:
                      (previous, current) =>
                          previous.isPickupTitleeLoading !=
                          current.isPickupTitleeLoading,
                  listenWhen:
                      (previous, current) =>
                          previous.isPickupTitleeLoading !=
                          current.isPickupTitleeLoading,
                  builder: (context, state) {
                    if (state.isPickupTitleeLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: LabelWithDropDownField<PickUpTypeResponseModal>(
                          textDropDownLabel: "Title",
                          items: state.pickUpTitileList,
                          hintText:
                              cntlrs.selectedIndividualTitle.isEmpty
                                  ? "Select Title"
                                  : cntlrs.selectedIndividualTitle,
                          itemAsString: (e) => e.pkcDescription,
                          onChanged: (val) {
                            cntlrs.selectedIndividualTitle = val.pkcDescription;
                            successPrint(
                              "Title Value Selected ${cntlrs.selectedIndividualTitle}",
                            );
                            successPrint("Title Value Selected $val");
                          },
                        ),
                      );
                    }
                  },
                ),

                LabelCustomTextField(
                  hintText: "First Name",
                  textFieldLabel: "Customer First Name",
                  controller: cntlrs.firstNameCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Middle Name",
                  isOptional: true,
                  textFieldLabel: "Customer Middle Name",
                  controller: cntlrs.middleNameCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Last Name",
                  textFieldLabel: "Customer Last Name",
                  controller: cntlrs.lastNameCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Father Name",
                  textFieldLabel: "Father Name",
                  controller: cntlrs.fatherNameCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Mother Name",
                  textFieldLabel: "Mother Name",
                  controller: cntlrs.motherNameCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Spouse Name",
                  textFieldLabel: "Spouse Name",
                  controller: cntlrs.spouseNameCntlr,
                ),

                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state.dobCustomer != null &&
                        state.dobCustomer!.isNotEmpty) {
                      cntlrs.slectedCustomerDob.text = state.dobCustomer ?? "";
                    }
                  },
                  buildWhen:
                      (previous, current) =>
                          previous.dobCustomer != current.dobCustomer,
                  builder: (context, state) {
                    return LabelCustomTextField(
                      hintText:
                          cntlrs.slectedCustomerDob.text.isEmpty
                              ? "select Date of Birth"
                              : cntlrs.slectedCustomerDob.text,
                      textFieldLabel: "Date of Birth",
                      controller: cntlrs.slectedCustomerDob,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          final formattedDate = DateFormat(
                            'dd-MM-yyyy',
                          ).format(picked);

                          successPrint("pciked date =$formattedDate");
                          userBloc.add(PickCustomerDobEvent(formattedDate));
                        }
                      },
                    );
                  },
                ),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {},
                  buildWhen:
                      (previous, current) =>
                          previous.isPickupGenderLoading !=
                          current.isPickupGenderLoading,
                  listenWhen:
                      (previous, current) =>
                          previous.isPickupGenderLoading !=
                          current.isPickupGenderLoading,

                  builder: (context, state) {
                    if (state.isPickupGenderLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final genderList = state.pickUpGenderList;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: LabelWithDropDownField<PickUpTypeResponseModal>(
                          textDropDownLabel: "Gender",
                          hintText:
                              cntlrs.selectedIndividualGender.isEmpty
                                  ? "Select Gender"
                                  : cntlrs.selectedIndividualGender,
                          itemAsString: (p0) => p0.pkcDescription,
                          items: genderList,
                          onChanged: (value) {
                            cntlrs.selectedIndividualGender =
                                value.pkcDescription;
                            successPrint(
                              "Gender Value Selected ${cntlrs.selectedIndividualGender}",
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                LabelCustomTextField(
                  hintText: "Mobile Number",
                  textFieldLabel: "Primary Mobile Number",
                  controller: cntlrs.customerPrimaryMobileNumberCntlr,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),

                LabelCustomTextField(
                  hintText: "Primary Email",
                  textFieldLabel: "Primary Email",
                  isOptional: true,
                  controller: cntlrs.customerPrimaryEmailCntlr,
                ),
                LabelCustomTextField(
                  hintText: "Aadhar Number",
                  textFieldLabel: "Aadhar Number",
                  controller: cntlrs.customerAadharNumberCntlr,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                ),
                LabelCustomTextField(
                  hintText: "PAN Number",
                  textFieldLabel: "PAN Number",
                  controller: cntlrs.customerPanNumberCntlr,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9]'),
                    ), // allow letters and digits in any case
                    LengthLimitingTextInputFormatter(10), // limit length to 10
                    UpperCaseTextFormatter(), // convert input to uppercase
                  ],
                ),
                LabelCustomTextField(
                  hintText: "Qualification",
                  textFieldLabel: "Qualification",
                  controller: cntlrs.customerQualificationCntlr,
                ),
                LabelCustomTextField(
                  hintText: "CKYC Number",
                  textFieldLabel: "CKYC Number",
                  controller: cntlrs.customerCkycNumberCntlr,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ],
                ),
                SizedBox(height: h * 0.03),
                SizedBox(
                  width: w,
                  child: CustomRaisedButton(
                    buttonText: "Continue",
                    onPressed: () {
                      bool isEmpty(String? val) =>
                          val == null || val.trim().isEmpty;

                      // Check if all required fields are empty
                      bool allEmpty =
                          isEmpty(cntlrs.selectedIndividualTitle) &&
                          isEmpty(cntlrs.firstNameCntlr.text) &&
                          isEmpty(cntlrs.lastNameCntlr.text) &&
                          isEmpty(cntlrs.fatherNameCntlr.text) &&
                          isEmpty(cntlrs.motherNameCntlr.text) &&
                          isEmpty(cntlrs.selectedIndividualGender) &&
                          isEmpty(cntlrs.slectedCustomerDob.text) &&
                          isEmpty(
                            cntlrs.customerPrimaryMobileNumberCntlr.text,
                          ) &&
                          isEmpty(cntlrs.customerAadharNumberCntlr.text) &&
                          isEmpty(cntlrs.customerPanNumberCntlr.text) &&
                          isEmpty(cntlrs.customerQualificationCntlr.text) &&
                          isEmpty(cntlrs.customerCkycNumberCntlr.text);

                      if (allEmpty) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please fill out the form",
                        );
                        return;
                      }

                      // Individual field checks
                      if (isEmpty(cntlrs.selectedIndividualTitle)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please select a title",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.firstNameCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter first name",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.lastNameCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter last name",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.fatherNameCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter father name",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.motherNameCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter mother name",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.selectedIndividualGender)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please select gender",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.slectedCustomerDob.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please select date of birth",
                        );
                        return;
                      }
                      if (isEmpty(
                        cntlrs.customerPrimaryMobileNumberCntlr.text,
                      )) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter primary mobile number",
                        );
                        return;
                      } else if (cntlrs
                              .customerPrimaryMobileNumberCntlr
                              .text
                              .length !=
                          10) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Enter valid 10-digit mobile number",
                        );
                        return;
                      }

                      if (isEmpty(cntlrs.customerAadharNumberCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter Aadhar number",
                        );
                        return;
                      } else if (cntlrs.customerAadharNumberCntlr.text.length !=
                          12) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Aadhar must be 12 digits",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.customerPanNumberCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter PAN number",
                        );
                        return;
                      } else if (cntlrs.customerPanNumberCntlr.text.length !=
                          10) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "PAN must be 10 characters",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.customerQualificationCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter qualification",
                        );
                        return;
                      }
                      if (isEmpty(cntlrs.customerCkycNumberCntlr.text)) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please enter CKYC number",
                        );
                        return;
                      } else if (cntlrs.customerCkycNumberCntlr.text.length !=
                          14) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "CKYC must be 14 digits",
                        );
                        return;
                      }

                      // ✅ All validations passed → Go to next page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserIndividualCreation2(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, double w) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: w * 0.042,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
