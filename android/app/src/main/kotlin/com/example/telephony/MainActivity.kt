package com.example.telephony

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.telephony.TelephonyManager
import android.telephony.SubscriptionManager
import android.content.pm.PackageManager
import android.Manifest
import android.telecom.Call

class MainActivity: FlutterActivity() {
    private val CHANNEL="device_sim_info";
    private lateinit var telephonyManager: TelephonyManager
    private lateinit var subscriptionManager: SubscriptionManager
    private val READ_PRIVILEGED_PHONE_STATE_REQUEST_CODE=1
     override fun configureFlutterEngine(flutterEngine:FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        telephonyManager=getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        subscriptionManager=getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler {call,result->
            when (call.method){
                "getPhoneType" -> result.success(getPhoneType())
                "getSimState"  -> result.success(getSimState())
                "getSimSlotCount" -> result.success(getSimSlotCount())
                // "checkPermission"  -> result.success(checkPermission())
            } 
        }
    }
    private fun getSimSlotCount():Int{
         return subscriptionManager.getActiveSubscriptionInfoCountMax ()
    }
    private fun getPhoneType():String{
      val phoneType=telephonyManager.getPhoneType()
      when(phoneType){
        1->{
          return "GSM"
        }
        2->{
          return  "CDMA"
        }
        3->{
          return "SIP"
        }
        4->{
          return "THIRD_PARTY"
        }
      }
      return "NONE"
    }
    private fun getSimState():String{
        val simState=telephonyManager.getSimState()
        when (simState){  
            1->{
              return  "ABSENT"
            }
            2->{
              return  "LOCKED, pin required"
            }
            3->{
               return  "LOCKED, puk required"
            }
            4->{
               return  "LOCKED to network operator"
            }
            5->{
               return  "ACTIVE"
            }
          }    
          return "Unknown"
        }
    }
