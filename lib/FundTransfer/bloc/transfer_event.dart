import 'package:meta/meta.dart';

@immutable
abstract class TransferEvent {}

class SendDetails extends TransferEvent {
  final String url;

  SendDetails(this.url);
}

class FetchToAccNo extends TransferEvent {
  final String mobileNo;
  final String cmpCode;

  FetchToAccNo(this.mobileNo,this.cmpCode);
}

class FetchCustomerFromAccNo extends TransferEvent {
  final String cmpCode;
  final String custID;

  FetchCustomerFromAccNo(this.cmpCode, this.custID);
}

class FetchFundTransferType extends TransferEvent {
  FetchFundTransferType();
}

class FetchBenificiaryevent extends TransferEvent {
  // final String id;
  final String cmpCode;
  final String custID;

  FetchBenificiaryevent(this.cmpCode, this.custID);
  @override
  List<Object> get props => [custID];
}
class SaveBeneficiaryevent extends TransferEvent {
  final String cmpCode;
  final String custID;


  SaveBeneficiaryevent(this.cmpCode, this.custID);
  @override
  List<Object> get props => [custID];

}
class DeleteBeneficiaryevent extends TransferEvent {
  final String cmpCode;
  final String custID;
  final String beneficiaryID;

  DeleteBeneficiaryevent(this.cmpCode, this.custID, this.beneficiaryID);
  @override
  List<Object> get props => [custID, beneficiaryID];
  

}

class FetchBeneficiaryToUpdateevent extends TransferEvent {
  final String cmpCode;
  final String custID;
  final String beneficiaryID;

  FetchBeneficiaryToUpdateevent(this.cmpCode, this.custID, this.beneficiaryID);
  @override
  List<Object> get props => [custID, beneficiaryID];

}

class FetchBeneficiaryBankDetailsevent extends TransferEvent {
  final String ifscCode;

  FetchBeneficiaryBankDetailsevent(this.ifscCode);
  @override
  List<Object> get props => [ifscCode];

}

class FetchUserLimitevent extends TransferEvent {
  final String cmpCode;
  final String custType;

  FetchUserLimitevent(this.cmpCode, this.custType);
  @override
  List<Object> get props => [custType];
}
