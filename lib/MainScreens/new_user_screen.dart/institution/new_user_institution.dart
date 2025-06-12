import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/proprietor_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';

/// Institution Page
class UserInstitutionCreation extends StatefulWidget {
  const UserInstitutionCreation({super.key});

  @override
  State<UserInstitutionCreation> createState() =>
      _UserInstitutionCreationState();
}

class _UserInstitutionCreationState extends State<UserInstitutionCreation> {
  final cntlrs = Textcntlrs();
  final captureService = CaptureService();
  List<PlatformFile> uploadedDocs = [];

  List<ProprietorModel> proprietors = [ProprietorModel()];

  Widget buildProprietorSection(int index) {
    final modal = proprietors[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Proprietor Details ${index + 1}",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        LabelCustomTextField(
          hintText: "Name",
          textFieldLabel: "Name",
          onchanged: (val) => modal.name = val,
        ),
        LabelCustomTextField(
          hintText: "DOB",
          textFieldLabel: "DOB",
          onchanged: (val) => modal.dob = val,
        ),
        LabelCustomTextField(
          hintText: "Father Name",
          textFieldLabel: "Father Name",
          onchanged: (val) => modal.fatherName = val,
        ),
        LabelCustomTextField(
          hintText: "Mother Maiden Name",
          textFieldLabel: "Mother Maiden Name",
          onchanged: (val) => modal.motherName = val,
        ),
        LabelCustomTextField(
          hintText: "Mobile No",
          textFieldLabel: "Mobile No",
          onchanged: (val) => modal.mobile = val,
        ),
        LabelCustomTextField(
          hintText: "Email ID",
          textFieldLabel: "Email ID",
          onchanged: (val) => modal.email = val,
        ),
        const SizedBox(height: 16),
      ],
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
          onPressed: () => Navigator.of(context).pop(),
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
              width: w,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.any);
                          if (result != null && result.files.isNotEmpty) {
                            setState(() {
                              uploadedDocs.add(result.files.first);
                            });
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.blueAccent),
                      ),
                      const Text("Upload Document"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (uploadedDocs.isNotEmpty)
                    ...uploadedDocs.map((file) {
                      return Row(
                        children: [
                          const Icon(Icons.insert_drive_file, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(file.name)),
                          IconButton( 
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                uploadedDocs.remove(file);
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
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
            SizedBox(
              width: w,
              child: CustomRaisedButton(
                buttonText: "Continue",
                onPressed: () async {},
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Proprietor Details",
            //       style: GoogleFonts.poppins(
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //         fontSize: w * 0.042,
            //       ),
            //     ),
            //     IconButton(
            //       icon: const Icon(Icons.add_circle),
            //       onPressed: () {
            //         setState(() {
            //           proprietors.add(ProprietorModel());
            //         });
            //       },
            //     ),
            //   ],
            // ),

            // /// Generate sections
            // ...List.generate(
            //   proprietors.length,
            //   (index) => buildProprietorSection(index),
            // ),

            // LabelWithDropDownField(
            //   textDropDownLabel: "Gender",
            //   items: ["MALE", "FEMALE"],
            // ),
            // LabelWithDropDownField(
            //   textDropDownLabel: "Nationality",
            //   items: ["A", "B"],
            // ),
            // LabelCustomTextField(
            //   hintText: "Qualification",
            //   textFieldLabel: "Qualification",
            // ),
            // LabelCustomTextField(
            //   hintText: "Profession",
            //   textFieldLabel: "Profession",
            // ),
            // LabelCustomTextField(
            //   hintText: "PAN CARD No",
            //   textFieldLabel: "PAN CARD No",
            // ),
            // LabelCustomTextField(
            //   hintText: "Aadhar CARD No",
            //   textFieldLabel: "Aadhar CARD No",
            // ),
            // LabelCustomTextField(
            //   lines: 3,
            //   hintText: "Permanent Address",
            //   textFieldLabel: "Permanent Address",
            // ),
            // LabelCustomTextField(
            //   lines: 3,
            //   hintText: "Current/ Communication Address",
            //   textFieldLabel: "Curent/ Communication Address",
            // ),
            // const SizedBox(height: 30),
            // const Text("Nomination"),
            // const SizedBox(height: 20),
            // CheckboxListTile(
            //   value: true,
            //   onChanged: (_) {},
            //   title: const Text("Accept Terms & Conditions"),
            // ),
          ],
        ),
      ),
    );
  }
}
