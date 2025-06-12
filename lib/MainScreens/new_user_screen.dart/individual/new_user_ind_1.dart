import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  const UserIndividualCreation({super.key, required this.cntlrs});
  final Textcntlrs cntlrs;
  @override
  State<UserIndividualCreation> createState() => _UserIndividualCreationState();
}

class _UserIndividualCreationState extends State<UserIndividualCreation> {
  String? cmpCode;
  late UserBloc userBloc;

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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "New User Individual",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
              onPressed: () {
                userBloc.add(ClearDobEvent());
                widget.cntlrs.individualClear();
                Navigator.of(context).pop();
              },
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
                          child: LabelWithDropDownField<
                            PickUpTypeResponseModal
                          >(
                            textDropDownLabel: "Title",
                            items: state.pickUpTitileList,
                            hintText: "Select Title",
                            isHintvalue:
                                widget.cntlrs.selectedIndividualTitle.isEmpty
                                    ? false
                                    : true,
                            labelText:
                                widget.cntlrs.selectedIndividualTitle.isEmpty
                                    ? "Select Title"
                                    : widget.cntlrs.selectedIndividualTitle,

                            showSelectedItems: true,

                            itemAsString: (e) => e.pkcDescription,
                            onChanged: (val) {
                              widget.cntlrs.selectedIndividualTitle =
                                  val.pkcCode.toString();
                              successPrint(
                                "Title Value Selected ${widget.cntlrs.selectedIndividualTitle}",
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
                    controller: widget.cntlrs.firstNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Middle Name",
                    isOptional: true,
                    textFieldLabel: "Customer Middle Name",
                    controller: widget.cntlrs.middleNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Last Name",
                    textFieldLabel: "Customer Last Name",
                    controller: widget.cntlrs.lastNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Father Name",
                    textFieldLabel: "Father Name",
                    controller: widget.cntlrs.fatherNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Mother Name",
                    textFieldLabel: "Mother Name",
                    controller: widget.cntlrs.motherNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Spouse Name",
                    textFieldLabel: "Spouse Name",
                    controller: widget.cntlrs.spouseNameCntlr,
                    textInputAction: TextInputAction.next,
                  ),

                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state.dobCustomer != null &&
                          state.dobCustomer!.isNotEmpty) {
                        widget.cntlrs.slectedCustomerDob.text =
                            state.dobCustomer ?? "";
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            previous.dobCustomer != current.dobCustomer,
                    builder: (context, state) {
                      return LabelCustomTextField(
                        hintText:
                            widget.cntlrs.slectedCustomerDob.text.isEmpty
                                ? "select Date of Birth"
                                : widget.cntlrs.slectedCustomerDob.text,
                        textFieldLabel: "Date of Birth",
                        controller: widget.cntlrs.slectedCustomerDob,
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
                          child: LabelWithDropDownField<
                            PickUpTypeResponseModal
                          >(
                            textDropDownLabel: "Gender",
                            isHintvalue:
                                widget.cntlrs.selectedIndividualGender.isEmpty
                                    ? false
                                    : true,
                            hintText: "Select Gender",
                            labelText:
                                widget.cntlrs.selectedIndividualGender.isEmpty
                                    ? "Select Gender"
                                    : widget.cntlrs.selectedIndividualGender,
                            itemAsString: (p0) => p0.pkcDescription,
                            items: genderList,
                            onChanged: (value) {
                              widget.cntlrs.selectedIndividualGender =
                                  value.pkcCode.toString();
                              successPrint(
                                "Gender Value Selected ${widget.cntlrs.selectedIndividualGender}",
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
                    controller: widget.cntlrs.customerPrimaryMobileNumberCntlr,
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),

                  LabelCustomTextField(
                    hintText: "Primary Email",
                    textFieldLabel: "Primary Email",
                    isOptional: true,
                    controller: widget.cntlrs.customerPrimaryEmailCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "Aadhar Number",
                    textFieldLabel: "Aadhar Number",
                    controller: widget.cntlrs.customerAadharNumberCntlr,
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                  ),
                  LabelCustomTextField(
                    hintText: "PAN Number",
                    textFieldLabel: "PAN Number",
                    controller: widget.cntlrs.customerPanNumberCntlr,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9]'),
                      ), // allow letters and digits in any case
                      LengthLimitingTextInputFormatter(
                        10,
                      ), // limit length to 10
                      UpperCaseTextFormatter(), // convert input to uppercase
                    ],
                  ),
                  LabelCustomTextField(
                    hintText: "Qualification",
                    textFieldLabel: "Qualification",
                    controller: widget.cntlrs.customerQualificationCntlr,
                    textInputAction: TextInputAction.next,
                  ),
                  LabelCustomTextField(
                    hintText: "CKYC Number",
                    textFieldLabel: "CKYC Number",
                    controller: widget.cntlrs.customerCkycNumberCntlr,
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
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
                            isEmpty(widget.cntlrs.selectedIndividualTitle) &&
                            isEmpty(widget.cntlrs.firstNameCntlr.text) &&
                            isEmpty(widget.cntlrs.lastNameCntlr.text) &&
                            isEmpty(widget.cntlrs.fatherNameCntlr.text) &&
                            isEmpty(widget.cntlrs.motherNameCntlr.text) &&
                            isEmpty(widget.cntlrs.selectedIndividualGender) &&
                            isEmpty(widget.cntlrs.slectedCustomerDob.text) &&
                            isEmpty(
                              widget
                                  .cntlrs
                                  .customerPrimaryMobileNumberCntlr
                                  .text,
                            ) &&
                            isEmpty(
                              widget.cntlrs.customerAadharNumberCntlr.text,
                            ) &&
                            isEmpty(
                              widget.cntlrs.customerPanNumberCntlr.text,
                            ) &&
                            isEmpty(
                              widget.cntlrs.customerQualificationCntlr.text,
                            ) &&
                            isEmpty(widget.cntlrs.customerCkycNumberCntlr.text);

                        if (allEmpty) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please fill out the form",
                          );
                          return;
                        }

                        // Individual field checks
                        if (isEmpty(widget.cntlrs.selectedIndividualTitle)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please select a title",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.firstNameCntlr.text)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter first name",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.lastNameCntlr.text)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter last name",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.fatherNameCntlr.text)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter father name",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.motherNameCntlr.text)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter mother name",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.selectedIndividualGender)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please select gender",
                          );
                          return;
                        }
                        if (isEmpty(widget.cntlrs.slectedCustomerDob.text)) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please select date of birth",
                          );
                          return;
                        }
                        if (isEmpty(
                          widget.cntlrs.customerPrimaryMobileNumberCntlr.text,
                        )) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter primary mobile number",
                          );
                          return;
                        } else if (widget
                                .cntlrs
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

                        if (isEmpty(
                          widget.cntlrs.customerAadharNumberCntlr.text,
                        )) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter Aadhar number",
                          );
                          return;
                        } else if (widget
                                .cntlrs
                                .customerAadharNumberCntlr
                                .text
                                .length !=
                            12) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Aadhar must be 12 digits",
                          );
                          return;
                        }
                        if (isEmpty(
                          widget.cntlrs.customerPanNumberCntlr.text,
                        )) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter PAN number",
                          );
                          return;
                        } else if (widget
                                .cntlrs
                                .customerPanNumberCntlr
                                .text
                                .length !=
                            10) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "PAN must be 10 characters",
                          );
                          return;
                        }
                        if (isEmpty(
                          widget.cntlrs.customerQualificationCntlr.text,
                        )) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter qualification",
                          );
                          return;
                        }
                        if (isEmpty(
                          widget.cntlrs.customerCkycNumberCntlr.text,
                        )) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Please enter CKYC number",
                          );
                          return;
                        } else if (widget
                                .cntlrs
                                .customerCkycNumberCntlr
                                .text
                                .length !=
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
                            builder:
                                (context) => UserIndividualCreation2(
                                  cntlrs: widget.cntlrs,
                                ),
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
