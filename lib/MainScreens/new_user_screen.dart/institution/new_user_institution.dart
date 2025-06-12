import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/institution/institution_page2.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:permission_handler/permission_handler.dart';

class UserInstitutionCreation extends StatefulWidget {
  const UserInstitutionCreation({super.key, required this.cntlrs});
  final Textcntlrs cntlrs;
  @override
  State<UserInstitutionCreation> createState() =>
      _UserInstitutionCreationState();
}

class _UserInstitutionCreationState extends State<UserInstitutionCreation> {
  final captureService = CaptureService();
  List<PlatformFile> uploadedDocs = [];

  bool containsSpecialCharacters(String input) {
    final pattern = RegExp(r'[!@#<>?":_`~;\[\]\\|=+)(*&^%₹₹]');
    return pattern.hasMatch(input);
  }

  TextInputFormatter blockSpecialCharacters() {
    return FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s&\-,.'@]"));
  }

  void _selectFirmStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.cntlrs.institutionFirmStartDate.text = formattedDate;
    }
  }

  Future<void> pickPanCardImage() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        final bytes = await pickedFile.readAsBytes();

        setState(() {
          widget.cntlrs.institutionPanCardImage = file;
          widget.cntlrs.institutionPanCardImageBase64 = base64Encode(bytes);
        });

        alertPrint(
          "Base64: ${widget.cntlrs.institutionPanCardImageBase64?.substring(0, 30)}...",
        );
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please allow camera access from settings.'),
        ),
      );
    }
  }

  void previewPanCardImage() {
    if (widget.cntlrs.institutionPanCardImage == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Preview PAN Card"),
          content: Image.file(
            widget.cntlrs.institutionPanCardImage!,
            fit: BoxFit.contain,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await pickPanCardImage();
              },
              child: const Text("Re-Capture"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () {
            Navigator.of(context).pop();
            widget.cntlrs.institutionClear();
          },
        ),
        centerTitle: true,
        title: const Text(
          "Institution Creation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Firms Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            const Divider(thickness: 1.2),
            SizedBox(height: h * 0.02),
            LabelCustomTextField(
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(50),
              ],
              controller: widget.cntlrs.firmName,
              hintText: "Firm Name",
              textFieldLabel: "Firm Name",
            ),
            LabelCustomTextField(
              controller: widget.cntlrs.firmReg_No,
              hintText: "Firm Reg No",
              textFieldLabel: "Firm Reg No",
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(50),
              ],
            ),
            LabelCustomTextField(
              controller: widget.cntlrs.institutionPrimaryEmail,
              hintText: "Firm Primary Email",
              textFieldLabel: "Firm Primary Email",
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(50),
              ],
            ),
            LabelCustomTextField(
              hintText: "Mobile No",
              textFieldLabel: "Mobile No",
              inputType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              controller: widget.cntlrs.institutionMobileNo,
            ),

            LabelCustomTextField(
              controller: widget.cntlrs.institutionFirmGstin,
              hintText: "Firm GSTIN",
              textFieldLabel: "Firm GSTIN",
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(15),
              ],
            ),
            LabelCustomTextField(
              hintText: "Date of Establishment",
              textFieldLabel: "Date of Establishment",
              controller: widget.cntlrs.institutionFirmStartDate,
              readOnly: true,
              onTap: () => _selectFirmStartDate(context),
            ),

            LabelCustomTextField(
              controller: widget.cntlrs.institutionFirmPlace,
              hintText: "Firm Place",
              textFieldLabel: "Firm Place",
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(250),
              ],
            ),

            LabelCustomTextField(
              controller: widget.cntlrs.turnOver,
              hintText: "Turn Over",
              textFieldLabel: "Turn Over",
              inputType: TextInputType.number,
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(15),
              ],
            ),
            SizedBox(height: h * 0.02),

            ///Aadhaar , pan, front and back
            Text(
              "Document Attached",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            const Divider(thickness: 1.2),
            SizedBox(height: h * 0.01),

            LabelCustomTextField(
              controller: widget.cntlrs.institutionFirmPanCard,
              hintText: "Firm’s PAN Number",
              textFieldLabel: "Firm’s PAN Number",
              inputFormatters: [
                blockSpecialCharacters(),
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(height: h * 0.01),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'PAN Card Photo',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: w * 0.035,
                  ),
                ),

                ///Image capture
                GestureDetector(
                  onTap: () {
                    if (widget.cntlrs.institutionPanCardImage != null) {
                      previewPanCardImage();
                    } else {
                      pickPanCardImage();
                    }
                  },
                  child: DottedBorder(
                    options: RectDottedBorderOptions(
                      borderPadding: EdgeInsets.all(10),
                      dashPattern: [6, 4],
                      strokeWidth: 1.5,
                      color: Colors.grey,
                    ),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      child:
                          widget.cntlrs.institutionPanCardImage != null
                              ? Image.file(
                                widget.cntlrs.institutionPanCardImage!,
                                fit: BoxFit.contain,
                              )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Tap to upload Firm PAN Card",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.03),
            SizedBox(
              width: w,
              child: CustomRaisedButton(
                buttonText: "Continue",
                onPressed: () async {
                  bool isEmpty(String val) => val.trim().isEmpty;

                  if (isEmpty(widget.cntlrs.firmName.text) ||
                      isEmpty(widget.cntlrs.firmReg_No.text) ||
                      isEmpty(widget.cntlrs.institutionPrimaryEmail.text) ||
                      isEmpty(widget.cntlrs.institutionMobileNo.text) ||
                      isEmpty(widget.cntlrs.institutionFirmGstin.text) ||
                      isEmpty(widget.cntlrs.institutionFirmStartDate.text) ||
                      isEmpty(widget.cntlrs.institutionFirmPlace.text) ||
                      isEmpty(widget.cntlrs.institutionFirmPanCard.text) ||
                      widget.cntlrs.institutionPanCardImage == null ||
                      widget.cntlrs.institutionPanCardImage == "" ||
                      isEmpty(widget.cntlrs.turnOver.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please fill all fields",
                    );
                    return;
                  }

                  if (isEmpty(widget.cntlrs.firmName.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Firm Name",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.firmReg_No.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Firm Registration Number",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionPrimaryEmail.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Primary Email",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionMobileNo.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Mobile Number",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionFirmGstin.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Firm GSTIN",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionFirmStartDate.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please select Firm Start Date",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionFirmPlace.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Place of Firm",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.institutionFirmPanCard.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter PAN Card Number",
                    );
                    return;
                  }
                  if (widget.cntlrs.institutionPanCardImage == null) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please upload PAN Card Image",
                    );
                    return;
                  }
                  if (isEmpty(widget.cntlrs.turnOver.text)) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please enter Annual Turnover",
                    );
                    return;
                  }
                  successPrint('''  
------ Form Submission ------  
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
''');

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => InstitutionPage2(cntlrs: widget.cntlrs),
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
}
