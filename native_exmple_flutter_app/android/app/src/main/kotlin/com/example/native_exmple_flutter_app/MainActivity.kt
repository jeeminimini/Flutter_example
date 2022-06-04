package com.example.native_exmple_flutter_app

import android.app.AlertDialog
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Base64

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.dev/info"
    private val CHANNEL2 = "com.flutter.dev/encrypto"
    private val CHANNEL3 = "com.flutter.dev/dialog"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL3).setMethodCallHandler{
            call,result -> if(call.method == "showDialog"){
               AlertDialog.Builder(this)
                       .setTitle("Flutter")
                       .setMessage("네이티브에서 출력하는 창입니다.")
                       .show()
        }
        }
    }
    private fun getDeviceInfo(): String{
        val sb = StringBuffer()
        sb.append(Build.DEVICE + "\n")
        sb.append(Build.BRAND + "\n")
        sb.append(Build.MODEL + "\n")
        return sb.toString()
    }
    
}
