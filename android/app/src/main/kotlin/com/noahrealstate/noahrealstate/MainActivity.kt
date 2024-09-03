package com.noahrealestate.app

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.telephony.TelephonyManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/sim"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSimData") {
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
                    val simData = getSimData()
                    result.success(simData)
                } else {
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_PHONE_STATE), 1)
                    result.error("PERMISSION_DENIED", "Permission not granted", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getSimData(): Map<String, String> {
        val telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager
        val simOperatorName = telephonyManager.simOperatorName
        val simCountryIso = telephonyManager.simCountryIso
        val simState = telephonyManager.simState
        val simSerialNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            telephonyManager.simSerialNumber
        } else {
            telephonyManager.simSerialNumber
        }
        val phoneNumber = if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_NUMBERS) == PackageManager.PERMISSION_GRANTED) {
            telephonyManager.line1Number
        } else {
            "Permission not granted"
        }

        return mapOf(
            "operator" to simOperatorName,
            "country" to simCountryIso,
            "state" to simState.toString(),
            "serial" to (simSerialNumber ?: "Unavailable"),
            "phoneNumber" to (phoneNumber ?: "Unavailable")
        )
    }
}
