import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Login.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/individual_user_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/prsent_address_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/individual_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIndividualCreation3 extends StatefulWidget {
  const UserIndividualCreation3({super.key, required this.cntlrs});
  final Textcntlrs cntlrs;
  @override
  State<UserIndividualCreation3> createState() =>
      _UserIndividualCreation3State();
}

class _UserIndividualCreation3State extends State<UserIndividualCreation3> {
  late UserBloc userBloc;
  String cmpCode = "";
  final capture = CaptureService();
  bool isTermsAccepted = false;
  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);
    SharedPreferences pref = StaticValues.sharedPreferences!;
    cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(w * 0.05),
            children: [
              SizedBox(height: h * 0.02),
              _sectionTitle("Document Details", w, null, null),
              SizedBox(height: h * 0.02),
              Text(
                "*Please upload or capture the following documents",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),

              SizedBox(height: h * 0.03),

              _sectionTitle(
                "Customer Identity Documents",
                w,
                w * 0.04,
                FontWeight.w500,
              ),
              Divider(),
              SizedBox(height: h * 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///Customer Image
                      ImageWidget(
                        text: "Customer Image",
                        imageFile: widget.cntlrs.individualCustomerImageFile,
                        onTap: () async {
                          final file = await CaptureService().captureImage();
                          if (file != null) {
                            final base64 =
                                await ImageUtils.compressXFileToBase64(file);
                            setState(() {
                              widget.cntlrs.individualCustomerImageFile = file;
                              widget.cntlrs.individualCustomerImageFileBase64 =
                                  base64;
                              widget.cntlrs.individualCustomerImageFile = File(
                                file.path,
                              );
                              widget.cntlrs.individualCustomerImageFileBase64 =
                                  base64;
                            });
                            successPrint(
                              "Individual Capture Image ${widget.cntlrs.individualCustomerImageFileBase64}",
                            );
                          }
                        },
                      ),

                      ///Signature Image
                      ImageWidget(
                        text: "Signature",
                        imageFile:
                            widget.cntlrs.individualCustomerSignatureFile,
                        onTap: () async {
                          final file = await CaptureService().captureImage();
                          if (file != null) {
                            final base64 =
                                await ImageUtils.compressXFileToBase64(file);
                            setState(() {
                              widget.cntlrs.individualCustomerSignatureFile =
                                  file;
                              widget
                                      .cntlrs
                                      .individualCustomerSignatureFileBase64 =
                                  base64;
                              // Convert File to XFile here
                              widget.cntlrs.individualCustomerSignatureFile =
                                  File(file.path);
                              widget
                                      .cntlrs
                                      .individualCustomerSignatureFileBase64 =
                                  base64;
                            });
                            successPrint(
                              "Individual Customer signature ${widget.cntlrs.individualCustomerSignatureFileBase64}",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  // SizedBox(height: h * 0.02),
                  // Padding(
                  //   padding: EdgeInsets.only(left: w * 0.04),
                  //   child: ImageWidget(
                  //     text: "Customer Selfie",
                  //     imageFile: widget.cntlrs.individualSelfieFile,
                  //     onTap: () async {
                  //       final file = await CaptureService().captureImage();
                  //       if (file != null) {
                  //         final base64 = await ImageUtils.compressXFileToBase64(
                  //           file,
                  //         );
                  //         setState(() {
                  //           widget.cntlrs.individualSelfieFile = file;
                  //           widget.cntlrs.individualSelfieFileBase64 = base64;
                  //           widget.cntlrs.individualSelfieFile = File(file.path);
                  //         });
                  //         widget.cntlrs.individualSelfieFileBase64 = base64;
                  //         successPrint(
                  //           "Individual Selfie Image ${widget.cntlrs.individualSelfieFileBase64}",
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: h * 0.05),

              _sectionTitle(
                "Aadhaar Card Details",
                w,
                w * 0.04,
                FontWeight.w500,
              ),
              Divider(),
              SizedBox(height: h * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Id Proof
                  ImageWidget(
                    text: 'Aadhaar Card – Front',
                    imageFile: widget.cntlrs.individualAadhaarFrontProofFile,
                    onTap: () async {
                      final file = await CaptureService().captureImage();
                      if (file != null) {
                        final base64 = await ImageUtils.compressXFileToBase64(
                          file,
                        );
                        setState(() {
                          widget.cntlrs.individualAadhaarFrontProofFile = file;
                          widget.cntlrs.individualAadhaarFrontProofFileBase64 =
                              base64;

                          widget.cntlrs.individualAadhaarFrontProofFile = File(
                            file.path,
                          );
                          widget.cntlrs.individualAadhaarFrontProofFileBase64 =
                              base64;
                        });
                        successPrint(
                          "Aadhar front Image ${widget.cntlrs.individualAadhaarFrontProofFileBase64}",
                        );
                      }
                    },
                  ),

                  ///Id Proof
                  ImageWidget(
                    text: 'Aadhaar Card – Back',
                    imageFile: widget.cntlrs.individualAadhaarBackProofFile,
                    onTap: () async {
                      final file = await CaptureService().captureImage();
                      if (file != null) {
                        final base64 = await ImageUtils.compressXFileToBase64(
                          file,
                        );
                        setState(() {
                          widget.cntlrs.individualAadhaarBackProofFile = file;
                          widget.cntlrs.individualAadhaarBackProofFileBase64 =
                              base64;

                          widget.cntlrs.individualAadhaarBackProofFile = File(
                            file.path,
                          );
                          widget.cntlrs.individualAadhaarBackProofFileBase64 =
                              base64;
                        });
                        successPrint(
                          "Aadhar back  ${widget.cntlrs.individualAadhaarBackProofFileBase64}",
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: h * 0.05),

              _sectionTitle("Pan Card Details", w, w * 0.04, FontWeight.w500),
              Divider(),
              SizedBox(height: h * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: ImageWidget(
                  text: 'Pan Card – Front',
                  imageFile: widget.cntlrs.individualPanCardProofFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        widget.cntlrs.individualPanCardProofFile = file;
                        widget.cntlrs.individualPanCardProofFileBase64 = base64;

                        widget.cntlrs.individualPanCardProofFile = File(
                          file.path,
                        );
                        widget.cntlrs.individualPanCardProofFileBase64 = base64;
                      });
                      successPrint(
                        "Pan Card  ${widget.cntlrs.individualPanCardProofFileBase64}",
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: h * 0.03),
              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value!;
                      });
                      successPrint("is Temrs Accepted = $isTermsAccepted");
                    },
                  ),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.03),
              SizedBox(
                width: w,
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state.individualUserCreationError != null &&
                        state.individualUserCreationError!.isNotEmpty) {
                      if (state.individualResponse?.proceedStatus == "Y") {
                        customPrint(
                          "individual creation success =${state.individualResponse?.proceedMessage}",
                        );

                        showUserCreationDialog(
                          context,
                          state.individualResponse!,
                        );
                        widget.cntlrs.individualDispose();
                      } else {
                        customPrint(
                          "individual creation  msg=${state.individualUserCreationError}",
                        );
                        GlobalWidgets().showSnackBar(
                          context,
                          state.individualUserCreationError!,
                        );
                        return;
                      }
                    }
                  },

                  buildWhen:
                      (previous, current) =>
                          previous.isIndividualUserLoading !=
                          current.isIndividualUserLoading,

                  builder: (context, state) {
                    if (state.isIndividualUserLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return CustomRaisedButton(
                        buttonText: "Create Account",
                        onPressed: () {
                          // Check if all base64 fields are empty
                          if ((widget
                                      .cntlrs
                                      .individualCustomerImageFileBase64
                                      ?.isEmpty ??
                                  true) &&
                              (widget
                                      .cntlrs
                                      .individualCustomerSignatureFileBase64
                                      ?.isEmpty ??
                                  true) &&
                              (widget
                                      .cntlrs
                                      .individualAadhaarFrontProofFileBase64
                                      ?.isEmpty ??
                                  true) &&
                              (widget
                                      .cntlrs
                                      .individualAadhaarBackProofFileBase64
                                      ?.isEmpty ??
                                  true) &&
                              (widget
                                      .cntlrs
                                      .individualPanCardProofFileBase64
                                      ?.isEmpty ??
                                  true)) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please upload or capture required documents.",
                            );
                            return;
                          }

                          // Check each individually and show specific message
                          if (widget
                                  .cntlrs
                                  .individualCustomerImageFileBase64
                                  ?.isEmpty ??
                              true) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please capture Customer Image.",
                            );
                            return;
                          }

                          if (widget
                                  .cntlrs
                                  .individualCustomerSignatureFileBase64
                                  ?.isEmpty ??
                              true) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please capture Signature.",
                            );
                            return;
                          }

                          if (widget
                                  .cntlrs
                                  .individualAadhaarFrontProofFileBase64
                                  ?.isEmpty ??
                              true) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please capture Aadhaar Card Front.",
                            );
                            return;
                          }

                          if (widget
                                  .cntlrs
                                  .individualAadhaarBackProofFileBase64
                                  ?.isEmpty ??
                              true) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please capture Aadhaar Card Back.",
                            );
                            return;
                          }

                          if (widget
                                  .cntlrs
                                  .individualPanCardProofFileBase64
                                  ?.isEmpty ??
                              true) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please capture PAN Card.",
                            );
                            return;
                          }

                          if (!isTermsAccepted) {
                            GlobalWidgets().showSnackBar(
                              context,
                              "Please accept Terms & Conditions.",
                            );
                            return;
                          }

                          userBloc.add(
                            IndividualUserCreationEvent(
                              individualUserCreationUiModal:
                                  IndividualUserCreationUIModal(
                                    cmpCode,
                                    widget.cntlrs.selectedBranch,
                                    widget.cntlrs.selectedCustomerType,
                                    widget.cntlrs.selectedAccType,
                                    widget.cntlrs.newUserRefIDCntlr.text,
                                    widget.cntlrs.selectedIndividualTitle,
                                    widget.cntlrs.firstNameCntlr.text,
                                    widget.cntlrs.middleNameCntlr.text,
                                    widget.cntlrs.lastNameCntlr.text,
                                    widget.cntlrs.fatherNameCntlr.text,
                                    widget.cntlrs.motherNameCntlr.text,
                                    widget.cntlrs.spouseNameCntlr.text,
                                    widget.cntlrs.slectedCustomerDob.text,
                                    widget.cntlrs.selectedIndividualGender,
                                    widget
                                        .cntlrs
                                        .customerPrimaryMobileNumberCntlr
                                        .text,
                                    widget
                                        .cntlrs
                                        .customerPrimaryEmailCntlr
                                        .text,
                                    widget
                                        .cntlrs
                                        .customerAadharNumberCntlr
                                        .text,

                                    widget.cntlrs.customerPanNumberCntlr.text,
                                    widget
                                        .cntlrs
                                        .customerQualificationCntlr
                                        .text,
                                    widget.cntlrs.customerCkycNumberCntlr.text,
                                    AddressModal(
                                      addressType: "Permanent",
                                      houseNoName:
                                          widget
                                              .cntlrs
                                              .permanentAddressHouseNoNameCntlr
                                              .text,
                                      address1:
                                          widget
                                              .cntlrs
                                              .permanentAddress1Cntrl
                                              .text,
                                      address2:
                                          widget
                                              .cntlrs
                                              .permanentAddress2Cntrl
                                              .text,
                                      cityTownVillage:
                                          widget
                                              .cntlrs
                                              .permanent_City_town_village_cntlr
                                              .text,

                                      pinCode:
                                          widget
                                              .cntlrs
                                              .permanent_post_office_pincode_cntlr
                                              .text,
                                      country:
                                          widget
                                              .cntlrs
                                              .permanent_country_cntlr
                                              .text,

                                      state:
                                          widget
                                              .cntlrs
                                              .permanent_states_cntlr
                                              .text,
                                      district:
                                          widget
                                              .cntlrs
                                              .permanent_district_cntlr
                                              .text,
                                    ),

                                    AddressModal(
                                      addressType: "Present",
                                      houseNoName:
                                          widget
                                              .cntlrs
                                              .presentAddressHouseNoNameCntlr
                                              .text,
                                      address1:
                                          widget
                                              .cntlrs
                                              .presentAddress1Cntrl
                                              .text,
                                      address2:
                                          widget
                                              .cntlrs
                                              .presentAddress2Cntrl
                                              .text,
                                      cityTownVillage:
                                          widget
                                              .cntlrs
                                              .present_City_town_village_cntlr
                                              .text,

                                      pinCode:
                                          widget
                                              .cntlrs
                                              .present_post_office_pincode_cntlr
                                              .text,
                                      country:
                                          widget
                                              .cntlrs
                                              .present_country_cntlr
                                              .text,

                                      state:
                                          widget
                                              .cntlrs
                                              .present_states_cntlr
                                              .text,
                                      district:
                                          widget
                                              .cntlrs
                                              .present_district_cntlr
                                              .text,
                                    ),
                                    widget.cntlrs.communicationAddress.contains(
                                          "Permanant",
                                        )
                                        ? "Permanant"
                                        : "Present",
                                    widget
                                        .cntlrs
                                        .individualCustomerImageFileBase64!,
                                    widget
                                        .cntlrs
                                        .individualCustomerSignatureFileBase64!,

                                    widget
                                        .cntlrs
                                        .individualAadhaarFrontProofFileBase64!,
                                    widget
                                        .cntlrs
                                        .individualAadhaarBackProofFileBase64!,
                                    widget
                                        .cntlrs
                                        .individualPanCardProofFileBase64!,
                                  ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    double w,
    double? fontsize,
    FontWeight? fontWeight,
  ) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight ?? FontWeight.bold,
        color: Colors.black,
        fontSize: fontsize ?? w * 0.042,
      ),
    );
  }

  void showUserCreationDialog(
    BuildContext context,
    IndividualUserResponseModel responseModel,
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



 ///Video Recording
                // ImageWidget(
                //   text: "Video Recording",
                //   imageFile: widget.cntlrs.individualVideoRecordingFile,
                //   isVideo: true,
                //   onTap: () async {
                //     final video = await CaptureService().captureVideo();
                //     if (video != null) {
                //       final bytes = await video.readAsBytes();
                //       final base64 = base64Encode(bytes);
                //       setState(() {
                //         widget.cntlrs.individualVideoRecordingFile = File(video.path);
                //         widget.cntlrs.individualVideoRecordingFileBase64 = base64;
                //       });
                //       successPrint("Blinking Video $base64");
                //       successPrint(
                //         "Blinking Video ${widget.cntlrs.individualVideoRecordingFileBase64}",
                //       );
                //     } else {
                //       warningPrint("Video recording cancelled or failed.");
                //     }
                //   },
                // ),

                 // ///Customer Bank Details
                // ImageWidget(
                //   text: "Customer Bank details",
                //   imageFile: widget.cntlrs.individualBankDetailsFile,
                //   onTap: () async {
                //     final file = await CaptureService().captureImage();
                //     if (file != null) {
                //       final base64 = await ImageUtils.compressXFileToBase64(
                //         file,
                //       );
                //       setState(() {
                //         widget.cntlrs.individualBankDetailsFile = file;
                //         widget.cntlrs.individualBankDetailsFileBase64 = base64;
                //         widget.cntlrs.individualBankDetailsFile = File(file.path);
                //       });
                //       widget.cntlrs.individualBankDetailsFileBase64 = base64;
                //       successPrint(
                //         "Individual Bank Image ${widget.cntlrs.individualBankDetailsFileBase64}",
                //       );
                //     }
                //   },
                // ),