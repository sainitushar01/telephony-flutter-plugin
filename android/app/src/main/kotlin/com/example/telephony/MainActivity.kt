package com.example.telephony

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.telephony.TelephonyManager
import android.content.pm.PackageManager
import android.Manifest
import androidx.core.content.ContextCompat
import android.telecom.Call

class MainActivity: FlutterActivity() {
    private val CHANNEL="device_sim_info";
    private lateinit var telephonyManager: TelephonyManager
     override fun configureFlutterEngine(flutterEngine:FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        telephonyManager=getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler {call,result->
            when (call.method){
                "getInfo"  -> result.success(getInfo())
            }
        }
     }
     private fun getInfo(): Map<Any,Any> {
        val permission=Manifest.permission.READ_PHONE_STATE
        val requestCode=1
        if(ContextCompat.checkSelfPermission(this,permission)==PackageManager.PERMISSION_GRANTED){
            val telephonyInfo=HashMap<Any,Any>()
            telephonyInfo["deviceIMEI"]= telephonyManager.getImei() ?: ""
            telephonyInfo["phoneNumber"]= telephonyManager.line1Number ?:""
            telephonyInfo["simSerialNumber"] = telephonyManager.simSerialNumber ?:""
            telephonyInfo["simState"] = telephonyManager.simState ?:""
            telephonyInfo["networkOperator"] = telephonyManager.networkOperatorName ?:""
            telephonyInfo["isNetworkRoaming"] = (telephonyManager.isNetworkRoaming).toString() ?:""
            telephonyInfo["phoneType"] = telephonyManager.phoneType ?:""
            return telephonyInfo
        }
        else{
            ActivityCompat.requestPermissions(this, arrayOf(permission), requestCode)
        }
     }
     override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray):Map<Any,Any>{
     if (requestCode == 1) {
         if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
              val telephonyInfo=HashMap<Any,Any>()
              telephonyInfo["deviceIMEI"]= telephonyManager.getImei() ?: ""
              telephonyInfo["phoneNumber"]= telephonyManager.line1Number ?:""
              telephonyInfo["simSerialNumber"] = telephonyManager.simSerialNumber ?:""
              telephonyInfo["simState"] = telephonyManager.simState ?:""
              telephonyInfo["networkOperator"] = telephonyManager.networkOperatorName ?:""
              telephonyInfo["isNetworkRoaming"] = (telephonyManager.isNetworkRoaming).toString() ?:""
              telephonyInfo["phoneType"] = telephonyManager.phoneType ?:""
              return telephonyInfo
         } else {
             // Permission denied
             // Your code to handle the lack of permission
             return {}
         }
     }
    }
}
