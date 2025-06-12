import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';

import '../../../Util/capture_image_video.dart';
import '../../../Util/custom_print.dart';
import '../../../Util/custom_textfield.dart';
import '../../../Util/image_picker_widget.dart';
import '../../Model/institution/proprietor_modal.dart';
import '../../bloc/user/controllers/text_controllers.dart';
import 'institution_page3.dart';

class InstitutionPage2 extends StatefulWidget {
  const InstitutionPage2({super.key, required this.cntlrs});
  final Textcntlrs cntlrs;
  @override
  State<InstitutionPage2> createState() => _InstitutionPage2State();
}

class _InstitutionPage2State extends State<InstitutionPage2> {
  void _selectProprietorDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.cntlrs.proprietorDob.text = formattedDate;
    }
  }

  @override
  void initState() {
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    /// Proprietor Details Section Builder
    Widget buildProprietorSection(int index) {
      final modal = widget.cntlrs.proprietors[index];
      final controllerSet = widget.cntlrs.proprietorControllers[index];

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ownership Details ${index + 1}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  if (index != 0)
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cntlrs.proprietors.removeAt(index);
                          widget.cntlrs.proprietorControllers.removeAt(index);
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),
              LabelCustomTextField(
                hintText: "Name",
                textFieldLabel: "Name",
                controller: controllerSet['name'],
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                onchanged: (val) => modal.name = val,
              ),
              LabelCustomTextField(
                hintText: "Address",
                textFieldLabel: "Address",
                controller: controllerSet['address'],
                inputFormatters: [LengthLimitingTextInputFormatter(250)],

                onchanged: (val) => modal.address = val,
              ),
              LabelCustomTextField(
                hintText: "Pan Card No",
                textFieldLabel: "Pan Card No",
                controller: controllerSet['panCardNo'],
                onchanged: (val) => modal.panCardNo = val,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Proprietor Details",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: w * 0.045,
                ),
              ),
              const Divider(thickness: 1.2),
              SizedBox(height: h * 0.02),
              LabelCustomTextField(
                hintText: "Name",
                textFieldLabel: "Name",
                controller: widget.cntlrs.proprietorName,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
              ),
              LabelCustomTextField(
                hintText: "Education",
                textFieldLabel: "Education",
                controller: widget.cntlrs.proprietorEducation,
                inputFormatters: [LengthLimitingTextInputFormatter(250)],
              ),
              LabelCustomTextField(
                hintText: "DOB",
                textFieldLabel: "DOB",
                controller: widget.cntlrs.proprietorDob,
                readOnly: true,
                onTap: () => _selectProprietorDOB(context),
              ),
              LabelCustomTextField(
                hintText: "Experience",
                textFieldLabel: "Experience",
                controller: widget.cntlrs.proprietorExperience,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
              ),
              SizedBox(height: h * 0.03),

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
                    imageFile: widget.cntlrs.institutionAadhaarFrontImage,
                    onTap: () async {
                      final file = await CaptureService().captureImage();
                      if (file != null) {
                        final base64 = await ImageUtils.compressXFileToBase64(
                          file,
                        );
                        setState(() {
                          widget.cntlrs.institutionAadhaarFrontImage = file;
                          widget.cntlrs.institutionAadhaarFrontImageBase64 =
                              base64;

                          widget.cntlrs.institutionAadhaarFrontImage = File(
                            file.path,
                          );
                          widget.cntlrs.institutionAadhaarFrontImageBase64 =
                              base64;
                        });
                        successPrint(
                          "Aadhar front Image ${widget.cntlrs.institutionAadhaarFrontImageBase64}",
                        );
                      }
                    },
                  ),

                  ///Id Proof
                  ImageWidget(
                    text: 'Aadhaar Card – Back',
                    imageFile: widget.cntlrs.institutionAadhaarBackImage,
                    onTap: () async {
                      final file = await CaptureService().captureImage();
                      if (file != null) {
                        final base64 = await ImageUtils.compressXFileToBase64(
                          file,
                        );
                        setState(() {
                          widget.cntlrs.institutionAadhaarBackImage = file;
                          widget.cntlrs.institutionAadhaarBackImageBase64 =
                              base64;

                          widget.cntlrs.institutionAadhaarBackImage = File(
                            file.path,
                          );
                          widget.cntlrs.institutionAadhaarBackImageBase64 =
                              base64;
                        });
                        successPrint(
                          "Aadhar back  ${widget.cntlrs.institutionAadhaarBackImageBase64}",
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: h * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ownership Details",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: w * 0.045,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        widget.cntlrs.proprietors.add(ProprietorModal());
                        widget.cntlrs.proprietorControllers.add({
                          'name': TextEditingController(),
                          'address': TextEditingController(),
                          'panCardNo': TextEditingController(),
                        });

                        GlobalWidgets().showSnackBar(
                          context,
                          "Proprietor Added.",
                        );
                      });
                    },
                  ),
                ],
              ),
              const Divider(thickness: 1.2),
              SizedBox(height: h * 0.02),
              ...List.generate(
                widget.cntlrs.proprietors.length,
                buildProprietorSection,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: w,
                child: CustomRaisedButton(
                  buttonText: "Continue",
                  onPressed: () {
                    bool isValid = true;

                    if (widget.cntlrs.proprietors.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Please add at least one proprietor.",
                      );
                      return;
                    }

                    for (int i = 0; i < widget.cntlrs.proprietors.length; i++) {
                      final controllerSet =
                          widget.cntlrs.proprietorControllers[i];
                      final model = widget.cntlrs.proprietors[i];

                      String name = controllerSet['name']?.text.trim() ?? '';
                      String address =
                          controllerSet['address']?.text.trim() ?? '';
                      String panCardNo =
                          controllerSet['panCardNo']?.text.trim() ?? '';

                      if (name.isEmpty ||
                          address.isEmpty ||
                          panCardNo.isEmpty) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Please fill all fields for Proprietor ${i + 1}.",
                        );
                        isValid = false;
                        break;
                      }

                      model.name = name;
                      model.address = address;
                      model.panCardNo = panCardNo;

                      successPrint("✅ Saved Proprietor ${i + 1}");
                      controllerSet.forEach((key, controller) {
                        successPrint("  $key: ${controller.text}");
                      });
                    }

                    if (!isValid) return;

                    successPrint(
                      "✅ All proprietor fields are valid. Moving to next page...",
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => InstitutionPage3(
                              proprietors: widget.cntlrs.proprietors,
                              cntlrs: widget.cntlrs,
                            ),
                      ),
                    );
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
