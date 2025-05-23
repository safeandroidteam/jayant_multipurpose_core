package com.safesoftware.passbook_core_jayant

import android.content.Context
import android.os.Bundle
import android.telephony.SmsManager
import android.telephony.SubscriptionManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "sim_verification"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getSimList" -> {
                    val simList = getSimList()
                    result.success(simList)
                }
                "sendSMS" -> {
                    val subscriptionId = call.argument<Int>("subscriptionId")
val phoneNumber = call.argument<String>("phoneNumber")
val message = call.argument<String>("message")

if (subscriptionId == null || phoneNumber == null || message == null) {
    result.error("INVALID_ARGS", "Missing arguments", null)
    return@setMethodCallHandler
}


                    try {
                        val smsManager = SmsManager.getSmsManagerForSubscriptionId(subscriptionId)
                        smsManager.sendTextMessage(phoneNumber, null, message, null, null)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("SMS_FAILED", "Could not send SMS", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getSimList(): List<Map<String, Any>> {
        val subscriptionManager = getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        val activeSims = subscriptionManager.activeSubscriptionInfoList ?: return emptyList()
        return activeSims.map {
            mapOf(
                "carrierName" to it.carrierName.toString(),
                "number" to it.number,
                "slotIndex" to it.simSlotIndex,
                "subscriptionId" to it.subscriptionId
            )
        }
    }
}
