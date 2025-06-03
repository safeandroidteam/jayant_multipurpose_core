import 'package:meta/meta.dart';

@immutable
abstract class TransferEvent {}

class SendDetails extends TransferEvent {
  final String url;

  SendDetails(this.url);
}

class FetchCustomerAccNo extends TransferEvent {
  final String mobileNo;

  FetchCustomerAccNo(this.mobileNo);
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
class FetchUserLimitevent extends TransferEvent {
  final String cmpCode;
  final String custType;

  FetchUserLimitevent(this.cmpCode, this.custType);
  @override
  List<Object> get props => [custType];

}
