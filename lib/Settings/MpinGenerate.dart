import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/MainScreens/Login.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SaveMpinModel.dart';

class MpinGenerate extends StatefulWidget {
  const MpinGenerate({super.key});

  @override
  _MpinGenerateState createState() => _MpinGenerateState();
}

class _MpinGenerateState extends State<MpinGenerate> {
  TextEditingController mpinCtrl = TextEditingController();
  TextEditingController reMpinCtrl = TextEditingController();
  TextEditingController setMPinCtrl1 = TextEditingController();
  TextEditingController setMPinCtrl2 = TextEditingController();
  TextEditingController setMPinCtrl3 = TextEditingController();
  TextEditingController setMPinCtrl4 = TextEditingController();
  TextEditingController allSetMpinCtrl = TextEditingController();

  TextEditingController confirmMPinCtrl1 = TextEditingController();
  TextEditingController confirmMPinCtrl2 = TextEditingController();
  TextEditingController confirmMPinCtrl3 = TextEditingController();
  TextEditingController confirmMPinCtrl4 = TextEditingController();
  TextEditingController allConfirmMpinCtrl = TextEditingController();

  bool mPin = false;
  bool reMpin = false;
  bool currentMpin = false;
  List<SaveMpin> mPinResponse = [];
  String? str_Ststus;
  int? strStatusCode;
  SharedPreferences? pref;
  String? MPin;

  mergeMPinCtrlValues() {
    allSetMpinCtrl.clear();
    allConfirmMpinCtrl.clear();

    allSetMpinCtrl.text =
        setMPinCtrl1.text +
        setMPinCtrl2.text +
        setMPinCtrl3.text +
        setMPinCtrl4.text;
    debugPrint("Set MPIN : ${allSetMpinCtrl.text}");

    allConfirmMpinCtrl.text =
        confirmMPinCtrl1.text +
        confirmMPinCtrl2.text +
        confirmMPinCtrl3.text +
        confirmMPinCtrl4.text;
    debugPrint("Confirm MPIN : ${allConfirmMpinCtrl.text}");
  }

  @override
  void initState() {
    setState(() {
      SharedPreferences pref = StaticValues.sharedPreferences!;
      MPin = pref.getString(StaticValues.Mpin);
      debugPrint("MPIN : $MPin");
      /*usernameCtrl.text = "nira";
      passCtrl.text = "1234";*/
      //      usernameCtrl.text = "vidya";
      //      passCtrl.text = "123456";
      //      usernameCtrl.text = "9895564690";
      //      passCtrl.text = "123456";
    });

    super.initState();
  }

  Future<List<SaveMpin>?> saveMpin() async {
    mergeMPinCtrlValues();
    pref = StaticValues.sharedPreferences;
    var response = await RestAPI().post(
      APis.saveMpin,
      params: {
        "CustID": pref!.getString(StaticValues.custID),
        // "MPIN": mpinCtrl.text,
        "MPIN": allConfirmMpinCtrl.text,
      },
    );
    setState(() {
      mPinResponse = saveMpinFromJson(json.encode(response));
      str_Ststus = mPinResponse[0].status;
      strStatusCode = mPinResponse[0].statuscode;
      print("LJT$str_Ststus");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(str_Ststus!)));

      if (strStatusCode == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("MPin Changed. Please login again")),
        );
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Set MPin", style: TextStyle(color: Colors.white)),
              InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Set MPIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: height * 0.025),
              SizedBox(
                width: width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SingleDigitTextField(
                      controller: setMPinCtrl1,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: setMPinCtrl2,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: setMPinCtrl3,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: setMPinCtrl4,
                      autoFocus: false,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              Text(
                "Confirm MPIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: height * 0.025),
              SizedBox(
                width: width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SingleDigitTextField(
                      controller: confirmMPinCtrl1,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: confirmMPinCtrl2,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: confirmMPinCtrl3,
                      autoFocus: false,
                      obscureText: true,
                    ),
                    SingleDigitTextField(
                      controller: confirmMPinCtrl4,
                      autoFocus: false,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    mergeMPinCtrlValues();
                    if (allSetMpinCtrl.text.trim().length < 4 ||
                        allConfirmMpinCtrl.text.trim().length < 4) {
                      // isMPinEmpty = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Enter 4 digit MPIN on both fields."),
                        ),
                      );
                    } else if (allSetMpinCtrl.text.trim() !=
                        allConfirmMpinCtrl.text.trim()) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("MPIN Mismatch")));
                    } else {
                      if (allSetMpinCtrl.text == allConfirmMpinCtrl.text) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                          StaticValues.Mpin,
                          // allConfirmMpinCtrl.text,
                          "Y",
                        );

                        // await pref.setString(StaticValues.Mpin, "1111");
                        saveMpin();
                      }
                    }

                    /*  if(MPin == null){
                    if(mpinCtrl.text == reMpinCtrl.text){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString(StaticValues.Mpin, mpinCtrl.text);
      
                      // await pref.setString(StaticValues.Mpin, "1111");
                      saveMpin();
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mpin Miss Match")));
                    }
                  }
                  else{
                    if(MPin == currentMpinCtrl.text){
                      if(mpinCtrl.text == reMpinCtrl.text){
      
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString(StaticValues.Mpin, mpinCtrl.text);
      
                        // await pref.setString(StaticValues.Mpin, "1111");
                        saveMpin();
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mpin Miss Match")));
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current MPin Missmatch")));
                    }
                  }*/
                  },
                  child: Text(
                    MPin == null ? "Save" : "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.getString(StaticValues.Mpin) == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("No MPin Set")));
                Navigator.of(context).pop();
              } else {
                prefs.remove(StaticValues.Mpin);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("MPin Deleted")));

                // Navigator.of(
                //   context,
                // ).pushNamedAndRemoveUntil("/LoginPage", (_) => false);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
              // prefs.setString(StaticValues.Mpin, "");
            },
            child: Text("YES"),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text("NO"),
          ),
        ],
      ),
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete MPin"),
      content: Text("Are you sure want to delete MPin."),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
