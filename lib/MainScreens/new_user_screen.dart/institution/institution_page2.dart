import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:xml/xml.dart' as xml;

import '../../../Util/custom_print.dart';
import '../../../Util/custom_textfield.dart';
import '../../Model/user_modal/proprietor_modal.dart';
import '../../bloc/user/controllers/text_controllers.dart';
import 'institutin_page3.dart';

class InstitutionPage2 extends StatefulWidget {
  const InstitutionPage2({super.key});

  @override
  State<InstitutionPage2> createState() => _InstitutionPage2State();
}

final contrls = Textcntlrs();

class _InstitutionPage2State extends State<InstitutionPage2> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    /// Proprietor Details Section Builder
    Widget buildProprietorSection(int index) {
      final modal = contrls.proprietors[index];
      final controllerSet = contrls.proprietorControllers[index];

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
                          contrls.proprietors.removeAt(index);
                          contrls.proprietorControllers.removeAt(index);
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
                        contrls.proprietors.add(ProprietorModal());
                        contrls.proprietorControllers.add({
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
                contrls.proprietors.length,
                buildProprietorSection,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: w,
                child: CustomRaisedButton(
                  buttonText: "Continue",
                  onPressed: () {
                    bool isValid = true;

                    if (contrls.proprietors.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Please add at least one proprietor.",
                      );
                      return;
                    }

                    for (int i = 0; i < contrls.proprietors.length; i++) {
                      final controllerSet = contrls.proprietorControllers[i];
                      final model = contrls.proprietors[i];

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
                      successPrint("------ Proprietor ${i + 1} ------");
                      controllerSet.forEach((key, controller) {
                        successPrint("$key: ${controller.text}");
                      });
                      successPrint("------------------------------");
                    }

                    if (!isValid) return;

                    final builder = xml.XmlBuilder();
                    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
                    builder.element(
                      'Proprietors',
                      nest: () {
                        for (var prop in contrls.proprietors) {
                          builder.element(
                            'Proprietor',
                            nest: () {
                              builder.element('Name', nest: prop.name);
                              builder.element('Address', nest: prop.address);
                              builder.element(
                                'PanCardNo',
                                nest: prop.panCardNo,
                              );
                            },
                          );
                        }
                      },
                    );

                    final xmlPayload = builder.buildDocument().toXmlString(
                      pretty: true,
                    );
                    successPrint("Generated XML Payload:\n$xmlPayload");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstitutionPage3(),
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
