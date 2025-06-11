import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/institution/address_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/institution/institution_request_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Util/GlobalWidgets.dart';
import '../../../Util/StaticValue.dart';
import '../../../Util/custom_drop_down.dart';
import '../../../Util/custom_print.dart';
import '../../../Util/custom_textfield.dart';
import '../../Model/institution/proprietor_modal.dart';
import '../../bloc/user/controllers/text_controllers.dart';

class InstitutionPage3 extends StatefulWidget {
  final List<ProprietorModal> proprietors;
  const InstitutionPage3({super.key, required this.proprietors});

  @override
  State<InstitutionPage3> createState() => _InstitutionPage3State();
}

class _InstitutionPage3State extends State<InstitutionPage3> {
  String cmpCode = "";
  bool isAccepted = false;
  final cntlrs = Textcntlrs();
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);

    SharedPreferences pref = StaticValues.sharedPreferences!;
    cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
    alertPrint("CmpCode $cmpCode");

    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 8),
    );
    successPrint('''
                          
                          BR Code - ${cntlrs.selectedBranch}
                          Customer Type - ${cntlrs.selectedCustomerType}
                          Account Type - ${cntlrs.selectedAccType}
                          Reference ID - ${cntlrs.newUserRefIDCntlr.text}

                          
                      ------FIRM DETAILS------
                    Firm Name: ${cntlrs.firmName.text}  
                  Firm Reg No: ${cntlrs.firmReg_No.text}  
                  Firm Primary Email: ${cntlrs.institutionPrimaryEmail.text} 
                  Mobile No: ${cntlrs.institutionMobileNo.text}   
                  Firm GSTIN: ${cntlrs.institutionFirmGstin.text}  
                  Firm Establishment Date: ${cntlrs.institutionFirmStartDate.text}  
                  Firm Place: ${cntlrs.institutionFirmPlace.text}  
                  Turn Over: ${cntlrs.turnOver.text}  
                  Firm PAN Card Number: ${cntlrs.institutionFirmPanCard.text}  
                  Uploaded PAN Card Image: ${cntlrs.institutionPanCardImage != null ? 'Yes' : 'No'}  
                  Uploaded Base 64: ${cntlrs.institutionPanCardImageBase64}    
                  ----------------------------  
                     
                  "✅ Saved Proprietor ${widget.proprietors}
                      
                  --------- Permanent Address ---------
                  Address 1: ${cntlrs.institutionPermanentAddress1.text}
                  Address 2: ${cntlrs.institutionPermanentAddress2.text}
                  Address 3: ${cntlrs.institutionPermanentAddress3.text}
                  City/Town/Village: ${cntlrs.institutionPermanentCity.text}
                  Taluk: ${cntlrs.institutionPermanentTaluk.text}
                  District: ${cntlrs.institutionPermanentDistrict.text}
                  State: ${cntlrs.institutionPermanentState.text}
                  Country: ${cntlrs.institutionPermanentCountry.text}
                  Pincode: ${cntlrs.institutionPermanentPinCode.text}
                  
                  --------- Current Address ---------
                  Address 1: ${cntlrs.institutionCurrentAddress1.text}
                  Address 2: ${cntlrs.institutionCurrentAddress2.text}
                  Address 3: ${cntlrs.institutionCurrentAddress3.text}
                  City/Town/Village: ${cntlrs.institutionCurrentCity.text}
                  Taluk: ${cntlrs.institutionCurrentTaluk.text}
                  District: ${cntlrs.institutionCurrentDistrict.text}
                  State: ${cntlrs.institutionCurrentState.text}
                  Country: ${cntlrs.institutionCurrentCountry.text}
                  PinCode: ${cntlrs.institutionCurrentPinCode.text}
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
                controller: cntlrs.institutionPermanentAddress1,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 2",
                textFieldLabel: "Address 2",
                lines: 2,
                controller: cntlrs.institutionPermanentAddress2,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 3",
                textFieldLabel: "Address 3",
                lines: 2,
                controller: cntlrs.institutionPermanentAddress3,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "City/Town/Village",
                textFieldLabel: "City/Town/Village",
                controller: cntlrs.institutionPermanentCity,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Taluk",
                textFieldLabel: "Taluk",
                controller: cntlrs.institutionPermanentTaluk,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "District",
                textFieldLabel: "District",
                controller: cntlrs.institutionPermanentDistrict,
                textInputAction: TextInputAction.done,
              ),
              LabelCustomTextField(
                hintText: "State",
                textFieldLabel: "State",
                controller: cntlrs.institutionPermanentState,
                textInputAction: TextInputAction.next,
              ),

              LabelCustomTextField(
                hintText: "Country",
                textFieldLabel: "Country",
                controller: cntlrs.institutionPermanentCountry,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Post Office Pincode",
                textFieldLabel: "Post Office  Pincode",
                inputType: TextInputType.number,
                controller: cntlrs.institutionPermanentPinCode,
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
                              cntlrs.institutionCurrentAddress1.text =
                                  cntlrs.institutionPermanentAddress1.text;
                              cntlrs.institutionCurrentAddress2.text =
                                  cntlrs.institutionPermanentAddress2.text;
                              cntlrs.institutionCurrentAddress3.text =
                                  cntlrs.institutionPermanentAddress3.text;
                              cntlrs.institutionCurrentCity.text =
                                  cntlrs.institutionPermanentCity.text;
                              cntlrs.institutionCurrentTaluk.text =
                                  cntlrs.institutionPermanentTaluk.text;
                              cntlrs.institutionCurrentDistrict.text =
                                  cntlrs.institutionPermanentDistrict.text;
                              cntlrs.institutionCurrentState.text =
                                  cntlrs.institutionPermanentState.text;
                              cntlrs.institutionCurrentCountry.text =
                                  cntlrs.institutionPermanentCountry.text;
                              cntlrs.institutionCurrentPinCode.text =
                                  cntlrs.institutionPermanentPinCode.text;
                            } else {
                              // Clear current fields if unchecked
                              cntlrs.institutionCurrentAddress1.clear();
                              cntlrs.institutionCurrentAddress2.clear();
                              cntlrs.institutionCurrentAddress3.clear();
                              cntlrs.institutionCurrentCity.clear();
                              cntlrs.institutionCurrentTaluk.clear();
                              cntlrs.institutionCurrentDistrict.clear();
                              cntlrs.institutionCurrentState.clear();
                              cntlrs.institutionCurrentCountry.clear();
                              cntlrs.institutionCurrentPinCode.clear();
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
                controller: cntlrs.institutionCurrentAddress1,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 2",
                textFieldLabel: "Address 2",
                lines: 2,
                controller: cntlrs.institutionCurrentAddress2,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Address 3",
                textFieldLabel: "Address 3",
                lines: 2,
                controller: cntlrs.institutionCurrentAddress3,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "City/Town/Village",
                textFieldLabel: "City/Town/Village",
                controller: cntlrs.institutionCurrentCity,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Taluk",
                textFieldLabel: "Taluk",
                controller: cntlrs.institutionCurrentTaluk,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "District",
                textFieldLabel: "District",
                controller: cntlrs.institutionCurrentDistrict,
                textInputAction: TextInputAction.done,
              ),
              LabelCustomTextField(
                hintText: "State",
                textFieldLabel: "State",
                controller: cntlrs.institutionCurrentState,
                textInputAction: TextInputAction.next,
              ),

              LabelCustomTextField(
                hintText: "Country",
                textFieldLabel: "Country",
                controller: cntlrs.institutionCurrentCountry,
                textInputAction: TextInputAction.next,
              ),
              LabelCustomTextField(
                hintText: "Post Office Pincode",
                textFieldLabel: "Post Office  Pincode",
                inputType: TextInputType.number,
                controller: cntlrs.institutionCurrentPinCode,
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
                      cntlrs.communicationAddress.isEmpty ? false : true,
                  labelText:
                      cntlrs.communicationAddress.isEmpty
                          ? "Select Communication Address"
                          : cntlrs.communicationAddress,
                  hintText:
                      cntlrs.communicationAddress.isEmpty
                          ? "Select Communication Address"
                          : cntlrs.communicationAddress,
                  textDropDownLabel: "Communication Address",
                  items: ["Permanant Adress", "Present Address"],

                  onChanged: (value) {
                    cntlrs.communicationAddress = value;
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
                        state.institutionCreationError!.isEmpty) {
                      errorPrint(
                        "Institution Creation Error ${state.institutionCreationError}",
                      );
                      GlobalWidgets().showSnackBar(
                        context,
                        state.institutionCreationError!,
                      );
                      return;
                    }
                    if (state.institutionResponse?.proceedMessage == "Y") {
                      successPrint(
                        "Institution Created Successfully ${state.institutionResponse?.proceedMessage}",
                      );
                      cntlrs.institutionDispose();
                      GlobalWidgets().showSnackBar(
                        context,
                        "User created successfully",
                      );
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
                        buttonText: "Continue",
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
                                cntlrs.institutionPermanentAddress1.text,
                              ) ||
                              isEmpty(cntlrs.institutionPermanentCity.text) ||
                              isEmpty(cntlrs.institutionPermanentTaluk.text) ||
                              isEmpty(
                                cntlrs.institutionPermanentDistrict.text,
                              ) ||
                              isEmpty(cntlrs.institutionPermanentState.text) ||
                              isEmpty(
                                cntlrs.institutionPermanentCountry.text,
                              ) ||
                              isEmpty(
                                cntlrs.institutionPermanentPinCode.text,
                              )) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please fill all Permanent Address fields",
                            );
                            return;
                          }

                          if (!isSameAsPermanent &&
                              (isEmpty(
                                    cntlrs.institutionCurrentAddress1.text,
                                  ) ||
                                  isEmpty(cntlrs.institutionCurrentCity.text) ||
                                  isEmpty(
                                    cntlrs.institutionCurrentTaluk.text,
                                  ) ||
                                  isEmpty(
                                    cntlrs.institutionCurrentDistrict.text,
                                  ) ||
                                  isEmpty(
                                    cntlrs.institutionCurrentState.text,
                                  ) ||
                                  isEmpty(
                                    cntlrs.institutionCurrentCountry.text,
                                  ) ||
                                  isEmpty(
                                    cntlrs.institutionCurrentPinCode.text,
                                  ))) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please fill all Current Address fields",
                            );
                            return;
                          }

                          userBloc.add(
                            InstitutionUserCreationEvent(
                              institutionUiModal: InstitutionUiModal(
                                cmpCode,
                                cntlrs.selectedBranch,
                                cntlrs.selectedCustomerType,
                                cntlrs.selectedAccType,
                                cntlrs.newUserRefIDCntlr.text,
                                cntlrs.firmName.text,
                                cntlrs.firmReg_No.text,
                                '0',
                                cntlrs.institutionFirmStartDate.text,
                                cntlrs.institutionFirmPlace.text,
                                cntlrs.institutionFirmPanCard.text,
                                cntlrs.institutionPrimaryEmail.text,
                                cntlrs.institutionFirmGstin.text,
                                InstitutionAddressModal(
                                  "Present",
                                  cntlrs.institutionCurrentAddress1.text,
                                  cntlrs.institutionCurrentAddress2.text,
                                  cntlrs.institutionCurrentAddress3.text,
                                  cntlrs.institutionCurrentCity.text,
                                  cntlrs.institutionCurrentTaluk.text,
                                  cntlrs.institutionCurrentDistrict.text,
                                  cntlrs.institutionCurrentState.text,
                                  cntlrs.institutionCurrentCountry.text,
                                  cntlrs.institutionCurrentPinCode.text,
                                ),
                                InstitutionAddressModal(
                                  "Permanent",
                                  cntlrs.institutionPermanentAddress1.text,
                                  cntlrs.institutionPermanentAddress2.text,
                                  cntlrs.institutionPermanentAddress3.text,
                                  cntlrs.institutionPermanentCity.text,
                                  cntlrs.institutionPermanentTaluk.text,
                                  cntlrs.institutionPermanentDistrict.text,
                                  cntlrs.institutionPermanentState.text,
                                  cntlrs.institutionPermanentCountry.text,
                                  cntlrs.institutionPermanentPinCode.text,
                                ),
                                cntlrs.institutionCommunicationAddress,
                                cntlrs.proprietors,
                                cntlrs.institutionAadhaarFrontImageBase64 ?? "",
                                cntlrs.institutionAadhaarBackImageBase64 ?? "",
                                cntlrs.institutionPanCardImageBase64 ?? "",
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
                          successPrint('''
                          
                          BR Code - ${cntlrs.selectedBranch}
                          Customer Type - ${cntlrs.selectedCustomerType}
                          Account Type - ${cntlrs.selectedAccType}
                          Reference ID - ${cntlrs.newUserRefIDCntlr.text}

                          
                      ------FIRM DETAILS------
                    Firm Name: ${cntlrs.firmName.text}  
                  Firm Reg No: ${cntlrs.firmReg_No.text}  
                  Firm Primary Email: ${cntlrs.institutionPrimaryEmail.text} 
                  Mobile No: ${cntlrs.institutionMobileNo.text}   
                  Firm GSTIN: ${cntlrs.institutionFirmGstin.text}  
                  Firm Establishment Date: ${cntlrs.institutionFirmStartDate.text}  
                  Firm Place: ${cntlrs.institutionFirmPlace.text}  
                  Turn Over: ${cntlrs.turnOver.text}  
                  Firm PAN Card Number: ${cntlrs.institutionFirmPanCard.text}  
                  Uploaded PAN Card Image: ${cntlrs.institutionPanCardImage != null ? 'Yes' : 'No'}  
                  Uploaded Base 64: ${cntlrs.institutionPanCardImageBase64}    
                  ----------------------------  
                     
                  "✅ Saved Proprietor ${widget.proprietors}
                      
                  --------- Permanent Address ---------
                  Address 1: ${cntlrs.institutionPermanentAddress1.text}
                  Address 2: ${cntlrs.institutionPermanentAddress2.text}
                  Address 3: ${cntlrs.institutionPermanentAddress3.text}
                  City/Town/Village: ${cntlrs.institutionPermanentCity.text}
                  Taluk: ${cntlrs.institutionPermanentTaluk.text}
                  District: ${cntlrs.institutionPermanentDistrict.text}
                  State: ${cntlrs.institutionPermanentState.text}
                  Country: ${cntlrs.institutionPermanentCountry.text}
                  Pincode: ${cntlrs.institutionPermanentPinCode.text}
                  
                  --------- Current Address ---------
                  Address 1: ${cntlrs.institutionCurrentAddress1.text}
                  Address 2: ${cntlrs.institutionCurrentAddress2.text}
                  Address 3: ${cntlrs.institutionCurrentAddress3.text}
                  City/Town/Village: ${cntlrs.institutionCurrentCity.text}
                  Taluk: ${cntlrs.institutionCurrentTaluk.text}
                  District: ${cntlrs.institutionCurrentDistrict.text}
                  State: ${cntlrs.institutionCurrentState.text}
                  Country: ${cntlrs.institutionCurrentCountry.text}
                  PinCode: ${cntlrs.institutionCurrentPinCode.text}
                  ''');
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
}
