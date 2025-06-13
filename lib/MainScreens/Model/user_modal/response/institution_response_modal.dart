import 'dart:convert';

// Main model for the API response
class InstitutionResponseModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<InstitutionData> data;

  InstitutionResponseModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  // Factory constructor to create an ApiResponse from a JSON map
  factory InstitutionResponseModal.fromJson(Map<String, dynamic> json) {
    return InstitutionResponseModal(
      proceedStatus: json['ProceedStatus'] ?? "",
      proceedMessage: json['ProceedMessage'] ?? "",
      data:
          (json['Data'] as List<dynamic>)
              .map((e) => InstitutionData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  // Method to convert an ApiResponse object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'ProceedStatus': proceedStatus,
      'ProceedMessage': proceedMessage,
      'Data': data.map((e) => e.toJson()).toList(),
    };
  }
}

// Model for the items within the 'Data' array
class InstitutionData {
  final String custId;
  final String accNo;
  final String shareNo;

  InstitutionData({
    required this.custId,
    required this.accNo,
    required this.shareNo,
  });

  // Factory constructor to create a DataItem from a JSON map
  factory InstitutionData.fromJson(Map<String, dynamic> json) {
    return InstitutionData(
      custId: json['Cust_ID'] as String,
      accNo: json['Acc_No'] as String,
      shareNo: json['Share_No'] as String,
    );
  }

  // Method to convert a DataItem object to a JSON map
  Map<String, dynamic> toJson() {
    return {'Cust_ID': custId, 'Acc_No': accNo, 'Share_No': shareNo};
  }
}

// Example usage:
void main() {
  const String jsonString = '''
  {
      "ProceedStatus": "Y",
      "ProceedMessage": "SUCCESS",
      "Data": [
          {
              "Cust_ID": "63131",
              "Acc_No": "100327066472",
              "Share_No": "100001066471"
          }
      ]
  }
  ''';

  // Decode the JSON string into a Dart map
  final Map<String, dynamic> jsonMap =
      json.decode(jsonString) as Map<String, dynamic>;

  // Create an ApiResponse object from the JSON map
  final InstitutionResponseModal response = InstitutionResponseModal.fromJson(
    jsonMap,
  );

  // Print values to verify
  print('Proceed Status: ${response.proceedStatus}');
  print('Proceed Message: ${response.proceedMessage}');
  for (var item in response.data) {
    print('  Customer ID: ${item.custId}');
    print('  Account Number: ${item.accNo}');
    print('  Share Number: ${item.shareNo}');
  }

  // Convert the Dart object back to a JSON string (optional)
  final String encodedJson = json.encode(response.toJson());
  print('\nEncoded JSON:');
  print(encodedJson);
}
