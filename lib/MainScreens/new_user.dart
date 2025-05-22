import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/user_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';

import '../Util/custom_drop_down.dart';

class NewUser extends StatelessWidget {
  const NewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final userCreationList = <UserCreationModal>[
      UserCreationModal("Indvidual", 0),
      UserCreationModal("Institute", 1),
    ];
    final userBloc = UserBloc.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New User", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Text(
              "Basic Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            SizedBox(height: h * 0.03),
            LabelWithDropDownField(
              textDropDownLabel: "Branch",
              items: ["A", "B"],
            ),

            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      current is UserTypeSelectionState ||
                      current is UserTypeSelectionStateLoading,
              builder: (context, state) {
                return Column(
                  children: [
                    LabelWithDropDownField<UserCreationModal>(
                      textDropDownLabel: "Customer Type",
                      items: userCreationList,
                      itemAsString: (p0) => p0.name,
                      onChanged: (value) {
                        userBloc.add(UserCreationType(value.id));
                      },
                    ),

                    if (state is UserTypeSelectionStateLoading)
                      Center(child: CircularProgressIndicator()),
                    if (state is UserTypeSelectionState)
                      state.id == 1
                          ? UserInstitutionCreation()
                          : UserIndvidualCreation(),
                  ],
                );
              },
            ),

            CustomRaisedButton(buttonText: "Submit", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class UserIndvidualCreation extends StatelessWidget {
  const UserIndvidualCreation({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithDropDownField(textDropDownLabel: "Title", items: ["A", "B"]),

        LabelCustomTextField(
          hintText: "First Name",
          textFieldLabel: "Customer First Name",
        ),
        LabelCustomTextField(
          hintText: "Middle Name",
          textFieldLabel: "Customer Middle Name",
        ),
        LabelCustomTextField(
          hintText: "Last Name",
          textFieldLabel: "Customer Last Name",
        ),
        LabelCustomTextField(
          hintText: "Father Name",
          textFieldLabel: "Father Name",
        ),
        LabelCustomTextField(
          hintText: "Mother Name",
          textFieldLabel: "Mother Name",
        ),
        LabelCustomTextField(
          hintText: "Spouse Name",
          textFieldLabel: "Spouse Name",
        ),
        LabelCustomTextField(hintText: "Guardian", textFieldLabel: "Guardian"),
        LabelCustomTextField(hintText: "DOB", textFieldLabel: "DOB"),
        LabelWithDropDownField(
          textDropDownLabel: "Gender",
          items: ["Male", "Female"],
        ),
        LabelCustomTextField(
          hintText: "Mobile Number",
          textFieldLabel: "Primary Mobile Number",
        ),
        LabelCustomTextField(
          hintText: "Mobile Number",
          textFieldLabel: "Secondar Mobile Number",
        ),
        LabelCustomTextField(
          hintText: "Primary Email",
          textFieldLabel: "Primary Email",
        ),
        LabelCustomTextField(
          hintText: "Aadhar Number",
          textFieldLabel: "Aadhar Number",
        ),
        LabelCustomTextField(
          hintText: "PAN Number",
          textFieldLabel: "PAN Number",
        ),
        LabelCustomTextField(
          hintText: "Qualification",
          textFieldLabel: "Qualification",
        ),
        //need to fetch live location
        LabelCustomTextField(
          hintText: "CKYC Number",
          textFieldLabel: "CKYC Number",
        ),
        SizedBox(height: h * 0.03),
        Text(
          "Permanent Address",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.02),
        LabelCustomTextField(
          hintText: "House No & Name",
          textFieldLabel: "House No & Name",
        ),
        LabelCustomTextField(
          hintText: "Address 1",
          textFieldLabel: "Address 1",
        ),
        LabelCustomTextField(
          hintText: "Address 2",
          textFieldLabel: "Address 2",
        ),
        LabelCustomTextField(
          hintText: "City/Town/Village",
          textFieldLabel: "City/Town/Village",
        ),
        LabelCustomTextField(
          hintText: "Post Office/ Pincode",
          textFieldLabel: "Post Office/ Pincode",
        ),
        LabelCustomTextField(hintText: "Country", textFieldLabel: "Country"),
        LabelCustomTextField(hintText: "State", textFieldLabel: "State"),
        LabelCustomTextField(hintText: "District", textFieldLabel: "District"),
        LabelWithDropDownField(
          textDropDownLabel: "Communication Address",
          items: ["Yes", "No"],
        ),
        SizedBox(height: h * 0.01),
        Text(
          "Present Address",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.01),
        LabelCustomTextField(
          hintText: "House No & Name",
          textFieldLabel: "House No & Name",
        ),
        LabelCustomTextField(
          hintText: "Address 1",
          textFieldLabel: "Address 1",
        ),
        LabelCustomTextField(
          hintText: "Address 2",
          textFieldLabel: "Address 2",
        ),
        LabelCustomTextField(
          hintText: "City/Town/Village",
          textFieldLabel: "City/Town/Village",
        ),
        LabelCustomTextField(
          hintText: "Post Office/ Pincode",
          textFieldLabel: "Post Office/ Pincode",
        ),
        LabelCustomTextField(hintText: "Country", textFieldLabel: "Country"),
        LabelCustomTextField(hintText: "State", textFieldLabel: "State"),
        LabelCustomTextField(hintText: "District", textFieldLabel: "District"),
        LabelWithDropDownField(
          textDropDownLabel: "Communication Address",
          items: ["Yes", "No"],
        ),
        SizedBox(height: h * 0.05),
        Text(
          "Document Details",
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
            ImageWidget(text: "Customer Image"),
            ImageWidget(text: "Customer Signature"),
          ],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(text: "Id Proof"),
            ImageWidget(text: "Customer Bank details"),
          ],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(text: "Selfie"),
            ImageWidget(text: "Video Recording"),
          ],
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

class UserInstitutionCreation extends StatelessWidget {
  const UserInstitutionCreation({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
        lines: 3,),
        Text("Document Attached"),
        SizedBox(height: h*0.01),
        Container(
          height: h * 0.07,
          width: w,
          decoration: BoxDecoration(border: Border.all(
            color: Colors.grey,width: 0.3
          ), color: Colors.white,
          borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){},
               icon: Icon(Icons.add,color: Colors.blueAccent,))
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
        Text(
          "Proprietor Details",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.02),
        LabelCustomTextField(hintText: "Name", textFieldLabel: "Name"),
        LabelCustomTextField(hintText: "DOB", textFieldLabel: "DOB"),
        LabelCustomTextField(
          hintText: "Father Name",
          textFieldLabel: "Father Name",
        ),
        LabelCustomTextField(
          hintText: "Mother Maiden Name",
          textFieldLabel: "Mother Maiden Name",
        ),
        LabelCustomTextField(
          hintText: "Mobile No",
          textFieldLabel: "Mobile No",
        ),
        LabelCustomTextField(hintText: "Email ID", textFieldLabel: "Email ID"),
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
            ImageWidget(text: "Selfie"),
            ImageWidget(text: "Blinking Eyes"),
          ],
        ),

        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ImageWidget(text: "Signature")],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(text: "Selfie"),
            ImageWidget(text: "Video Recording"),
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
