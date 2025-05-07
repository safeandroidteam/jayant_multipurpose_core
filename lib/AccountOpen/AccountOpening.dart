import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../REST/RestAPI.dart';
import 'AccountNoModel.dart';
import 'DurationModel.dart';
import 'SchemeModel.dart';

class AccountOpening extends StatefulWidget {
  final String? _accNo, _balance, _accType;

  AccountOpening(this._accNo, this._balance, this._accType) : super();

  @override
  _AccountOpeningState createState() => _AccountOpeningState();
}

class _AccountOpeningState extends State<AccountOpening> {
  /*  static const _fruits = [
    'Apple',
    'Orange',
    'Lemon',
    'Strawberry',
    'Peach',
    'Cherry',
    'Watermelon',
  ];*/

  String str_PrincipalAmnt = "", str_Month = "", str_Day = "";
  String? str_Otp = "", mobileNo;
  var isLoading = false;

  var _formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  final meturityAmnt = TextEditingController();
  final depositAmntCtrl = TextEditingController();

  // final monthCtrl = TextEditingController();
  var monthCtrl;
  final dayCtrl = TextEditingController();
  final dayCtrl1 = TextEditingController(text: "0");

  var _fruits = <AccountNumber>[];
  var _scheme = <AccountScheme>[];
  var _scheme1 = ["CLOSE ENDED", "OPEN ENDED"];
  var _duration = <DurationModel>[];
  var _selectedAccNo, _selectedScheme, _selectedDuration, _accNo;

  bool _isLoadingSave = false;
  bool _isLoadingAccNo = false;
  bool _isLoadingScheme = false;
  bool _isLoadingDuration = false;

  String url1 = "${APis.DebitAccOpen}";

  String? str_mnthCtrl = "0", str_dayCtrl = "0";

  String? str_Slab = "", str_Period = "", str_IntRate = "";

  String? str_accNo,
      str_schemeCode,
      str_schemeName,
      str_duration = "",
      str_accType;

  String url = "${APis.DebitAccOpen}";
  String balance_url = "${APis.AccNoByAccBal}";
  String scheme_url = "${APis.SchCodeBySchemeType}";

  // String scheme_intrest_url = "http://Azure-demo2.safeandsmartbank.com:6544/SchCodeByIntRate_T_Select";
  String scheme_intrest_url = "${APis.Fill_FDDepIntRateMatDtMatAmt}";
  String scheme_intrest_rd_url = "${APis.DepSlabChartIntRateMatDtMatAmt}";
  String scheme_intrest_ud_url = "${APis.UTDepIntRateMatDtMatAmt}";
  String scheme_intrest_mis_url = "${APis.MISDepIntRateMatDtMatAmt}";
  String duration_url = "${APis.PickUp_N_Select_All}";
  String save_acc_open_url = "${APis.Save_FD_AccOpen}";
  String save_acc_open_rd_url = "${APis.Save_RD_AccOpen}";
  String save_acc_ud_url = "${APis.Save_UT_AccOpen}";
  String save_acc_mis_url = "${APis.Save_MIS_AccOpen}";
  String save_acc_open_dd_url = "${APis.Save_DD_AccOpen}";
  String get_slab_url = "${APis.FDSlabInterestChart}";
  String get_slab_rd_url = "${APis.DepSlabChartIntRateMatDtMatAmt}";
  String get_slab_ud_url = "${APis.UTSlabInterestChart}";
  String get_slab_mis_url = "${APis.MISSlabInterestChart}";
  String get_otp_accopen = "${APis.GenerateOTP}";

  /* String url = "http://Azure-demo2.safeandsmartbank.com:6544/DebitAccOpen_T_Select";
  String balance_url = "http://Azure-demo2.safeandsmartbank.com:6544/AccNoByAccBal_T_Select";
  String scheme_url = "http://Azure-demo2.safeandsmartbank.com:6544/SchCodeBySchemeType_T_Select";
 // String scheme_intrest_url = "http://Azure-demo2.safeandsmartbank.com:6544/SchCodeByIntRate_T_Select";
 String scheme_intrest_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_FDDepIntRateMatDtMatAmt";
 String scheme_intrest_rd_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_DepSlabChartIntRateMatDtMatAmt";
 String scheme_intrest_ud_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_UTDepIntRateMatDtMatAmt";
 String scheme_intrest_mis_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_MISDepIntRateMatDtMatAmt";
  String duration_url = "http://Azure-demo2.safeandsmartbank.com:6544/PickUp_N_Select_All";
  String save_acc_open_url = "http://Azure-demo2.safeandsmartbank.com:6544/Save_FD_AccOpen";
  String save_acc_open_rd_url = "http://Azure-demo2.safeandsmartbank.com:6544/Save_RD_AccOpen";
  String save_acc_ud_url = "http://Azure-demo2.safeandsmartbank.com:6544/Save_UT_AccOpen";
  String save_acc_mis_url = "http://Azure-demo2.safeandsmartbank.com:6544/Save_MIS_AccOpen";
  String save_acc_open_dd_url = "http://Azure-demo2.safeandsmartbank.com:6544/Save_DD_AccOpen";
  String get_slab_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_FDSlabInterestChart";
  String get_slab_rd_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_DepSlabChartIntRateMatDtMatAmt";
  String get_slab_ud_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_UTSlabInterestChart";
  String get_slab_mis_url = "http://Azure-demo2.safeandsmartbank.com:6544/Fill_MISSlabInterestChart";
  String get_otp_accopen = "http://Azure-demo2.safeandsmartbank.com:6544/GenerateOTP";*/

  List<AccountNumber> getAccount = [];
  List<AccountScheme> getSchemeList = [];
  List<DurationModel> getDurationList = [];
  SharedPreferences? preferences;

  String? balance = "";
  String? intr_rate = "";
  String? maturity_Date = "";
  String? maturity_Amnt = "";
  String? intrest_Payout = "";
  var principal_Payout = "";
  bool _schemeSelect = true;
  bool? monVal = false;

  int? _radioSelected = 1;
  String _radioVal = "0";
  bool? _accTerms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAccNo();
    //  getBalance();
    getScheme();
    //  getIntrestRate();
    getDuration();

    str_accNo = widget._accNo;
    str_accType = widget._accType;

    preferences = StaticValues.sharedPreferences;

    setState(() {
      mobileNo = preferences?.getString(StaticValues.mobileNo) ?? "";

      _accTerms = false;
      monthCtrl =
          str_accType == "UNNATI"
              ? TextEditingController(text: "36")
              : TextEditingController();
    });

    //getIntrestRate();
  }

  Future<List<AccountNumber>> getAccNo() async {
    setState(() {
      _isLoadingAccNo = true;
    });

    var response = await http.post(
      Uri.parse(url),
      headers: {"Accept": "Application/json"},
      body: {"Cust_Id": "1"},
    );
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
    var response1 = await http.post(
      Uri.parse(duration_url),
      headers: {"Accept": "application/json"},
      body: {"Pkc_Type": "44", "Pkc_ParentId": "0"},
    );
    setState(() {
      getDurationList = durationModelFromJson(response1.body);
      _duration.addAll(getDurationList);
      _isLoadingDuration = false;
    });
    return getDurationList;
  }

  Future<void> getSlabFD() async {
    var response = await http.post(
      Uri.parse(get_slab_url),
      headers: {"Accept": "application/json"},
      body: {
        //  "SchCode": str_schemeCode
        "SchCode": str_schemeCode,
        "Acc_No": str_accNo,
        "Month": monthCtrl.text,
        "Day": dayCtrl.text,
      },
    );
    setState(() {
      var listData = json.decode(response.body);

      str_Slab = listData[0]["Slab"];
      str_Period = listData[0]["Period"];
      str_IntRate = listData[0]["IntRate"];

      print("RESPONSE: ${listData.toString()}");
    });
    return;
  }

  Future<void> getSlabRD() async {
    var response = await http.post(
      Uri.parse(get_slab_rd_url),
      headers: {"Accept": "application/json"},
      body: {
        //  "SchCode": str_schemeCode
        "Type": str_accType,
        "Acc_No": str_accNo,
        "Amount": depositAmntCtrl.text,
        "PeriodMonth": monthCtrl.text,
        "PeriodDay": dayCtrl.text,
      },
    );
    print(get_slab_rd_url);
    print(str_accType);
    print(str_accNo);
    print(depositAmntCtrl.text);
    print(monthCtrl.text);
    print(dayCtrl.text);

    setState(() {
      var listData = json.decode(response.body);

      str_Slab = listData[0]["Slab"];
      str_Period = listData[0]["Period"];
      str_IntRate = listData[0]["IntRate"];

      print(str_Period);
    });
    return;
  }

  Future<void> getSlabUD() async {
    var response = await http.post(
      Uri.parse(get_slab_ud_url),
      headers: {"Accept": "application/json"},
      body: {
        //  "SchCode": str_schemeCode
        "Month": monthCtrl.text,
        //  "Month": "12"
      },
    );
    setState(() {
      var listData = json.decode(response.body);

      str_Slab = listData[0]["Slab"];
      str_Period = listData[0]["Period"];
      str_IntRate = listData[0]["IntRate"];

      print("Lijith : ${listData}");
    });
    return;
  }

  Future<void> getSlabMIS() async {
    var response = await http.post(
      Uri.parse(get_slab_mis_url),
      headers: {"Accept": "application/json"},
      body: {
        //  "SchCode": str_schemeCode
        "Acc_No": str_accNo,
        "SchCode": str_schemeCode,
        "Month": monthCtrl.text,

        //  "Month": "12"
      },
    );
    setState(() {
      var listData = json.decode(response.body);

      str_Slab = listData[0]["Slab"];
      str_Period = listData[0]["Period"];
      str_IntRate = listData[0]["IntRate"];

      print("Lijith : ${listData}");
    });
    return;
  }

  Future<String?> getIntrestRate() async {
    var response = await http.post(
      Uri.parse(scheme_intrest_url),
      headers: {'Accept': 'application/json'},
      body: {
        /* "SchCode": str_schemeCode,
      "Month": monthCtrl.text,
     // "Day": dayCtrl.text,
     "Day": "1",
      "Principle": depositAmntCtrl.text,*/
        "Acc_No": str_accNo,
        "SchCode": str_schemeCode,
        "Month": monthCtrl.text,
        "Day": dayCtrl.text,
        "Principle": depositAmntCtrl.text,

        /*  "SchCode": str_schemeCode,
     // "SchCode": "1111",
       "Month": "12",
       "Day": "1",
       "Principle": "5000"*/
      },
    );
    print(response.body);
    setState(() {
      var dataList = json.decode(response.body);
      print(dataList.toString());
      intr_rate = dataList[0]["IntRate"];
      maturity_Date = dataList[0]["MaturityDate"];
      maturity_Amnt = dataList[0]["MaturityAmt"];
    });
    return null;
  }

  Future<String?> getIntrestRateRD() async {
    var response = await http.post(
      Uri.parse(scheme_intrest_rd_url),
      headers: {'Accept': 'application/json'},
      body: {
        "Acc_No": str_accNo,
        "Type": str_accType,
        "Amount": depositAmntCtrl.text,
        "PeriodMonth": monthCtrl.text,
        "PeriodDay": dayCtrl.text,
      },
    );
    print(response.body);
    setState(() {
      var dataList = json.decode(response.body);
      print(dataList.toString());
      intr_rate = dataList[0]["CalIntRate"];
      maturity_Date = dataList[0]["MaturityDate"];
      maturity_Amnt = dataList[0]["MaturityAmt"];
    });
    return null;
  }

  Future<String?> getIntrestRateUD() async {
    var response = await http.post(
      Uri.parse(scheme_intrest_ud_url),
      headers: {'Accept': 'application/json'},
      body: {
        "Acc_No": str_accNo,
        "Principle": depositAmntCtrl.text,
        "Month": monthCtrl.text,
      },
    );
    print("REQ : ${Uri.parse(scheme_intrest_ud_url)}");
    print("REQ1 : ${depositAmntCtrl.text}");
    print("REQ2 : ${monthCtrl.text}");
    print(response.body);
    setState(() {
      var dataList = json.decode(response.body);
      print(dataList.toString());
      intr_rate = dataList[0]["IntRate"];
      maturity_Date = dataList[0]["MaturityDate"];
      maturity_Amnt = dataList[0]["MaturityAmt"];
      intrest_Payout = dataList[0]["TotPayout"];
      // principal_Payout = dataList[0]["TotPayout"];
    });
    return null;
  }

  Future<String?> getIntrestRateMIS() async {
    var response = await http.post(
      Uri.parse(scheme_intrest_mis_url),
      headers: {'Accept': 'application/json'},
      body: {
        "Acc_No": str_accNo,
        "SchCode": str_schemeCode,
        "Month": monthCtrl.text,
        "Principle": depositAmntCtrl.text,
      },
    );
    print(
      str_accNo! +
          "-" +
          str_schemeCode! +
          "-" +
          monthCtrl.text +
          "-" +
          depositAmntCtrl.text,
    );
    print(response.body);
    setState(() {
      var dataList = json.decode(response.body);
      print(dataList.toString());
      intr_rate = dataList[0]["IntRate"];
      maturity_Date = dataList[0]["MaturityDate"];
      maturity_Amnt = dataList[0]["MaturityAmt"];
      intrest_Payout = dataList[0]["IntPayout"];
    });
    return null;
  }

  Future<List<AccountScheme>> getScheme() async {
    setState(() {
      _isLoadingScheme = true;
    });
    var response = await http.post(
      Uri.parse(scheme_url),
      headers: {"Accept": "application/json"},
      body: {
        "SchemeType": widget._accType,
        // "SchemeType": "FD"
      },
    );
    print("REQ : ${Uri.parse(scheme_url)}");
    print("REQ1 : ${widget._accType}");
    print("LIJU111 : ${response.body}");
    setState(() {
      monthCtrl.text == "36";
      //  getSchemeList = accountSchemeFromJson(response.body);
      getSchemeList = accountSchemeFromJson(
        "[{\"Sch_Code\":\"1\",\"Sch_Name\":\"OPEN ENDED\"},{\"Sch_Code\":\"2\",\"Sch_Name\":\"CLOSE ENDED\"}]",
      );
      //  _scheme.addAll(getSchemeList);
      _scheme.addAll(getSchemeList);
      _isLoadingScheme = false;
    });
    return getSchemeList;
  }

  Future<String?> getBalance() async {
    var accBalance = await http.post(
      Uri.parse(balance_url),
      headers: {"Accept": "application/json"},
      body: {
        //  "Acc_No": "101001000000001"
        "Acc_No": str_accNo,
      },
    );
    var listData = json.decode(accBalance.body);
    setState(() {
      balance = listData[0]["AccBal"];
      print(balance);
    });
    return null;
  }

  Future<String?> saveAccountsFD() async {
    setState(() {
      _isLoadingSave = true;

      str_mnthCtrl = monthCtrl.text == "" ? "0" : monthCtrl.text;
      str_dayCtrl = dayCtrl.text == "" ? "0" : dayCtrl.text;
    });

    var saveResponse = await http.post(
      Uri.parse(save_acc_open_url),
      headers: {"Accept": "application/json"},
      body: {
        "DebitAccNo": str_accNo,
        //  "DebitAccNo": "11111111111",
        "DepAmt": depositAmntCtrl.text,
        "Scheme": str_schemeCode,
        "IntRate": intr_rate,
        "Month": str_mnthCtrl,
        "Day": str_dayCtrl,
        "MatuDate": maturity_Date,
        "MatuAmt": maturity_Amnt,
        "Permit": _radioVal,

        /*    "DebitAccNo": "11111111111",
        "DepAmt": "5000",
        "Scheme": "111",
        "IntRate": "10",
        "Month": "12",
        "Day": "0",
        "PayMode": "420",
        "MatuDate": "05/16/2022",
        "MatuAmt": "5500"*/
      },
    );
    print("LIJU" + str_dayCtrl!);
    print("LIJU1" + str_mnthCtrl!);

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"].toString();
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(status)));

      if (statusCode == "1") {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => AccountOpenHome()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget),
        );
      }

      print("LJTSTATUS" + statusCode);
    });
    return null;
  }

  Future<String?> saveAccountsUD() async {
    setState(() {
      _isLoadingSave = true;

      str_mnthCtrl = monthCtrl.text == "" ? "0" : monthCtrl.text;
      str_dayCtrl = dayCtrl.text == "" ? "0" : dayCtrl.text;
    });

    var saveResponse = await http.post(
      Uri.parse(save_acc_ud_url),
      headers: {"Accept": "application/json"},
      body: {
        "DebitAccNo": str_accNo,
        //  "DebitAccNo": "11111111111",
        "DepAmt": depositAmntCtrl.text,

        "IntRate": intr_rate,
        "Month": str_mnthCtrl,
        "Day": str_dayCtrl,

        "MatuDate": maturity_Date,
        "MatuAmt": maturity_Amnt,
        "Permit": _radioVal,

        /*    "DebitAccNo": "11111111111",
        "DepAmt": "5000",
        "Scheme": "111",
        "IntRate": "10",
        "Month": "12",
        "Day": "0",
        "PayMode": "420",
        "MatuDate": "05/16/2022",
        "MatuAmt": "5500"*/
      },
    );
    print("LIJU" + str_dayCtrl!);
    print("LIJU1" + str_mnthCtrl!);

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"].toString();
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(status)));

      if (statusCode == "1") {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => AccountOpenHome()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget),
        );
      }

      print("LJTSTATUS" + statusCode);
    });
    return null;
  }

  Future<String?> saveAccountsMIS() async {
    setState(() {
      _isLoadingSave = true;

      str_mnthCtrl = monthCtrl.text == "" ? "0" : monthCtrl.text;
      str_dayCtrl = dayCtrl.text == "" ? "0" : dayCtrl.text;
    });

    var saveResponse = await http.post(
      Uri.parse(save_acc_mis_url),
      headers: {"Accept": "application/json"},
      body: {
        "DebitAccNo": str_accNo,
        //  "DebitAccNo": "11111111111",
        "DepAmt": depositAmntCtrl.text,
        "Scheme": str_schemeCode,

        "IntRate": intr_rate,
        "Month": str_mnthCtrl,
        "Day": str_dayCtrl,

        "MatuDate": maturity_Date,
        "MatuAmt": maturity_Amnt,
        "Permit": _radioVal,

        /*    "DebitAccNo": "11111111111",
        "DepAmt": "5000",
        "Scheme": "111",
        "IntRate": "10",
        "Month": "12",
        "Day": "0",
        "PayMode": "420",
        "MatuDate": "05/16/2022",
        "MatuAmt": "5500"*/
      },
    );
    print("LIJU" + str_dayCtrl!);
    print("LIJU1" + str_mnthCtrl!);

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"].toString();
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(status)));

      if (statusCode == "1") {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => AccountOpenHome()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget),
        );
      }

      print("LJTSTATUS" + statusCode);
    });
    return null;
  }

  Future<String?> saveAccountsRD() async {
    setState(() {
      _isLoadingSave = true;
    });

    var saveResponse = await http.post(
      Uri.parse(save_acc_open_rd_url),
      headers: {"Accept": "application/json"},
      body: {
        "DebitAccNo": str_accNo,
        //  "DebitAccNo": "11111111111",
        "DepAmt": depositAmntCtrl.text,
        // "Scheme": str_schemeCode,
        "IntRate": intr_rate,
        "Month": monthCtrl.text,
        //  "Day": str_dayCtrl,
        "ContDate": dateController.text,
        "MatuDate": maturity_Date,
        "MatuAmt": maturity_Amnt,
        "Permit": _radioVal,

        /*  "DebitAccNo": "11111111111",
        "DepAmt": "5000",
        "Scheme": "111",
        "IntRate": "10",
        "Month": "12",
        "Day": "0",
        "PayMode": "420",
        "MatuDate": "05/16/2022",
        "MatuAmt": "5500"*/
      },
    );
    //print("LIJU"+str_accNo+"-"+depositAmntCtrl.text+"-"+intr_rate+"-"+str_mnthCtrl+"-"+dateController.text+"-"+maturity_Date+"-"+maturity_Amnt);

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"].toString();
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(status)));

      if (statusCode == "1") {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget),
        );
      }

      print("LJT" + status);
    });
    return null;
  }

  Future<String?> saveAccountsDD() async {
    setState(() {
      _isLoadingSave = true;
    });

    var saveResponse = await http.post(
      Uri.parse(save_acc_open_dd_url),
      headers: {"Accept": "application/json"},
      body: {
        "DebitAccNo": str_accNo,
        //  "DebitAccNo": "11111111111",
        "DepAmt": depositAmntCtrl.text,
        // "Scheme": str_schemeCode,
        "IntRate": intr_rate,
        // "Month": monthCtrl.text,
        //  "Day": str_dayCtrl,
        "Day": dayCtrl.text,
        "MatuDate": maturity_Date,
        "MatuAmt": maturity_Amnt,
        "Permit": _radioVal,

        /*  "DebitAccNo": "11111111111",
        "DepAmt": "5000",
        "Scheme": "111",
        "IntRate": "10",
        "Month": "12",
        "Day": "0",
        "PayMode": "420",
        "MatuDate": "05/16/2022",
        "MatuAmt": "5500"*/
      },
    );
    print(
      "LIJU" +
          str_accNo! +
          "-" +
          depositAmntCtrl.text +
          "-" +
          intr_rate! +
          "-" +
          dayCtrl.text +
          "-" +
          maturity_Date! +
          "-" +
          maturity_Amnt! +
          "-" +
          _radioVal,
    );

    setState(() {
      _isLoadingSave = false;
      var accOpenList = json.decode(saveResponse.body);
      var statusCode = accOpenList[0]["STATUSCODE"].toString();
      var status = accOpenList[0]["STATUS"];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(status)));

      if (statusCode == "1") {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget),
        );
      }

      print("LJT" + status);
    });
    return null;
  }

  void _rechargeConfirmation() {
    isLoading = false;
    var _pass;
    GlobalWidgets().validateOTP(
      context,
      getValue: (passVal) {
        setState(() {
          _pass = passVal;
        });
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [TextView("Enter OTP", size: 24.0), SizedBox(height: 10.0)],
      ),
      actionButton: StatefulBuilder(
        builder:
            (context, setState) => CustomRaisedButton(
              loadingValue: isLoading,
              buttonText:
                  isLoading ? CircularProgressIndicator() as String : "SAVE",
              onPressed:
                  isLoading
                      ? () {}
                      : () async {
                        if (_pass == str_Otp) {
                          accountOpen();
                        } else {
                          Fluttertoast.showToast(
                            msg: "OTP Miss match",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
            ),
      ),
    );
  }

  void accountOpen() {
    if (widget._accType == "FD") {
      if (str_accNo == "" ||
          depositAmntCtrl.text == "" ||
          str_schemeCode == "" ||
          intr_rate == "" ||
          maturity_Date == "" ||
          maturity_Amnt == "") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill All Fields")));
      } else {
        if (intr_rate == "0" || maturity_Date == "0" || maturity_Amnt == "0") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Value not be 0")));
        } else {
          if (monVal == true) {
            saveAccountsFD();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Accept Terms and Conditions")),
            );
          }
        }
      }
    } else if (widget._accType == "RD") {
      if (str_accNo == "" ||
          depositAmntCtrl.text == "" ||
          intr_rate == "" ||
          maturity_Date == "" ||
          maturity_Amnt == "" ||
          str_duration == "" && dateController.text == "") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill All Fields")));
      } else {
        if (intr_rate == "0" || maturity_Date == "0" || maturity_Amnt == "0") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Value not be 0")));
        } else {
          if (monVal == true) {
            saveAccountsRD();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Accept Terms and Conditions")),
            );
          }
        }
      }
    } else if (widget._accType == "DD") {
      if (str_accNo == "" ||
          depositAmntCtrl.text == "" ||
          intr_rate == "" ||
          maturity_Date == "" ||
          maturity_Amnt == "") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill All Fields")));
      } else {
        if (intr_rate == "0" || maturity_Date == "0" || maturity_Amnt == "0") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Value not be 0")));
        } else {
          if (monVal == true) {
            saveAccountsDD();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Accept Terms and Conditions")),
            );
          }
        }
      }
    } else if (widget._accType == "UNNATI") {
      if (str_accNo == "" ||
          depositAmntCtrl.text == "" ||
          intr_rate == "" ||
          maturity_Date == "" ||
          maturity_Amnt == "") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill All Fields")));
      } else {
        if (intr_rate == "0" || maturity_Date == "0" || maturity_Amnt == "0") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Value not be 0")));
        } else {
          if (monVal == true) {
            saveAccountsUD();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Accept Terms and Conditions")),
            );
          }
        }
      }
    } else if (widget._accType == "MIS") {
      if (str_accNo == "" ||
          depositAmntCtrl.text == "" ||
          intr_rate == "" ||
          maturity_Date == "" ||
          maturity_Amnt == "") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill All Fields")));
      } else {
        if (intr_rate == "0" || maturity_Date == "0" || maturity_Amnt == "0") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Value not be 0")));
        } else {
          if (monVal == true) {
            saveAccountsMIS();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Accept Terms and Conditions")),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  title: Text(getAccount[0].accNo),
        title: Text(
          "Account Opening ${widget._accType}",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        hint:
                            _isLoadingAccNo
                                ? Center(child: CircularProgressIndicator())
                                : Text('Select Acc No'),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: _selectedAccNo,
                        items:
                            _fruits.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Container(child: Text(item.accNo!)),
                              );
                            }).toList(),
                        onChanged: (selectedItem) {
                          //  str_accNo = selectedItem.accNo;
                          print(selectedItem!.accNo);
                          setState(() => _selectedAccNo = selectedItem);
                          getBalance();
                          print("LIJITH" + _selectedAccNo);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
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
                    child: Text(balance == "" ? "Account Balance" : balance!),
                  ),
                ),
                Text(
                  widget._accType == "FD"
                      ? "IN OPEN ENDED FD & MIS PRE CLOSURE ALLOWED ONLY AFTER 6 MONTHS,IN CLOSE ENDED FD & MIS PRE CLOSURE NOT ALLOWED"
                      : widget._accType == "RD"
                      ? "CLOSE ENDED PRODUCT PRE CLOSURE NOT ALLOWED BEFORE MATURITY."
                      : widget._accType == "DD"
                      ? "CLOSE ENDED PRODUCT PRE CLOSURE NOT ALLOWED BEFORE MATURITY."
                      : widget._accType == "UNNATI"
                      ? "CLOSE ENDED PRODUCT PRE CLOSURE NOT ALLOWED BEFORE MATURITY."
                      : "IN OPEN ENDED FD & MIS PRE CLOSURE ALLOWED ONLY AFTER 6 MONTHS.IN CLOSE ENDED FD & MIS PRE CLOSURE NOT ALLOWED",
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(child: Text("Account Number")),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 0.80,
                          ),
                        ),
                        // child: Text("Account Number")),
                        child: Text(widget._accNo!),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(child: Text("Account Balance")),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 0.80,
                          ),
                        ),
                        child: Text(widget._balance!),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible:
                      widget._accType == "RD" || widget._accType == "DD"
                          ? false
                          : true,
                  child: SizedBox(height: 10.0),
                ),
                Visibility(
                  visible:
                      widget._accType == "RD" ||
                              widget._accType == "DD" ||
                              widget._accType == "UNNATI"
                          ? false
                          : true,
                  child: Row(
                    children: [
                      Expanded(child: Text("Scheme")),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 0.80,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<AccountScheme>(
                              hint:
                                  _isLoadingScheme
                                      ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : Text('Select Scheme'),
                              icon: Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              value: _selectedScheme,
                              items:
                                  _scheme.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Container(
                                        child: Text(item.schName!),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (selectedItem) {
                                str_schemeCode = selectedItem!.schCode;
                                str_schemeName = selectedItem.schName;
                                //  print(selectedItem.schName);
                                print(str_schemeName);
                                //   _schemeSelect = false;

                                //      getSlab();
                                setState(() => _selectedScheme = selectedItem);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      widget._accType == "RD" ||
                              widget._accType == "DD" ||
                              _schemeSelect ||
                              str_Slab == ""
                          ? false
                          : true,
                  child: SizedBox(height: 10.0),
                ),
                Visibility(
                  //  visible: widget._accType == "RD" || widget._accType == "DD" || _schemeSelect?false:true,
                  visible:
                      widget._accType == "RD" ||
                              widget._accType == "DD" ||
                              _schemeSelect ||
                              str_Slab == ""
                          ? false
                          : true,
                  child: Container(
                    height: 40.0,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Slab : " + str_Slab!)),
                          Expanded(child: Text("Period : " + str_Period!)),
                          Expanded(child: Text("Int Rate : " + str_IntRate!)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(child: Text("Deposit Amount")),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          onChanged: (text) {
                            print("LJTAMNT" + text);

                            setState(() {
                              intr_rate = "";
                              maturity_Date = "";
                              maturity_Amnt = "";
                            });
                          },
                          validator: (value) {
                            //  validator: (value) =>
                            //  value.isNotEmpty && double.parse(value) >= 500000
                            if (str_accType == "FD") {
                              if (double.parse(value!) < 5000) {
                                return 'Min Amount 5000';
                              }
                              if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!)) {
                                return 'Not Enough Balance';
                              } else {
                                return null;
                              }
                            }
                            if (str_accType == "UNNATI") {
                              if (value!.isEmpty) {
                                return 'Please Fill Fields';
                              }
                              if (double.parse(value) < 25000) {
                                return 'Min Amount 25000';
                              }
                              if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!)) {
                                return 'Not Enough Balance';
                              } else {
                                return null;
                              }
                            }
                            if (str_accType == "MIS") {
                              if (value!.isEmpty) {
                                return 'Please Fill Fields';
                              }
                              if (double.parse(value) < 100000) {
                                return 'Min Amount 100000';
                              }
                              if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!)) {
                                return 'Not Enough Balance';
                              } else {
                                return null;
                              }
                            }
                            return null;
                          },
                          controller: depositAmntCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.black12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: str_accType == "DD" ? false : true,
                  child: SizedBox(height: 10),
                ),
                Visibility(
                  visible: str_accType == "DD" ? false : true,
                  child: Row(
                    children: [
                      Expanded(child: Text("Month")),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            enabled: str_accType == "UNNATI" ? false : true,
                            onChanged: (text) {
                              setState(() {
                                intr_rate = "";
                                maturity_Date = "";
                                maturity_Amnt = "";
                                principal_Payout = "";
                                intrest_Payout = "";
                              });
                            },
                            controller: monthCtrl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.black12),
                            ),
                            /* validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Fields';
                              }

                              else{
                                return null;
                              }
                            },*/
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Visibility(
                  visible:
                      widget._accType == "RD" ||
                              widget._accType == "UNNATI" ||
                              widget._accType == "MIS"
                          ? false
                          : true,
                  child: Row(
                    children: [
                      Expanded(child: Text("Day")),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                intr_rate = "";
                                maturity_Date = "";
                                maturity_Amnt = "";
                                principal_Payout = "";
                                intrest_Payout = "";
                              });
                            },

                            controller: dayCtrl,
                            // controller: TextEditingController(text: "0"),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.black12),
                            ),
                            /*    validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Fields';
                              }
                              else{
                                return null;
                              }
                            },*/
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Visibility(
                  //  visible: widget._accType == "FD" || widget._accType == "UD" ? true : false,
                  visible: false,
                  child: Row(
                    children: [
                      Expanded(child: Text("Duration")),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 0.80,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<DurationModel>(
                              hint:
                                  _isLoadingDuration
                                      ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : Text('Select Duration'),
                              icon: Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              value: _selectedDuration,
                              items:
                                  _duration.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Container(
                                        child: Text(item.pkcDesc!),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (selectedItem) {
                                str_duration = selectedItem!.pkcCode.toString();
                                setState(
                                  () => _selectedDuration = selectedItem,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget._accType == "RD" ? true : false,
                  child: Row(
                    children: [
                      Expanded(child: Text("Installment Date")),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            readOnly: true,
                            controller: dateController,
                            onTap: () async {
                              {
                                var date =
                                    await (showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        )
                                        as FutureOr<DateTime>);
                                var _selectedDate = DateFormat(
                                  "dd/MM/yyyy",
                                ).format(date);

                                //   dateController.text = date.toString().substring(0,10);
                                dateController.text = _selectedDate;
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Installment Date',
                              hintStyle: TextStyle(color: Colors.black12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(_radioVal);

                      if (str_accType == "FD" || str_accType == "UNNATI"
                          ? str_schemeCode == "" ||
                              depositAmntCtrl.text == "" ||
                              monthCtrl.text == "" && dayCtrl.text == ""
                          : depositAmntCtrl.text == "" ||
                              monthCtrl.text == "" && dayCtrl.text == "") {
                        //   if(str_accType == "FD" ){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all Fields")),
                        );
                      } else {
                        //     str_accType == "FD" || str_accType == "UD"?getIntrestRate():getIntrestRateRD();
                        _schemeSelect = false;
                        if (str_accType == "FD") {
                          if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!) ||
                              double.parse(depositAmntCtrl.text) < 5000) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Amount Should be less then your Account Balance & Min FD Amount is 5000",
                                ),
                              ),
                            );
                          } else {
                            //  if(str_schemeCode == null  || depositAmntCtrl.text == "" || (monthCtrl.text == "" || dayCtrl1.text == "")){
                            /* if(str_schemeCode == null  && depositAmntCtrl.text == "" && (monthCtrl.text == "") || (dayCtrl1.text == "")){
                       // if(depositAmntCtrl.text == "" || monthCtrl.text == "" || dayCtrl1.text == ""){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please fill all Fields"),
                          ));
                        }*/

                            if (monthCtrl.text == "" && dayCtrl1.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please fill all Fields"),
                                ),
                              );
                            } else {
                              print("SchemeCode${str_schemeCode}");
                              getSlabFD();
                              getIntrestRate();
                            }
                          }
                        } else if (str_accType == "RD") {
                          if (double.parse(depositAmntCtrl.text) >=
                              double.parse(widget._balance!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Amount Should be less then your Account Balance",
                                ),
                              ),
                            );
                          } else {
                            getSlabRD();
                            getIntrestRateRD();
                          }
                        } else if (str_accType == "DD") {
                          if (double.parse(depositAmntCtrl.text) >=
                              double.parse(widget._balance!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Amount Should be less then your Account Balance",
                                ),
                              ),
                            );
                          } else {
                            getSlabRD();
                            getIntrestRateRD();
                          }
                        } else if (str_accType == "UNNATI") {
                          if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!) ||
                              double.parse(depositAmntCtrl.text) < 25000) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Amount Should be less then your Account Balance & Min Amount is 25000",
                                ),
                              ),
                            );
                          } else {
                            getSlabUD();
                            getIntrestRateUD();
                          }
                        } else if (str_accType == "MIS") {
                          if (double.parse(depositAmntCtrl.text) >=
                                  double.parse(widget._balance!) ||
                              double.parse(depositAmntCtrl.text) < 100000) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Amount Should be less then your Account Balance & Min Amount is 100000",
                                ),
                              ),
                            );
                          } else {
                            if (str_schemeName == "CLOSE ENDED") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("No Active Scheme Found"),
                                ),
                              );
                            } else {
                              if (str_schemeCode == null ||
                                  depositAmntCtrl.text == "" ||
                                  monthCtrl.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please fill all Fields"),
                                  ),
                                );
                              } else {
                                print("LJT$str_schemeCode");
                                getSlabMIS();
                                getIntrestRateMIS();
                              }
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Text(
                    "Fetch Maturity Date and Amount",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Standing"),
                    Text('Allow'),
                    Radio(
                      value: 1,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (dynamic value) {
                        setState(() {
                          _radioSelected = value;
                          _radioVal = '0';
                        });
                      },
                    ),
                    Text('Deny'),
                    Radio(
                      value: 2,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (dynamic value) {
                        setState(() {
                          _radioSelected = value;
                          _radioVal = '1';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(child: Text("Interest Rate")),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 0.80,
                          ),
                        ),
                        child: Text(intr_rate == "" ? "" : intr_rate!),
                      ),
                      //  child: Text("Intresr")),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),

                /*       Container(
                  height: 40.0,
                  child: TextFormField(
                    readOnly: true,
                    controller: dateController,
                    onTap: () async{
                      {
                        var date =  await showDatePicker(
                            context: context,
                            initialDate:DateTime.now(),
                            firstDate:DateTime(1900),
                            lastDate: DateTime(2100));
                        dateController.text = date.toString().substring(0,10);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Meturity Date',hintStyle: TextStyle(
                      color: Colors.black12
                    )
                    ),
                  ),
                ),*/
                Row(
                  children: [
                    Expanded(child: Text("Maturity Date")),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 0.80,
                          ),
                        ),
                        child: Text(maturity_Date == "" ? "" : maturity_Date!),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget._accType == "UNNATI"
                            ? "Total Amount Payable"
                            : "Maturity Amount",
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 0.80,
                          ),
                        ),
                        child: Text(maturity_Amnt == "" ? "" : maturity_Amnt!),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Visibility(
                  visible:
                      widget._accType == "MIS" || widget._accType == "UNNATI"
                          ? true
                          : false,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget._accType == "MIS"
                              ? "Interest Payout"
                              : "Monthly Payout",
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                          height: 40.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 0.80,
                            ),
                          ),
                          child: Text(
                            intrest_Payout == "" ? "" : intrest_Payout!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*     SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  visible: widget._accType == "UD"?true:false,
                  child: Row(
                    children: [
                      Expanded(child: Text("Principal Payout")),
                      Expanded(
                        child: Container(

                            padding: EdgeInsets.fromLTRB(10.0, 13, 00, 00),
                            height: 40.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(
                                  style: BorderStyle.solid, width: 0.80),
                            ),
                            child: Text(principal_Payout == ""?"":principal_Payout)),
                      ),
                    ],
                  ),
                ),*/
                SizedBox(height: 10.0),

                /* Text(widget._accType == "FD"?"":widget._accType =="RD"?"AMOUNT WILL BE DEDUCTED AUTOMATICALLY AS PER TERMS AND CONDITION.":widget._accType == "DD"?"AMOUNT WILL BE DEDUCTED AUTOMATICALLY AS PER TERMS AND CONDITION.":widget._accType == "UNNATI"? "AMOUNT WILL BE DEDUCTED AUTOMATICALLY AS PER TERMS AND CONDITION.":"AMOUNT WILL BE DEDUCTED AUTOMATICALLY AS PER TERMS AND CONDITION.",


                  style: TextStyle(
                      color: Colors.red
                  ),),
                SizedBox(height: 8.0,),*/
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: monVal,
                      onChanged: (bool? value) {
                        setState(() {
                          monVal = value;
                          print(monVal.toString());
                          _accTerms = monVal;
                        });
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(monVal.toString())));
                      },
                    ),
                    Text("I Accept the terms and conditions"),
                  ],
                ),
                Visibility(
                  visible: _accTerms! ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1.  Maturity Amount Before TDS"),
                      Text("2.  TDS will Deduct if Applicable"),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),

                /*   Container(
                  height: 40.0,
                  child: TextFormField(
                    controller: meturityAmnt,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Meturity Amount',
                        hintStyle: TextStyle(
                          color: Colors.black12
                        ),
                    ),
                  ),
                ),*/
                SizedBox(height: 10.0),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      var response = await RestAPI().post(
                        get_otp_accopen,
                        params: {
                          "MobileNo": mobileNo,
                          "Amt": depositAmntCtrl.text,
                          "SMS_Module": "GENERAL",
                          "SMS_Type": "GENERAL_OTP",
                          "OTP_Return": "Y",
                        },
                      );
                      print("rechargeResponse::: $response");
                      str_Otp = response[0]["OTP"];

                      //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str_Message)));
                      //  RestAPI().get(APis.rechargeMobile(params));
                      /*    Map response =
                            await RestAPI().get(APis.rechargeMobile(params));*/
                      //   getMobileRecharge();
                      setState(() {
                        isLoading = false;

                        Timer(Duration(minutes: 5), () {
                          setState(() {
                            str_Otp = "";
                          });
                        });
                      });

                      _rechargeConfirmation();

                      /*

                      if(widget._accType == "FD"){
                        if(str_accNo == "" || depositAmntCtrl.text == "" || str_schemeCode == "" || intr_rate == ""  || maturity_Date == "" || maturity_Amnt == "" ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Fill All Fields"),
                          ));
                        }else{
                          if(intr_rate == "0" || maturity_Date == "0" ||  maturity_Amnt == "0"){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Value not be 0"),
                            ));
                          }
                          else{
                            if(monVal  == true){
                              saveAccountsFD();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions")));
                            }

                          }

                        }

                      }else if(widget._accType == "RD"){
                        if(str_accNo == "" || depositAmntCtrl.text == "" || intr_rate == ""  || maturity_Date == "" || maturity_Amnt == "" || str_duration == "" &&  dateController.text == ""){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Fill All Fields"),
                          ));
                        }else{
                          if(intr_rate == "0" || maturity_Date == "0" ||  maturity_Amnt == "0"){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Value not be 0"),
                            ));
                          }
                          else{
                            if(monVal  == true){
                              saveAccountsRD();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions")));
                            }

                          }

                        }

                      }
                      else if(widget._accType == "DD"){

                        if(str_accNo == "" || depositAmntCtrl.text == "" || intr_rate == ""  || maturity_Date == "" || maturity_Amnt == "" ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Fill All Fields"),
                          ));
                        }else{
                          if(intr_rate == "0" || maturity_Date == "0" ||  maturity_Amnt == "0"){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Value not be 0"),
                            ));
                          }
                          else{
                            if(monVal  == true){
                              saveAccountsDD();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions")));
                            }


                          }

                        }

                      }

                      else if(widget._accType == "UNNATI"){
                        if(str_accNo == "" || depositAmntCtrl.text == "" || intr_rate == ""  || maturity_Date == "" || maturity_Amnt == "" ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Fill All Fields"),
                          ));
                        }else{
                          if(intr_rate == "0" || maturity_Date == "0" ||  maturity_Amnt == "0"){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Value not be 0"),
                            ));
                          }
                          else{
                            if(monVal  == true){
                              saveAccountsUD();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions")));
                            }

                          }

                        }

                      }

                      else if(widget._accType == "MIS"){
                        if(str_accNo == "" || depositAmntCtrl.text == "" || intr_rate == ""  || maturity_Date == "" || maturity_Amnt == "" ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Fill All Fields"),
                          ));
                        }else{
                          if(intr_rate == "0" || maturity_Date == "0" ||  maturity_Amnt == "0"){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Value not be 0"),
                            ));
                          }
                          else{
                            if(monVal  == true){
                              saveAccountsMIS();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions")));
                            }

                          }

                        }

                      }
*/
                    },
                    child:
                        _isLoadingSave
                            ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                            : Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
