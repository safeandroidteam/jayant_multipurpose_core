import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';

class UserIndividualCreation3 extends StatefulWidget {
  const UserIndividualCreation3({super.key});
  @override
  State<UserIndividualCreation3> createState() =>
      _UserIndividualCreation3State();
}

class _UserIndividualCreation3State extends State<UserIndividualCreation3> {
  final cntlrs = Textcntlrs();

  final capture = CaptureService();
  bool isTermsAccepted = false;
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
                      imageFile: cntlrs.individualCustomerImageFile,
                      onTap: () async {
                        final file = await CaptureService().captureImage();
                        if (file != null) {
                          final base64 = await ImageUtils.compressXFileToBase64(
                            file,
                          );
                          setState(() {
                            cntlrs.individualCustomerImageFile = file;
                            cntlrs.individualCustomerImageFileBase64 = base64;
                            cntlrs.individualCustomerImageFile = File(
                              file.path,
                            );
                            cntlrs.individualCustomerImageFileBase64 = base64;
                          });
                          successPrint(
                            "Individual Capture Image ${cntlrs.individualCustomerImageFileBase64}",
                          );
                        }
                      },
                    ),

                    ///Signature Image
                    ImageWidget(
                      text: "Signature",
                      imageFile: cntlrs.individualCustomerSignatureFile,
                      onTap: () async {
                        final file = await CaptureService().captureImage();
                        if (file != null) {
                          final base64 = await ImageUtils.compressXFileToBase64(
                            file,
                          );
                          setState(() {
                            cntlrs.individualCustomerSignatureFile = file;
                            cntlrs.individualCustomerSignatureFileBase64 =
                                base64;
                            // Convert File to XFile here
                            cntlrs.individualCustomerSignatureFile = File(
                              file.path,
                            );
                            cntlrs.individualCustomerSignatureFileBase64 =
                                base64;
                          });
                          successPrint(
                            "Individual Customer signature ${cntlrs.individualCustomerSignatureFileBase64}",
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04),
                  child: ImageWidget(
                    text: "Customer Selfie",
                    imageFile: cntlrs.individualSelfieFile,
                    onTap: () async {
                      final file = await CaptureService().captureImage();
                      if (file != null) {
                        final base64 = await ImageUtils.compressXFileToBase64(
                          file,
                        );
                        setState(() {
                          cntlrs.individualSelfieFile = file;
                          cntlrs.individualSelfieFileBase64 = base64;
                          cntlrs.individualSelfieFile = File(file.path);
                        });
                        cntlrs.individualSelfieFileBase64 = base64;
                        successPrint(
                          "Individual Selfie Image ${cntlrs.individualSelfieFileBase64}",
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.05),

            _sectionTitle("Aadhaar Card Details", w, w * 0.04, FontWeight.w500),
            Divider(),
            SizedBox(height: h * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///Id Proof
                ImageWidget(
                  text: 'Aadhaar Card – Front',
                  imageFile: cntlrs.individualAadhaarFrontProofFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        cntlrs.individualAadhaarFrontProofFile = file;
                        cntlrs.individualAadhaarFrontProofFileBase64 = base64;

                        cntlrs.individualAadhaarFrontProofFile = File(
                          file.path,
                        );
                        cntlrs.individualAadhaarFrontProofFileBase64 = base64;
                      });
                      successPrint(
                        "Aadhar front Image ${cntlrs.individualAadhaarFrontProofFileBase64}",
                      );
                    }
                  },
                ),

                ///Id Proof
                ImageWidget(
                  text: 'Aadhaar Card – Back',
                  imageFile: cntlrs.individualAadhaarBackProofFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        cntlrs.individualAadhaarBackProofFile = file;
                        cntlrs.individualAadhaarBackProofFileBase64 = base64;

                        cntlrs.individualAadhaarBackProofFile = File(file.path);
                        cntlrs.individualAadhaarBackProofFileBase64 = base64;
                      });
                      successPrint(
                        "Aadhar back  ${cntlrs.individualAadhaarBackProofFileBase64}",
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
                imageFile: cntlrs.individualPanCardProofFile,
                onTap: () async {
                  final file = await CaptureService().captureImage();
                  if (file != null) {
                    final base64 = await ImageUtils.compressXFileToBase64(file);
                    setState(() {
                      cntlrs.individualPanCardProofFile = file;
                      cntlrs.individualPanCardProofFileBase64 = base64;

                      cntlrs.individualPanCardProofFile = File(file.path);
                      cntlrs.individualPanCardProofFileBase64 = base64;
                    });
                    successPrint(
                      "Pan Card  ${cntlrs.individualPanCardProofFileBase64}",
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
              child: CustomRaisedButton(
                buttonText: "Continue",
                onPressed: () {
                  // Check if all base64 fields are empty
                  if ((cntlrs.individualCustomerImageFileBase64?.isEmpty ??
                          true) &&
                      (cntlrs.individualCustomerSignatureFileBase64?.isEmpty ??
                          true) &&
                      (cntlrs.individualSelfieFileBase64?.isEmpty ?? true) &&
                      (cntlrs.individualAadhaarFrontProofFileBase64?.isEmpty ??
                          true) &&
                      (cntlrs.individualAadhaarBackProofFileBase64?.isEmpty ??
                          true) &&
                      (cntlrs.individualPanCardProofFileBase64?.isEmpty ??
                          true)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please upload or capture required documents.",
                    );
                    return;
                  }

                  // Check each individually and show specific message
                  if (cntlrs.individualCustomerImageFileBase64?.isEmpty ??
                      true) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please capture Customer Image.",
                    );
                    return;
                  }

                  if (cntlrs.individualCustomerSignatureFileBase64?.isEmpty ??
                      true) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please capture Signature.",
                    );
                    return;
                  }

                  if (cntlrs.individualSelfieFileBase64?.isEmpty ?? true) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please capture Customer Selfie.",
                    );
                    return;
                  }

                  if (cntlrs.individualAadhaarFrontProofFileBase64?.isEmpty ??
                      true) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please capture Aadhaar Card Front.",
                    );
                    return;
                  }

                  if (cntlrs.individualAadhaarBackProofFileBase64?.isEmpty ??
                      true) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please capture Aadhaar Card Back.",
                    );
                    return;
                  }

                  if (cntlrs.individualPanCardProofFileBase64?.isEmpty ??
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

                  // ✅ All validations passed — proceed
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              UserIndividualCreation3(), // or next screen
                    ),
                  );
                },
              ),
            ),
          ],
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
}



 ///Video Recording
                // ImageWidget(
                //   text: "Video Recording",
                //   imageFile: cntlrs.individualVideoRecordingFile,
                //   isVideo: true,
                //   onTap: () async {
                //     final video = await CaptureService().captureVideo();
                //     if (video != null) {
                //       final bytes = await video.readAsBytes();
                //       final base64 = base64Encode(bytes);
                //       setState(() {
                //         cntlrs.individualVideoRecordingFile = File(video.path);
                //         cntlrs.individualVideoRecordingFileBase64 = base64;
                //       });
                //       successPrint("Blinking Video $base64");
                //       successPrint(
                //         "Blinking Video ${cntlrs.individualVideoRecordingFileBase64}",
                //       );
                //     } else {
                //       warningPrint("Video recording cancelled or failed.");
                //     }
                //   },
                // ),

                 // ///Customer Bank Details
                // ImageWidget(
                //   text: "Customer Bank details",
                //   imageFile: cntlrs.individualBankDetailsFile,
                //   onTap: () async {
                //     final file = await CaptureService().captureImage();
                //     if (file != null) {
                //       final base64 = await ImageUtils.compressXFileToBase64(
                //         file,
                //       );
                //       setState(() {
                //         cntlrs.individualBankDetailsFile = file;
                //         cntlrs.individualBankDetailsFileBase64 = base64;
                //         cntlrs.individualBankDetailsFile = File(file.path);
                //       });
                //       cntlrs.individualBankDetailsFileBase64 = base64;
                //       successPrint(
                //         "Individual Bank Image ${cntlrs.individualBankDetailsFileBase64}",
                //       );
                //     }
                //   },
                // ),