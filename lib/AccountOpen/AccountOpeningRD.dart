import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AccountNoModel.dart';
import 'DurationModel.dart';
import 'SchemeModel.dart';

class AccountOpeningRD extends StatefulWidget {
  const AccountOpeningRD({Key? key}) : super(key: key);

  @override
  _AccountOpeningRDState createState() => _AccountOpeningRDState();
}

class _AccountOpeningRDState extends State<AccountOpeningRD> {
  final dateController = TextEditingController();
  final meturityAmnt = TextEditingController();
  final depositAmntCtrl = TextEditingController();

  var _fruits = <AccountNumber>[];
  var _scheme = <AccountScheme>[];
  var _duration = <DurationModel>[];
  var _selectedAccNo, _selectedScheme, _selectedDuration, _accNo;

  bool _isLoadingSave = false;
  bool _isLoadingAccNo = false;
  bool _isLoadingScheme = false;
  bool _isLoadingDuration = false;

  String? str_accNo, str_schemeCode, str_duration;

  String url =
      "http://Azure-demo2.safeandsmartbank.com:6544/DebitAccOpen_T_Select";
  String balance_url =
      "http://Azure-demo2.safeandsmartbank.com:6544/AccNoByAccBal_T_Select";
  String scheme_url =
      "http://Azure-demo2.safeandsmartbank.com:6544/SchCodeBySchemeType_T_Select";
  String scheme_intrest_url =
      "http://Azure-demo2.safeandsmartbank.com:6544/SchCodeByIntRate_T_Select";
  String duration_url =
      "http://Azure-demo2.safeandsmartbank.com:6544/PickUp_N_Select_All";
  String save_acc_open_url =
      "http://Azure-demo2.safeandsmartbank.com:6544/SaveAccOpen";

  List<AccountNumber> getAccount = [];
  List<AccountScheme> getSchemeList = [];
  List<DurationModel> getDurationList = [];

  String? balance = "";
  String? intr_rate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAccNo();
    //  getBalance();
    getScheme();
    //  getIntrestRate();
    getDuration();
  }

  Future<List<AccountNumber>> getAccNo() async {
    setState(() {
      _isLoadingAccNo = true;
    });

    var response = await http.post(Uri.parse(url),
        headers: {"Accept": "Application/json"}, body: {"Cust_Id": "1"});
    //  var listItem  = json.decode(response.body);
    // var data = listItem[0];
    //  print(data);
    setState(() {
      getAccount = accountNumberFromJson(response.body);
      // print(getAccount);
      _fruits.addAll(getAccount);
      // print(_fruits);
      _isLoadingAccNo = false;
    });
    return getAccount;
  }

  Future<List<DurationModel>> getDuration() async {
    setState(() {
      _isLoadingDuration = true;
    });
    var response1 = await http.post(Uri.parse(duration_url),
        headers: {"Accept": "application/json"},
        body: {"Pkc_Type": "44", "Pkc_ParentId": "0"});
    setState(() {
      getDurationList = durationModelFromJson(response1.body);
      _duration.addAll(getDurationList);
      _isLoadingDuration = false;
    });
    return getDurationList;
  }

  Future<String?> getIntrestRate() async {
    var response = await http.post(Uri.parse(scheme_intrest_url),
        headers: {"Accept": "application/json"},
        body: {"SchCode": str_schemeCode});
    setState(() {
      var dataList = json.decode(response.body);
      intr_rate = dataList[0]["IntRate"];
    });
    return null;
  }

  Future<List<AccountScheme>> getScheme() async {
    setState(() {
      _isLoadingScheme = true;
    });
    var response = await http.post(Uri.parse(scheme_url),
        headers: {"Accept": "application/json"}, body: {"SchemeType": "RD"});
    setState(() {
      getSchemeList = accountSchemeFromJson(response.body);
      _scheme.addAll(getSchemeList);
      _isLoadingScheme = false;
    });
    return getSchemeList;
  }

  Future<String?> getBalance() async {
    var accBalance = await http.post(Uri.parse(balance_url), headers: {
      "Accept": "application/json",
    }, body: {
      //  "Acc_No": "101001000000001"

      "Acc_No": str_accNo
    });
    var listData = json.decode(accBalance.body);
    setState(() {
      balance = listData[0]["AccBal"];
      print(balance);
    });
    return null;
  }

  Future<String?> saveAccounts() async {
    setState(() {
      _isLoadingSave = true;
    });

    var saveResponse = await http.post(Uri.parse(save_acc_open_url), headers: {
      "Accept": "application/json"
    }, body: {
      "DebitAccNo": str_accNo,
      "DepAmt": depositAmntCtrl.text,
      "Scheme": str_schemeCode,
      "IntRate": intr_rate,
      "Duration": str_duration,
      "MatuDate": dateController.text,
      "MatuAmt": meturityAmnt.text,
    });
    print("LIJU" + intr_rate!);

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"];
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(status),
      ));

      if (statusCode == 1) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }

      print("LJT" + status);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Opening RD",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(style: BorderStyle.solid, width: 0.80),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<AccountNumber>(
                          hint: _isLoadingAccNo
                              ? Center(child: CircularProgressIndicator())
                              : Text('Select Acc No'),
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          value: _selectedAccNo,
                          items: _fruits.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Container(child: Text(item.accNo!)),
                            );
                          }).toList(),
                          onChanged: (selectedItem) {
                            str_accNo = selectedItem!.accNo;
                            print(selectedItem.accNo);
                            setState(() => _selectedAccNo = selectedItem);
                            getBalance();
                            print("LIJITH" + _selectedAccNo);
                          })),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: false,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                    height: 40.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(style: BorderStyle.solid, width: 0.80),
                    ),
                    child: Text(
                      balance == "" ? "Account Balance" : balance!,
                    )),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(style: BorderStyle.solid, width: 0.80),
                  ),
                  child: Text("Account Number")),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(style: BorderStyle.solid, width: 0.80),
                  ),
                  child: Text("Account Balance")),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<AccountScheme>(
                        hint: _isLoadingScheme
                            ? Center(child: CircularProgressIndicator())
                            : Text('Select Scheme'),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: _selectedScheme,
                        items: _scheme.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(child: Text(item.schName!)),
                          );
                        }).toList(),
                        onChanged: (selectedItem) {
                          str_schemeCode = selectedItem!.schCode;
                          print(selectedItem.schName);

                          getIntrestRate();
                          setState(() => _selectedScheme = selectedItem);
                        })),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(style: BorderStyle.solid, width: 0.80),
                  ),
                  child: Text(intr_rate == "" ? "Interest Rate" : intr_rate!)),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                child: TextFormField(
                  controller: depositAmntCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Deposit Amount',
                    hintStyle: TextStyle(color: Colors.black12),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40.0,
                child: TextFormField(
                  controller: meturityAmnt,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Month',
                    hintStyle: TextStyle(color: Colors.black12),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 40.0,
                child: TextFormField(
                  controller: meturityAmnt,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Day',
                    hintStyle: TextStyle(color: Colors.black12),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<DurationModel>(
                        hint: _isLoadingDuration
                            ? Center(child: CircularProgressIndicator())
                            : Text('Select Duration'),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: _selectedDuration,
                        items: _duration.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(child: Text(item.pkcDesc!)),
                          );
                        }).toList(),
                        onChanged: (selectedItem) {
                          str_duration = selectedItem!.pkcCode.toString();
                          setState(() => _selectedDuration = selectedItem);
                        })),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 40.0,
                child: TextFormField(
                  readOnly: true,
                  controller: dateController,
                  onTap: () async {
                    {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      dateController.text = date.toString().substring(0, 10);
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Maturity Date',
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 40.0,
                child: TextFormField(
                  controller: meturityAmnt,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Maturity Amount',
                    hintStyle: TextStyle(color: Colors.black12),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    saveAccounts();
                  },
                  child: _isLoadingSave
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
