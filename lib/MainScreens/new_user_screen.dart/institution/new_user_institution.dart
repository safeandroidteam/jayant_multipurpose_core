import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/proprietor_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';

///Institution Page
class UserInstitutionCreation extends StatefulWidget {
  const UserInstitutionCreation({super.key});

  @override
  State<UserInstitutionCreation> createState() =>
      _UserInstitutionCreationState();
}

class _UserInstitutionCreationState extends State<UserInstitutionCreation> {
  final cntlrs = Textcntlrs();
  final captureService = CaptureService();
  List<int> proprietorIndexes = [1];
  List<ProprietorModel> proprietors = [ProprietorModel()];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final userBloc = UserBloc.get(context);

    Widget buildProprietorSection(int index) {
      final modal = proprietors[index];

      alertPrint("Index added $index");
      return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Proprietor Details $index",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              LabelCustomTextField(
                hintText: "Name",
                textFieldLabel: "Name",
                onchanged: (val) {
                  modal.name = val;
                },
              ),
              LabelCustomTextField(
                hintText: "DOB",
                textFieldLabel: "DOB",
                onchanged: (val) {
                  modal.dob = val;
                },
              ),
              LabelCustomTextField(
                hintText: "Father Name",
                textFieldLabel: "Father Name",
                onchanged: (val) {
                  modal.fatherName = val;
                },
              ),
              LabelCustomTextField(
                hintText: "Mother Maiden Name",
                textFieldLabel: "Mother Maiden Name",
                onchanged: (val) {
                  modal.motherName = val;
                },
              ),
              LabelCustomTextField(
                hintText: "Mobile No",
                textFieldLabel: "Mobile No",
                onchanged: (val) {
                  modal.mobile = val;
                },
              ),
              LabelCustomTextField(
                hintText: "Email ID",
                textFieldLabel: "Email ID",
                onchanged: (val) {
                  modal.email = val;
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: h * 0.03),
        Text(
          "Firms Details",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.02),
        LabelCustomTextField(
          hintText: "Firm Name",
          textFieldLabel: "Firm Name",
        ),
        LabelCustomTextField(
          hintText: "Firm Reg No",
          textFieldLabel: "Firm Reg No",
        ),
        LabelCustomTextField(
          hintText: "Firm Registered Address",
          textFieldLabel: "Firm Registered Address",
          lines: 3,
        ),
        Text("Document Attached"),
        SizedBox(height: h * 0.01),
        Container(
          height: h * 0.07,
          width: w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.3),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.blueAccent),
              ),
            ],
          ),
        ),
        LabelCustomTextField(
          hintText: "Product Details",
          textFieldLabel: "Product Details",
        ),
        LabelCustomTextField(
          hintText: "Turn Over",
          textFieldLabel: "Turn Over",
        ),
        SizedBox(height: h * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Proprietor Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  proprietorIndexes.add(proprietorIndexes.length + 1);
                });
              },
            ),
          ],
        ),

        /// All Proprietor Sections
        ...proprietorIndexes.map((index) => buildProprietorSection(index)),

        LabelWithDropDownField(
          textDropDownLabel: "Gender",
          items: ["MALE", "FEMALE"],
        ),
        LabelWithDropDownField(
          textDropDownLabel: "Nationality",
          items: ["A", "B"],
        ),
        LabelCustomTextField(
          hintText: "Qualification",
          textFieldLabel: "Qualification",
        ),
        LabelCustomTextField(
          hintText: "Profession",
          textFieldLabel: "Profession",
        ),
        LabelCustomTextField(
          hintText: "PAN CARD No",
          textFieldLabel: "PAN CARD No",
        ),
        LabelCustomTextField(
          hintText: "Aadhar CARD No",
          textFieldLabel: "Aadhar CARD No",
        ),
        LabelCustomTextField(
          lines: 3,
          hintText: "Permanent Address",
          textFieldLabel: "Permanent Address",
        ),
        LabelCustomTextField(
          lines: 3,
          hintText: "Current/ Communication Address",
          textFieldLabel: "Curent/ Communication Address",
        ),
        //fetch the geo location
        SizedBox(height: h * 0.03),
        Text(
          "Nomination",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Selfie",
              imageFile: cntlrs.institutionSelfieFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    cntlrs.institutionSelfieFile = file;
                    cntlrs.institutionSelfieBase64 = base64;

                    cntlrs.institutionSelfieFile = File(file.path);
                    cntlrs.institutionSelfieBase64 = base64;
                  });

                  successPrint(
                    "Individual Capture Image ${cntlrs.individualCustomerImageFileBase64}",
                  );
                }
              },
            ),
            ImageWidget(
              text: "Blinking Eyes",
              isVideo: true,
              imageFile: cntlrs.institutionBlinkEyeVideoFile,
              onTap: () async {
                final video = await captureService.captureVideo();
                if (video != null) {
                  final bytes = await video.readAsBytes();
                  final base64 = base64Encode(bytes);
                  setState(() {
                    cntlrs.institutionBlinkEyeVideoFile = File(video.path);
                    cntlrs.institutionBlinkEyeVideoBase64 = base64;
                  });
                  successPrint("Blinking Video $base64");
                  successPrint(
                    "Blinking Video ${cntlrs.institutionBlinkEyeVideoBase64}",
                  );
                } else {
                  warningPrint("Video recording cancelled or failed.");
                }
              },
            ),
          ],
        ),

        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Signature",
              imageFile: cntlrs.institutionSignatureFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    cntlrs.institutionSignatureFile = file;
                    cntlrs.institutionSignatureBase64 = base64;
                    cntlrs.institutionSignatureFile = File(file.path);
                  });
                  cntlrs.institutionSignatureBase64 = base64;
                  successPrint(
                    "Individual Selfie Image ${cntlrs.institutionSignatureBase64}",
                  );
                }
              },
            ),
          ],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Selfie",
              imageFile: cntlrs.institutionSelfieFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    cntlrs.institutionSelfieFile = file;
                    cntlrs.institutionSelfieBase64 = base64;
                    cntlrs.institutionSelfieFile = File(file.path);
                  });
                  cntlrs.institutionSelfieBase64 = base64;
                  successPrint(
                    "Individual Selfie Image ${cntlrs.institutionSelfieBase64}",
                  );
                }
              },
            ),
            ImageWidget(
              text: "Video Recording",
              isVideo: true,
              imageFile: cntlrs.institutionTalkingVideoFile,
              onTap: () async {
                final video = await captureService.captureVideo();
                if (video != null) {
                  final bytes = await video.readAsBytes();
                  final base64 = base64Encode(bytes);
                  setState(() {
                    cntlrs.institutionTalkingVideoFile = File(video.path);
                    cntlrs.institutionTalkingVideoBase64 = base64;
                  });
                  successPrint("Blinking Video $base64");
                  successPrint(
                    "Blinking Video ${cntlrs.institutionTalkingVideoBase64}",
                  );
                } else {
                  warningPrint("Video recording cancelled or failed.");
                }
              },
            ),
          ],
        ),

        SizedBox(height: h * 0.05),
        LabelCustomTextField(
          hintText: "Aadhar Card OTP",
          textFieldLabel: "Aadhar Card OTP Verification",
        ),
        SizedBox(height: h * 0.03),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
