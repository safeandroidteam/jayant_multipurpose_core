import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef CustomResponse = Function(Map<String, dynamic> response, String error);

class RestAPI {
  static String clientId = "2";

  //  static String clientSecret = "9Uei7JezQFj15Vs5TyMfWflnOBKtfY6C17O1pnDY";
  //
  static String clientSecret = "1IWvjOOvaoC7DIsQuep9opQ2dRlPeThAukV6vNCN";

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(APis._superLink);

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('Internet connected');
      }
    } on SocketException catch (_) {
      debugPrint('Internet not connected');
    }
  }

  Future<T> get<T>(String url, {BuildContext? context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? "";
    debugPrint('Api Get, url $url');
    T responseJson;
    try {
      if (context != null) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Processing Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 48.0),
                  Text(
                    "Please do not press back or close the app",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            );
          },
        );
      }
      Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      debugPrint("RESPONSE ${response.body}");
      responseJson = _returnResponse(response);
      if (context != null) Navigator.of(context).pop();
    } on SocketException {
      debugPrint('SocketException');
      throw FetchDataException('Either network issue nor server error');
    } on TimeoutException {
      debugPrint('TimeoutException');
      throw FetchDataException('Time out try again');
    }
    debugPrint('api get recieved!');
    return responseJson;
  }

  Future<T?> post<T>(String url, {params}) async {
    SharedPreferences prefs = StaticValues.sharedPreferences!;
    String? token = prefs.getString('accessToken');
    var uri = Uri.parse(url);
    debugPrint('Api Post, url $uri  and $params');
    T? responseJson;

    try {
      final response = await http.post(
        uri,
        body: json.encode(params),
        headers: {
          "Accept": "application/json",
          'Content-type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      debugPrint("POST RESPONSE : ${response.statusCode} ${response.body}");
      responseJson = _returnResponse(response);
      //      throw Exception('Testing');
      //      print("RESPONSEJSON : $responseJson");
    } on SocketException {
      debugPrint('SocketException');
      throw FetchDataException('Either network issue nor server error');
    } on TimeoutException {
      debugPrint('TimeoutException');
      throw FetchDataException('Time out try again');
    }
    debugPrint('api post.');
    return responseJson;
  }
}

dynamic _returnResponse<T>(T response) {
  debugPrint('response-------------- $T');
  if (response is http.Response) {
    // debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        debugPrint("responseJson : $responseJson");
        return responseJson;
      case 404:
        throw NotFoundException(json.decode(response.body));
      case 400:
        throw BadRequestException(json.decode(response.body));
      case 401:
      case 403:
        throw UnauthorisedException(json.decode(response.body));
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  } else if (response is Map<String, dynamic>) {
    debugPrint("MAP :::");
    debugPrint("$response");
    switch (response["code"]) {
      case 200:
        var responseJson = response["response"];
        debugPrint("responseJson : $responseJson");
        return responseJson;
      case 404:
        throw NotFoundException(response["response"]);
      case 400:
        throw BadRequestException(response["response"]);
      case 401:
      case 403:
        throw UnauthorisedException(response["response"]);
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response["code"]}',
        );
    }
  }
}

///[MEDIA] get full size image without crop
///[THUMB] get cropped size image
enum ImageConversion { MEDIA, THUMB }

enum ImageFolder { PROFILE, DOCUMENT }

class APis {
  static String apiGenerate({
    required String path,
    Map<String, String?>? params,
  }) => Uri.http(StaticValues.apiGateway!, path, params).toString();

  static final String _superLink = 'https://mobapiuat.onlinesafe.in';
  //  static String _superLinkJayant = 'http://Azure-demo2.safeandsmartbank.com:6544';

  /// Production API
  // static String _superLinkJayant = 'http://apirbl.jayantindia.com:6395';
  // static String _superLinkJayant1 = 'http://apirbl.jayantindia.com:6393';
  //test

  static final String _superLinkJayant = 'http://apirbl.jayantindia.com:6389';
  static final String _superLinkJayant1 =
      'https://sec2pay.jayantindia.com:6390';

  /// New
  //app version & Company Code
  static String mobileGetVersion = "$_superLink/FetchMobAppVersion";

  //register
  static String registerAcc = "$_superLink/Save_UserMaster";
  static String getRegisterOTP = "$_superLink/ValidateSignUpMobileNo";
  static String validateOTP = "$_superLink/ValidateSignUpMobileNoOTP";

  //Login
  static String loginUrl = "$_superLink/ValidateUserLogin";
  static String loginOtpVerify =
      "$_superLink/Validate_UserLoginOTPVerification";
  static String loginMPin = "$_superLink/ValidateUserLoginMPIN";
  static String updateUserMPin = "$_superLink/InsertUpdateUserMPIN";
  static String changeUserPassword = "$_superLink/Validate_ChangePassword";

  //Account section
  static String fetchAccDetailsbySection =
      "$_superLink/Fetch_AccountDetailsBySection";
  static String fetchTransactions = "$_superLink/Fetch_TransactionHistory";
  static String fetchLoanPassbookDetails =
      "$_superLink/Fetch_LoanPassbookDetails";

  //Search
  static String fillAccountList = "$_superLink/Fill_AccountList";
  static String fetchAccountStatement = "$_superLink/Fetch_AccountStatement";

  ///Pick Up Types
  static String fillPickUp = "$_superLink/Fill_PickUP";

  //beneficiary
  static String fetchBeneficiaryList = "$_superLink/FetchBeneficiaryList";
  static String fetchCustomerSB = "$_superLink/Fetch_CustomerSB";
  static String fetchUserLimit = "$_superLink/Fetch_UserLimitRights";
  static String saveBeneficiary = "$_superLink/SaveBeneficiary";
  static String deleteBeneficiaryNew= "$_superLink/DeleteBeneficiary";
  static String fetchBeneficiaryToUpdate= "$_superLink/FetchBeneficiary";
  static String updateBeneficiary= "$_superLink/UpdateBeneficiary";
  //IFSC to get Bank Details
  static String fetchBeneficiaryBankDetails= "$_superLink/Fetch_BenificiaryBankDetails";
  //vishnu done

  //Other Bank Transfer
  static String fillTransferTypeDetails =
      "$_superLink/Fill_TransferTypeDetails";
  //own Bank transfer
  static String ownBankToAccNo = "$_superLink/Fetch_OwnAccountNumber";

  ///OLD
  static String generateRefID(String key) =>
      "$_superLink/GetReferanceNo?UserId=$key";

  //  http://103.230.37.187:6556/change_pin?Mob_no=chitra&old_pin=98478&new_pin=123456
  static String changePassword = "$_superLink/change_pin?Mob_no=";

  // static String loginMPin = "$_superLink/get_MpinLogin?";

  ///Register
  //http://103.230.37.187:6556/Mobile_Get_OTP?MobileNo=9847828438

  // http://103.230.37.187:6556/registercustomer?userid=chitra
  // &password=1234567&MobileNo=9847828438&Accno=0020070001785

  ///Forgot password
  static String forgotPasswordOtp = "$_superLink/Validate_ForgetPassword?";

  ///Get Card Balnce
  static String getCardBalance = "$_superLinkJayant1/GetAccountBalance";

  /// Card Reset
  static String cardReset = "$_superLinkJayant1/ResetPin";

  /// Card Block
  static String cardBlock = "$_superLinkJayant1/updatecardstatus";

  ///Get Card Statement
  static String getCardStatement = "$_superLinkJayant1/GetAccountStatements";

  ///Card Topup
  static String cardTopUp = "$_superLinkJayant1/TopUpCard";

  //http://103.230.37.187:6556/ChangePassword?userid=chitra&Newpassword=1234567
  static String changeForgotPass =
      "$_superLink/Validate_ForgetPasswordOTPVerification?";

  ///Account Open Page
  static String DebitAccOpen = "$_superLinkJayant/DebitAccOpen_T_Select";
  static String AccNoByAccBal = "$_superLinkJayant/AccNoByAccBal_T_Select";
  static String SchCodeBySchemeType =
      "$_superLinkJayant/SchCodeBySchemeType_T_Select";
  static String Fill_FDDepIntRateMatDtMatAmt =
      "$_superLinkJayant/Fill_FDDepIntRateMatDtMatAmt";
  static String DepSlabChartIntRateMatDtMatAmt =
      "$_superLinkJayant/Fill_DepSlabChartIntRateMatDtMatAmt";
  static String UTDepIntRateMatDtMatAmt =
      "$_superLinkJayant/Fill_UTDepIntRateMatDtMatAmt";
  static String MISDepIntRateMatDtMatAmt =
      "$_superLinkJayant/Fill_MISDepIntRateMatDtMatAmt";
  static String PickUp_N_Select_All = "$_superLinkJayant/PickUp_N_Select_All";
  static String Save_FD_AccOpen = "$_superLinkJayant/Save_FD_AccOpen";
  static String Save_RD_AccOpen = "$_superLinkJayant/Save_RD_AccOpen";
  static String Save_UT_AccOpen = "$_superLinkJayant/Save_UT_AccOpen";
  static String Save_MIS_AccOpen = "$_superLinkJayant/Save_MIS_AccOpen";
  static String Save_DD_AccOpen = "$_superLinkJayant/Save_DD_AccOpen";
  static String FDSlabInterestChart =
      "$_superLinkJayant/Fill_FDSlabInterestChart";
  static String UTSlabInterestChart =
      "$_superLinkJayant/Fill_UTSlabInterestChart";
  static String MISSlabInterestChart =
      "$_superLinkJayant/Fill_MISSlabInterestChart";
  static String GenerateOTP = "$_superLinkJayant/GenerateOTP";

  ///Get Funtransfer Limit
  static String getFuntransferLimit =
      "$_superLinkJayant/FillAmountLimit_T_Select";

  ///Get IFSC  Bank DetailsD
  static String getBeniBankDetails = "$_superLinkJayant/Fill_BeniBankDetails";

  ///Account Section
  static String accountLoanListUrl(String custID) =>
      "$_superLink/get_loan_details?Cust_id=$custID";

  // static String getDepositDetailsList(String custID) =>
  //     "$_superLink/get_deposit_details?Cust_id=$custID";

  ///get Other Acc List of passbook and account section=============
  //Acc_Type=LN(Loan List)
  //Acc_Type=DP(Deposit List)
  //Acc_Type=SH(Share List)
  //Acc_Type=MMBS(Chitty List)
  // "http://103.230.37.187:6556/get_Other_AccountInfo?Cust_id=31125&Acc_Type=";
  static String otherAccListInfo = "$_superLink/get_Other_AccountInfo?Cust_id=";

  ///Passbook Section===========
  //31125&Acc_no=0020070001785&Sch_code=007&Br_code=2&Frm_Date=";
  static String getDepositTransaction =
      "$_superLink/get_Full_Transaction?Cust_id=";

  //http://103.230.37.187:6556/GetChittypassbook_details?Accno=0020070001785&Frm_Date=
  static String getChittyPassbook =
      "$_superLink/GetChittypassbook_details?Accno=";

  //	http://103.230.37.187:6556/GetLoanpassbook_details?Accno=0020890000033
  static String getLoanPassbook = "$_superLink/GetLoanpassbook_details?Accno=";

  //1494&Acc_no=0010010001396&Sch_code=001&Br_code=1&Frm_Date=
  static String getShareTransaction =
      "$_superLink/get_share_Transaction?Cust_id=";

  ///AddBeneficiary
  ///CustId=&reciever_name=&reciever_mob=&reciever_ifsc=&reciever_Accno=&BankName=&Receiver_Address=
  ///    Uri.https(_superLink,addBeneficiary({}),{});
  static String addBeneficiary(Map params) =>
      "$_superLink/Mobile_ICICIFuntran_recieverdtls?"
      "CustId=${params["CustId"]}&reciever_name=${params["reciever_name"]}"
      "&reciever_mob=${params["reciever_mob"]}&reciever_ifsc=${params["reciever_ifsc"]}"
      "&reciever_Accno=${params["reciever_Accno"]}&BankName=${params["BankName"]}"
      "&Receiver_Address=${params["Receiver_Address"]}";

  static String deleteBeneficiary(String recieverId) =>
      "$_superLink/Mobile_ICICIFuntran_recieverdtls?"
      ///CustId = Reciever_Id, reciever_name = "delete"
      "CustId=$recieverId&reciever_name=DELETE"
      "&reciever_mob=&reciever_ifsc="
      "&reciever_Accno=&BankName="
      "&Receiver_Address=";

  static String fetchBeneficiary(String? custID) =>
      "$_superLink/Mobile_GetFuntran_recieverdtls?Cust_Id=$custID";

  ///Fund Transfer
  static String fetchIMPSCharge(String amount) =>
      "$_superLink/Mobile_Getcharges?Amount=";

  static String fetchFundTransferBal(String? custID) =>
      "$_superLink/get_CustomerSB?Cust_Id=$custID";

  static String fetchFundTransferType = "$_superLink/TransferTypeDetails";

  static String checkFundTransAmountLimit =
      "$_superLink/Mobile_Checkfund_limits";

  static String mobileRecharge = "$_superLinkJayant/MobileRecharge";

  static String accNoQr = "$_superLinkJayant/Fill_QRCodeAccNo_T_Select";
  static String upiQrCode = "$_superLinkJayant/AccNoQRCodeShow_T_Select";
  static String saveMpin = "$_superLinkJayant/Customer_MPIN_Update";

  static String checkFundTransferDailyLimit(Map params) =>
      "$_superLink/Mobile_CheckonlinepaymentDailyLimit?"
      "Customer_AccNo=${params["Customer_AccNo"]}&BankId=${params["BankId"]}"
      "&Customer_Mobileno=${params["Customer_Mobileno"]}&ShopAccno=${params["ShopAccno"]}"
      "&PayAmount=${params["PayAmount"]}";

  static String checkFundTransferDailyLimit2(Map<String, String?> params) =>
      apiGenerate(
        path: "Api/Values/Mobile_CheckonlinepaymentDailyLimit",
        params: params,
      );

  static String fundTransferOTPValidation(Map params) =>
      "$_superLink/FundTransferIMPSOTPValidation?"
      "Acc_No=${params["Acc_No"]}&OTP=${params["OTP"]}";

  static String getAccNoDeposit(Map params) =>
      "$_superLink/get_Other_AccountInfo?"
      "Cust_id=${params["Cust_id"]}&Acc_Type=${params["Acc_Type"]}";

  static String getDepositTransactionList(Map params) =>
      "$_superLink/get_DepositSearch?"
      "Cust_id=${params["Cust_id"]}&Acc_no=${params["Acc_no"]}&Sch_code=${params["Sch_code"]}&Br_code=${params["Br_code"]}&Frm_Date=${params["Frm_Date"]}&Todate=${params["Todate"]}";

  ///Other bank transfer
  static String otherBankFundTrans2(Map<String, String?> params) =>
      apiGenerate(path: "Api/Values/MobileIMPSTransaction", params: params);

  ///Own Bank Transfer
  static String fetchAccNo(String accNo) =>
      "$_superLink/Mobile_Get_Accno?MobileNo=$accNo";

  static String ownBankFundTrans2(Map params) => apiGenerate(
    params: params as Map<String, String?>?,
    path: "Api/Values/Mobile_Saveonlinepayment",
  );

  static String ownFundTransferOTP(Map params) =>
      "$_superLink/Mobile_Checkonlinepayment?"
      "Customer_AccNo=${params["Customer_AccNo"]}&BankId=${params["BankId"]}"
      "&Customer_Mobileno=${params["Customer_Mobileno"]}&ShopAccno=${params["ShopAccno"]}"
      "&PayAmount=${params["PayAmount"]}";

  /// QrScan
  static String fetchShoppingInfo(String accNo) =>
      "$_superLink/Mobile_Getdetails_onlinepayment?AccNo=$accNo";

  ///Recharge Operators
  static String rechargeOperators = "$_superLink/Mobile_Getoperaters";

  ///Dish TV Operators
  static String dishTvOperators = "$_superLink/DishTv_Getoperater";

  ///Electricity Operators
  static String electricityOperators = "$_superLinkJayant/Get_Electoperater";

  ///Postpaid Operators
  static String mobPostpaidOperators = "$_superLinkJayant/Get_MobPostoperater";

  ///MPin Login
  static String loginMpin = "$_superLinkJayant/Customer_MPIN_Validate";

  ///Water Operators
  static String waterOperators = "$_superLinkJayant/Get_Wateroperater";

  ///Recharge Mobile
  static String rechargeMobile(Map<String, String> params) =>
      apiGenerate(path: "Api/Values/Recharge_Mobile", params: params);

  ///Recharge Dish TV
  static String rechargeDishTv(Map<String, String> params) =>
      apiGenerate(path: "Api/Values/Recharge_DishTv", params: params);

  ///KSEB Pill Payment
  static String payKSEB(Map<String, String> params) =>
      apiGenerate(path: "Api/Values/KSEB_BillPayment", params: params);

  ///KWA Pill Payment
  static String payKWA(Map<String, String?> params) =>
      apiGenerate(path: "Api/Values/KWA_BillPayment", params: params);

  ///[imageSize] will only need when [imageConversion] is thumb
  String imageApi(
    String imageName, {
    int imageSize = 0,
    ImageConversion imageConversion = ImageConversion.MEDIA,
    ImageFolder imageFolder = ImageFolder.PROFILE,
  }) {
    if (imageSize > 0 && imageConversion == ImageConversion.MEDIA)
      throw "Change $imageConversion to ImageConversion.THUMB when setting the size of image.";
    var conversion =
        imageConversion == ImageConversion.MEDIA ? "media" : "thumb";
    var folder = imageFolder == ImageFolder.PROFILE ? "profiles" : "documents";
    return "$_superLink/$conversion/$folder/$imageName/${imageSize > 0 ? imageSize : ''}";
  }
}
