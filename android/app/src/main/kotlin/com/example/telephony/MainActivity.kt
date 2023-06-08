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
                // "getInfo"  -> result.success(getInfo())
                "getInfo" -> result.success(getInfo())
            }  
        }
    }
    private fun getInfo():String{
      val currState=telephonyManager.getSimState()
      when (currState){
        1->{
           return "sim card is absent"
        }
        2->{
           return "sim card is locked, pin required"
        }
        3->{
            return "sim card is locked, puk required"
        }
        4->{
            return "sim card is locked to network operator"
        }
        5->{
            return "sim card is active"
        }

      }
      return "unknown state"

    }
   
}
