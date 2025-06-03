class PickUpTypeData {
  final int pkcCode;
  final String pkcDescription;

  PickUpTypeData({required this.pkcCode, required this.pkcDescription});

  @override
  String toString() => pkcDescription;
}
