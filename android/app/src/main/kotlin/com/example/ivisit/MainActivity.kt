package com.tnetic.ivisit

import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.tnetic.ivisit"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "connectUSB" -> {
                    val readers = connectUSB()
                    if (readers["error"] == null) {
                        result.success(readers)
                    } else {
                        result.error("UNAVAILABLE", readers["error"] as String?, null)
                    }
                }
                "disConnectUSB" -> {
                    val readers = disConnectUSB()
                    if (readers != null && readers.isNotEmpty()) {
                        result.success(readers.toString())
                    } else {
                        result.error("UNAVAILABLE", "USB not Disconnected", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    private fun connectUSB(): Map<String, Any?> {
        return try {
            val readers = Enumerate.USBConnect(applicationContext)
            if (readers != null && readers.isNotEmpty()) {
                val buffer = IntArray(64)
                val activeID = readers[0].GetActiveID(buffer, 64)
                mapOf(
                    "readers" to readers.map { it.toString() },
                    "activeID" to activeID
                )
            } else {
                Log.d("USB_DEBUG", "No USB readers found")
                mapOf(
                    "readers" to null,
                    "activeID" to null,
                    "error" to "No USB readers found"
                )
            }
        } catch (e: SDKException) {
            e.printStackTrace()
            Log.e("USB_DEBUG", "SDKException: ${e.message}")
            mapOf(
                "readers" to null,
                "activeID" to null,
                "error" to "SDKException: ${e.message}"
            )
        }
    }
    private fun disConnectUSB(): String? {
        return try {
            val readers = Enumerate.USBDisConnect(applicationContext)
            Log.d("USB_DEBUG", "DisConnected readers: $readers")
            if (readers != null && readers.isNotEmpty()) {
                val buffer = IntArray(64)
                val activeID = readers[0].GetActiveID(buffer, 64)
                Log.d("USB_DEBUG", "DisConnected activeID: $activeID")
                readers.toString()
            } else {
                null
            }
        } catch (e: SDKException) {
            e.printStackTrace()
            e.toString()
        }
    }
}
