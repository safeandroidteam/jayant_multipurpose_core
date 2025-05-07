import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SaveMpinModel.dart';

class MpinGenerate extends StatefulWidget {
  const MpinGenerate({Key? key}) : super(key: key);

  @override
  _MpinGenerateState createState() => _MpinGenerateState();
}

class _MpinGenerateState extends State<MpinGenerate> {
  TextEditingController mpinCtrl = TextEditingController();
  TextEditingController reMpinCtrl = TextEditingController();
  bool mPin = false;
  bool reMpin = false;
  bool currentMpin = false;
  List<SaveMpin> mPinResponse = [];
  String? str_Ststus;
  int? strStatusCode;
  SharedPreferences? pref;
  String? MPin;

  @override
  void initState() {
    setState(() {
      SharedPreferences pref = StaticValues.sharedPreferences!;
      MPin = pref.getString(StaticValues.Mpin);
      print("MPIN : $MPin");
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
    pref = StaticValues.sharedPreferences;
    var response = await RestAPI().post(APis.saveMpin, params: {
      "CustID": pref!.getString(StaticValues.custID),
      "MPIN": mpinCtrl.text
    });
    setState(() {
      //  mPinResponse = saveMpinFromJson(json.encode(response));
      mPinResponse = saveMpinFromJson(json.encode(response));
      str_Ststus = mPinResponse[0].status;
      strStatusCode = mPinResponse[0].statuscode;
      print("LJT$str_Ststus");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(str_Ststus!)));

      if (strStatusCode == 1) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/LoginPage", (_) => false);
      }
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Set MPin",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditTextBordered(
              controller: mpinCtrl,
              hint: "MPin",
              keyboardType: TextInputType.number,
              errorText: mPin ? "Password length should be 4" : null,
              //   obscureText: true,
              //  showObscureIcon: true,
              onChange: (value) {
                setState(() {
                  mPin = value.trim().length < 4;
                });
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            EditTextBordered(
              controller: reMpinCtrl,
              hint: "Re-enter MPin",
              keyboardType: TextInputType.number,
              errorText: reMpin ? "Password length should be 4" : null,
              //   obscureText: true,
              //   showObscureIcon: true,
              onChange: (value) {
                setState(() {
                  reMpin = value.trim().length < 4;
                });
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              height: 40.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  if (mpinCtrl.text == reMpinCtrl.text) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(StaticValues.Mpin, mpinCtrl.text);

                    // await pref.setString(StaticValues.Mpin, "1111");
                    saveMpin();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Mpin Miss Match")));
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
            )
          ],
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("No MPin Set")));
                } else {
                  prefs.remove(StaticValues.Mpin);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("MPin Deleted")));

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/LoginPage", (_) => false);
                }
                // prefs.setString(StaticValues.Mpin, "");
              },
              child: Text("YES")),
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("NO")),
        ],
      ),
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete MPin"),
      content: Text("Are you sure want to delete MPin."),
      actions: [
        okButton,
      ],
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
