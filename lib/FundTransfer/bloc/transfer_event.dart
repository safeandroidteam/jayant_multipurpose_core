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
  final String userId;

  FetchCustomerFromAccNo(this.userId);
}

class FetchFundTransferType extends TransferEvent {
  FetchFundTransferType();
}

class FetchBenificiaryevent extends TransferEvent {
  final String id;

  FetchBenificiaryevent(this.id);
}
