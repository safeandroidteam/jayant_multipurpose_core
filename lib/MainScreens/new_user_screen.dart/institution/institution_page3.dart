import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/institution/address_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/institution_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Util/GlobalWidgets.dart';
import '../../../Util/StaticValue.dart';
import '../../../Util/custom_drop_down.dart';
import '../../../Util/custom_print.dart';
import '../../../Util/custom_textfield.dart';
import '../../Login.dart';
import '../../Model/institution/intitutionUiReqModel.dart';
import '../../Model/institution/proprietor_modal.dart';
import '../../bloc/user/controllers/text_controllers.dart';

class InstitutionPage3 extends StatefulWidget {
  const InstitutionPage3({
    super.key,
    required this.proprietors,
    required this.cntlrs,
  });
  final Textcntlrs cntlrs;
  final List<ProprietorModal> proprietors;
  @override
  State<InstitutionPage3> createState() => _InstitutionPage3State();
}

class _InstitutionPage3State extends State<InstitutionPage3> {
  String cmpCode = "";
  bool isAccepted = false;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);
    isSameAsPermanent =
        widget.cntlrs.institutionCurrentAddress1.text.isEmpty ? false : true;
    SharedPreferences pref = StaticValues.sharedPreferences!;
    cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
    alertPrint("CmpCode $cmpCode");

    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 8),
    );

    successPrint('''
                          
                          BR Code - ${widget.cntlrs.selectedBranch}
                          Customer Type - ${widget.cntlrs.selectedCustomerType}
                          Account Type - ${widget.cntlrs.selectedAccType}
                          Reference ID - ${widget.cntlrs.newUserRefIDCntlr.text}

                          
                      ------FIRM DETAILS------
                    Firm Name: ${widget.cntlrs.firmName.text}  
                  Firm Reg No: ${widget.cntlrs.firmReg_No.text}  
                  Firm Primary Email: ${widget.cntlrs.institutionPrimaryEmail.text} 
                  Mobile No: ${widget.cntlrs.institutionMobileNo.text}   
                  Firm GSTIN: ${widget.cntlrs.institutionFirmGstin.text}  
                  Firm Establishment Date: ${widget.cntlrs.institutionFirmStartDate.text}  
                  Firm Place: ${widget.cntlrs.institutionFirmPlace.text}  
                  Turn Over: ${widget.cntlrs.turnOver.text}  
                  Firm PAN Card Number: ${widget.cntlrs.institutionFirmPanCard.text}  
                  Uploaded PAN Card Image: ${widget.cntlrs.institutionPanCardImage != null ? 'Yes' : 'No'}  
                  Uploaded Base 64: ${widget.cntlrs.institutionPanCardImageBase64}    
                  ----------------------------  
                     
                  "✅ Saved Proprietor ${widget.proprietors}
                      
                  --------- Permanent Address ---------
                  Address 1: ${widget.cntlrs.institutionPermanentAddress1.text}
                  Address 2: ${widget.cntlrs.institutionPermanentAddress2.text}
                  Address 3: ${widget.cntlrs.institutionPermanentAddress3.text}
                  City/Town/Village: ${widget.cntlrs.institutionPermanentCity.text}
                  Taluk: ${widget.cntlrs.institutionPermanentTaluk.text}
                  District: ${widget.cntlrs.institutionPermanentDistrict.text}
                  State: ${widget.cntlrs.institutionPermanentState.text}
                  Country: ${widget.cntlrs.institutionPermanentCountry.text}
                  Pincode: ${widget.cntlrs.institutionPermanentPinCode.text}
                  
                  --------- Current Address ---------
                  Address 1: ${widget.cntlrs.institutionCurrentAddress1.text}
                  Address 2: ${widget.cntlrs.institutionCurrentAddress2.text}
                  Address 3: ${widget.cntlrs.institutionCurrentAddress3.text}
                  City/Town/Village: ${widget.cntlrs.institutionCurrentCity.text}
                  Taluk: ${widget.cntlrs.institutionCurrentTaluk.text}
                  District: ${widget.cntlrs.institutionCurrentDistrict.text}
                  State: ${widget.cntlrs.institutionCurrentState.text}
                  Country: ${widget.cntlrs.institutionCurrentCountry.text}
                  PinCode: ${widget.cntlrs.institutionCurrentPinCode.text}
                  ''');
  }

  bool isSameAsPermanent = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    TextInputFormatter blockSpecialCharacters() {
      return FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s&\-,.'@]"));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Institution Creation",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Permanent Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1.2),
              const SizedBox(height: 12),

              LabelCustomTextField(
                hintText: "Address 1",
                textFieldLabel: "Address 1",
                lines: 2,
                controller: widget.cntlrs.institutionPermanentAddress1,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 2",
                textFieldLabel: "Address 2",
                lines: 2,
                controller: widget.cntlrs.institutionPermanentAddress2,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 3",
                textFieldLabel: "Address 3",
                lines: 2,
                controller: widget.cntlrs.institutionPermanentAddress3,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "City/Town/Village",
                textFieldLabel: "City/Town/Village",
                controller: widget.cntlrs.institutionPermanentCity,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Taluk",
                textFieldLabel: "Taluk",
                controller: widget.cntlrs.institutionPermanentTaluk,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "District",
                textFieldLabel: "District",
                controller: widget.cntlrs.institutionPermanentDistrict,
                textInputAction: TextInputAction.done,
              ),
              LabelCustomTextField(
                hintText: "State",
                textFieldLabel: "State",
                controller: widget.cntlrs.institutionPermanentState,
                textInputAction: TextInputAction.next,
              ),

              LabelCustomTextField(
                hintText: "Country",
                textFieldLabel: "Country",
                controller: widget.cntlrs.institutionPermanentCountry,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Post Office Pincode",
                textFieldLabel: "Post Office  Pincode",
                inputType: TextInputType.number,
                controller: widget.cntlrs.institutionPermanentPinCode,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // only digits allowed
                  LengthLimitingTextInputFormatter(6), // max length 6
                ],
              ),
              SizedBox(height: h * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sectionTitle("Current Address", w),
                  Row(
                    children: [
                      const Text(
                        "Same as Permanent Address",
                        style: TextStyle(fontSize: 10),
                      ),
                      Checkbox(
                        value: isSameAsPermanent,
                        onChanged: (val) {
                          setState(() {
                            isSameAsPermanent = val ?? false;

                            if (isSameAsPermanent) {
                              // Copy permanent to current
                              widget.cntlrs.institutionCurrentAddress1.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress1
                                      .text;
                              widget.cntlrs.institutionCurrentAddress2.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress2
                                      .text;
                              widget.cntlrs.institutionCurrentAddress3.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress3
                                      .text;
                              widget.cntlrs.institutionCurrentCity.text =
                                  widget.cntlrs.institutionPermanentCity.text;
                              widget.cntlrs.institutionCurrentTaluk.text =
                                  widget.cntlrs.institutionPermanentTaluk.text;
                              widget.cntlrs.institutionCurrentDistrict.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentDistrict
                                      .text;
                              widget.cntlrs.institutionCurrentState.text =
                                  widget.cntlrs.institutionPermanentState.text;
                              widget.cntlrs.institutionCurrentCountry.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentCountry
                                      .text;
                              widget.cntlrs.institutionCurrentPinCode.text =
                                  widget
                                      .cntlrs
                                      .institutionPermanentPinCode
                                      .text;
                            } else {
                              // Clear current fields if unchecked
                              widget.cntlrs.institutionCurrentAddress1.clear();
                              widget.cntlrs.institutionCurrentAddress2.clear();
                              widget.cntlrs.institutionCurrentAddress3.clear();
                              widget.cntlrs.institutionCurrentCity.clear();
                              widget.cntlrs.institutionCurrentTaluk.clear();
                              widget.cntlrs.institutionCurrentDistrict.clear();
                              widget.cntlrs.institutionCurrentState.clear();
                              widget.cntlrs.institutionCurrentCountry.clear();
                              widget.cntlrs.institutionCurrentPinCode.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 1.2),
              const SizedBox(height: 12),

              const Divider(thickness: 1.2),
              const SizedBox(height: 12),

              LabelCustomTextField(
                hintText: "Address 1",
                textFieldLabel: "Address 1",
                lines: 2,
                controller: widget.cntlrs.institutionCurrentAddress1,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 2",
                textFieldLabel: "Address 2",
                lines: 2,
                controller: widget.cntlrs.institutionCurrentAddress2,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 3",
                textFieldLabel: "Address 3",
                lines: 2,
                controller: widget.cntlrs.institutionCurrentAddress3,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "City/Town/Village",
                textFieldLabel: "City/Town/Village",
                controller: widget.cntlrs.institutionCurrentCity,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Taluk",
                textFieldLabel: "Taluk",
                controller: widget.cntlrs.institutionCurrentTaluk,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "District",
                textFieldLabel: "District",
                controller: widget.cntlrs.institutionCurrentDistrict,
                textInputAction: TextInputAction.done,
              ),
              LabelCustomTextField(
                hintText: "State",
                textFieldLabel: "State",
                controller: widget.cntlrs.institutionCurrentState,
                textInputAction: TextInputAction.next,
              ),

              LabelCustomTextField(
                hintText: "Country",
                textFieldLabel: "Country",
                controller: widget.cntlrs.institutionCurrentCountry,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Post Office Pincode",
                textFieldLabel: "Post Office  Pincode",
                inputType: TextInputType.number,
                controller: widget.cntlrs.institutionCurrentPinCode,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // only digits allowed
                  LengthLimitingTextInputFormatter(6), // max length 6
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: LabelWithDropDownField(
                  isHintvalue:
                      widget.cntlrs.institutionCommunicationAddress.isEmpty
                          ? false
                          : true,
                  labelText:
                      widget.cntlrs.institutionCommunicationAddress.isEmpty
                          ? "Select Communication Address"
                          : widget.cntlrs.institutionCommunicationAddress,
                  hintText:
                      widget.cntlrs.institutionCommunicationAddress.isEmpty
                          ? "Select Communication Address"
                          : widget.cntlrs.institutionCommunicationAddress,
                  textDropDownLabel: "Communication Address",
                  items: ["Permanant Adress", "Present Address"],

                  onChanged: (value) {
                    widget.cntlrs.institutionCommunicationAddress = value;
                    customPrint(
                      "Selected Communication Address: ${widget.cntlrs.institutionCommunicationAddress}",
                    );
                  },
                ),
              ),

              SizedBox(height: h * 0.03),

              /// Left aligned checkbox
              Row(
                children: [
                  Checkbox(
                    value: isAccepted,
                    onChanged: (val) {
                      setState(() {
                        isAccepted = val ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text("I accept the Terms & Conditions"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: w,
                child: BlocConsumer<UserBloc, UserState>(
                  bloc: userBloc,
                  listener: (context, state) {
                    if (state.institutionCreationError != null &&
                        state.institutionCreationError!.isNotEmpty) {
                      if (state.institutionResponse?.proceedStatus == "Y") {
                        customPrint(
                          "institution creation success =${state.institutionResponse?.proceedMessage}",
                        );

                        showUserCreationDialog(
                          context,
                          state.institutionResponse!,
                        );
                        widget.cntlrs.institutionClear();
                      } else {
                        customPrint(
                          "institution creation  msg=${state.institutionCreationError}",
                        );
                        GlobalWidgets().showSnackBar(
                          context,
                          state.institutionCreationError!,
                        );
                        return;
                      }
                    }
                  },
                  buildWhen:
                      (previous, current) =>
                          previous.isInstitutionCreationLoading !=
                          current.isInstitutionCreationLoading,
                  builder: (context, state) {
                    if (state.isInstitutionCreationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return CustomRaisedButton(
                        buttonText: "Submit",
                        onPressed: () {
                          bool isEmpty(String val) => val.trim().isEmpty;
                          if (!isAccepted) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please accept terms to continue.",
                            );
                            return;
                          }

                          if (isEmpty(
                                widget.cntlrs.institutionPermanentAddress1.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentCity.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentTaluk.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentDistrict.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentState.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentCountry.text,
                              ) ||
                              isEmpty(
                                widget.cntlrs.institutionPermanentPinCode.text,
                              )) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please fill all Permanent Address fields",
                            );
                            return;
                          }

                          if (!isSameAsPermanent &&
                              (isEmpty(
                                    widget
                                        .cntlrs
                                        .institutionCurrentAddress1
                                        .text,
                                  ) ||
                                  isEmpty(
                                    widget.cntlrs.institutionCurrentCity.text,
                                  ) ||
                                  isEmpty(
                                    widget.cntlrs.institutionCurrentTaluk.text,
                                  ) ||
                                  isEmpty(
                                    widget
                                        .cntlrs
                                        .institutionCurrentDistrict
                                        .text,
                                  ) ||
                                  isEmpty(
                                    widget.cntlrs.institutionCurrentState.text,
                                  ) ||
                                  isEmpty(
                                    widget
                                        .cntlrs
                                        .institutionCurrentCountry
                                        .text,
                                  ) ||
                                  isEmpty(
                                    widget
                                        .cntlrs
                                        .institutionCurrentPinCode
                                        .text,
                                  ))) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please fill all Current Address fields",
                            );
                            return;
                          }

                          customPrint("Proprietor Details");
                          customPrint("${widget.cntlrs.proprietorName.text}");
                          customPrint("Proprietor Details");
                          customPrint("Proprietor Details");
                          customPrint("Proprietor Details");
                          userBloc.add(
                            InstitutionUserCreationEvent(
                              institutionUiModal: InstituitionUiReqModel(
                                cmpCode: cmpCode,
                                brCode: widget.cntlrs.selectedBranch,
                                custTypeCode:
                                    widget.cntlrs.selectedCustomerType,
                                accountType: widget.cntlrs.selectedAccType,
                                refID: widget.cntlrs.newUserRefIDCntlr.text,
                                firmName: widget.cntlrs.firmName.text,
                                firmRegNo: widget.cntlrs.firmReg_No.text,
                                firmRegType: '0',
                                firmStartDate:
                                    widget.cntlrs.institutionFirmStartDate.text,
                                firmPlaceInc:
                                    widget.cntlrs.institutionFirmPlace.text,
                                firmPanNo:
                                    widget.cntlrs.institutionFirmPanCard.text,
                                firmPrimaryEmail:
                                    widget.cntlrs.institutionPrimaryEmail.text,
                                firmGstin:
                                    widget.cntlrs.institutionFirmGstin.text,
                                presentAddressXml: InstitutionAddressModal(
                                  "Present",
                                  widget.cntlrs.institutionCurrentAddress1.text,
                                  widget.cntlrs.institutionCurrentAddress2.text,
                                  widget.cntlrs.institutionCurrentAddress3.text,
                                  widget.cntlrs.institutionCurrentCity.text,
                                  widget.cntlrs.institutionCurrentTaluk.text,
                                  widget.cntlrs.institutionCurrentDistrict.text,
                                  widget.cntlrs.institutionCurrentState.text,
                                  widget.cntlrs.institutionCurrentCountry.text,
                                  widget.cntlrs.institutionCurrentPinCode.text,
                                ),
                                permanentAddressXml: InstitutionAddressModal(
                                  "Permanent",
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress1
                                      .text,
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress2
                                      .text,
                                  widget
                                      .cntlrs
                                      .institutionPermanentAddress3
                                      .text,
                                  widget.cntlrs.institutionPermanentCity.text,
                                  widget.cntlrs.institutionPermanentTaluk.text,
                                  widget
                                      .cntlrs
                                      .institutionPermanentDistrict
                                      .text,
                                  widget.cntlrs.institutionPermanentState.text,
                                  widget
                                      .cntlrs
                                      .institutionPermanentCountry
                                      .text,
                                  widget
                                      .cntlrs
                                      .institutionPermanentPinCode
                                      .text,
                                ),
                                communicationAddress:
                                    widget
                                        .cntlrs
                                        .institutionCommunicationAddress,
                                proprietorsXml: widget.proprietors,
                                aadhaarFrontImage:
                                    widget
                                        .cntlrs
                                        .institutionAadhaarFrontImageBase64 ??
                                    "",
                                aadhaarBackImage:
                                    widget
                                        .cntlrs
                                        .institutionAadhaarBackImageBase64 ??
                                    "",
                                panImage:
                                    widget
                                        .cntlrs
                                        .institutionPanCardImageBase64 ??
                                    "",
                                proprietorName:
                                    widget.cntlrs.proprietorName.text,
                                proprietorEducation:
                                    widget.cntlrs.proprietorEducation.text,
                                proprietorDOB: widget.cntlrs.proprietorDob.text,
                                proprietorExperience:
                                    widget.cntlrs.proprietorExperience.text,
                              ),
                            ),
                          );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder:
                          //         (context) => const UserInstitutionCreation(),
                          //   ),
                          // );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
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

  void showUserCreationDialog(
    BuildContext context,
    InstitutionResponseModal responseModel,
  ) {
    if (responseModel.data.isEmpty) {
      // Optional: handle no data case
      return;
    }

    final userData = responseModel.data.first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Created Successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Customer ID : ${userData.custId}')),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    tooltip: 'Copy Customer ID',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: userData.custId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Customer ID copied to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('Account No  : ${userData.accNo}'),
              Text('Share No    : ${userData.shareNo}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
