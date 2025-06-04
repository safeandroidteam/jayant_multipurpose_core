class PickUpTypeResponseModal {
  final int pkcCode;
  final String pkcDescription;

  PickUpTypeResponseModal({
    required this.pkcCode,
    required this.pkcDescription,
  });

  factory PickUpTypeResponseModal.fromJson(Map<String, dynamic> json) {
    return PickUpTypeResponseModal(
      pkcCode: json['Pkc_Code'],
      pkcDescription: json['Pkc_Description'],
    );
  }

  @override
  String toString() => pkcDescription; // Optional: helps with debug print
}
