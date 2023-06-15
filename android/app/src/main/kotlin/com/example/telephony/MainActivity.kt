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
import android.telephony.SubscriptionInfo
import android.os.Build

class MainActivity: FlutterActivity() {
    private val CHANNEL="sim.flutter.methodchannel/android";
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
                "getSimState"  -> {
                  val slotIndex = call.argument<Int>("slotIndex")
                  if(slotIndex!=null)
                  result.success(getSimState(slotIndex))
                }
                "getSimSlotCount" -> result.success(getSimSlotCount())
                "getSubscriptionId"  -> {
                  val slotIndex = call.argument<Int>("slotIndex")
                  if(slotIndex!=null)
                  result.success(getSID(slotIndex))
                }
                "getCarrierName"-> {
                  val slotIndex=call.argument<Int>("slotIndex")
                  if(slotIndex!=null)
                  result.success(getCarrierName(slotIndex))
                }
                "getPhoneNumber" -> {
                  val slotIndex=call.argument<Int>("slotIndex")
                  if(slotIndex!=null)
                  result.success(getPhoneNumber(slotIndex))
                }
            } 
        }
    }
private fun getPhoneNumber(slotIndex:Int):String {
  val simState=getSimState(slotIndex);
  if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
    if(simState=="ABSENT"){
      return "sim not found";
    }
    else if(simState=="ACTIVE"){
      return telephonyManager.getLine1Number();
    }
    else if(simState=="LOCKED, pin required"){
    return "SIM locked";
    }
    else if(simState=="LOCKED, puk required"){
      return "SIM locked"
    }
    else{
      return telephonyManager.getLine1Number();
    }
} else {
   val subId=getSID(slotIndex);
   if(simState=="ABSENT"){
    return "sim not found";
  }
  else if(simState=="ACTIVE"){
    return subscriptionManager.getPhoneNumber(subId);
  }
  else {
  return "SIM locked";
  }
}
}

private fun getCarrierName(slotIndex:Int):String{
  val simState=getSimState(slotIndex);
  if(simState=="ABSENT"){
    return "sim not found";
  }
  else if(simState=="ACTIVE"){
    return telephonyManager.getSimOperatorName();
  }
  else{
  return "SIM locked";
  }
}

private fun getSID(slotIndex:Int):Int{
        val arr:IntArray? = subscriptionManager.getSubscriptionIds(slotIndex);
        if(arr==null){
         return 0;
        }
        else{
          return arr[0];
        }
}

private fun getSimState(slotIndex:Int):String{
  val simState=telephonyManager.getSimState(slotIndex)
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

 private fun getSimSlotCount():Int{
  return subscriptionManager.getActiveSubscriptionInfoCountMax()
}

private fun getPhoneType():String{
val phoneType=telephonyManager.getPhoneType()

when(phoneType){
 1->{
   return "GSM"
 }
 2->{
   return "CDMA"
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
}