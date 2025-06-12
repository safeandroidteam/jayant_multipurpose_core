import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';

import '../../../Util/custom_print.dart';
import '../../../Util/custom_textfield.dart';
import '../../Model/institution/proprietor_modal.dart';
import '../../bloc/user/controllers/text_controllers.dart';
import 'institutin_page3.dart';

class InstitutionPage2 extends StatefulWidget {
  const InstitutionPage2({super.key});

  @override
  State<InstitutionPage2> createState() => _InstitutionPage2State();
}

class _InstitutionPage2State extends State<InstitutionPage2> {
  final cntlrs = Textcntlrs();

  @override
  void initState() {
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    /// Proprietor Details Section Builder
    Widget buildProprietorSection(int index) {
      final modal = cntlrs.proprietors[index];
      final controllerSet = cntlrs.proprietorControllers[index];

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
                    "Proprietor Details ${index + 1}",
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
                          cntlrs.proprietors.removeAt(index);
                          cntlrs.proprietorControllers.removeAt(index);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Proprietor Details",
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
                        cntlrs.proprietors.add(ProprietorModal());
                        cntlrs.proprietorControllers.add({
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
                cntlrs.proprietors.length,
                buildProprietorSection,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: w,
                child: CustomRaisedButton(
                  buttonText: "Continue",
                  onPressed: () {
                    bool isValid = true;

                    if (cntlrs.proprietors.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Please add at least one proprietor.",
                      );
                      return;
                    }

                    for (int i = 0; i < cntlrs.proprietors.length; i++) {
                      final controllerSet = cntlrs.proprietorControllers[i];
                      final model = cntlrs.proprietors[i];

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
                              proprietors: cntlrs.proprietors,
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
}
