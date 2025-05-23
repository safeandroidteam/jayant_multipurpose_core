import 'package:flutter/services.dart';

class SimSender {
  static const MethodChannel _channel = MethodChannel('sim_verification');

  static Future<List<Map<String, dynamic>>> getSimList() async {
    final result = await _channel.invokeMethod('getSimList');

    if (result is List) {
      return result
          .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    }

    return [];
  }

  static Future<bool> sendSMS(
    int subscriptionId,
    String phoneNumber,
    String message,
  ) async {
    final result = await _channel.invokeMethod('sendSMS', {
      'subscriptionId': subscriptionId,
      'phoneNumber': phoneNumber,
      'message': message,
    });

    return result == true;
  }
}
