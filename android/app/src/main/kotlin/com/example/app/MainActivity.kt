package com.example.app

import android.content.Intent
import android.os.Bundle
import com.easebuzz.payment.kit.PWECouponsActivity
import com.google.gson.Gson
import datamodels.PWEStaticDataModel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity: FlutterActivity() {
    private val channel = "ease_buzz"
    private var channelResult: MethodChannel.Result? = null
    private var startPayment = true

    private fun startPayment(arguments: Any) {
        try {
            val gson = Gson()
            val parameters = JSONObject(gson.toJson(arguments))
            val intentProceed = Intent(baseContext, PWECouponsActivity::class.java)
            intentProceed.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
            intentProceed.putExtra("access_key", parameters.getString("access_key"))
            intentProceed.putExtra("pay_mode", parameters.getString("pay_mode"))
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE)
        } catch (e: java.lang.Exception) {
            startPayment = true
            val errorMap = HashMap<Any, Any>()
            val errorDescMap = HashMap<Any, Any>()
            val errorDesc = "exception occurred:" + e.message
            errorDescMap["error"] = "Exception"
            errorDescMap["error_msg"] = errorDesc
            errorMap["result"] = PWEStaticDataModel.TXN_FAILED_CODE
            errorMap["payment_response"] = errorDescMap
            channelResult?.success(errorMap)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data);

        if (data != null) {
            if (requestCode == PWEStaticDataModel.PWE_REQUEST_CODE) {
                startPayment = true
                val response = JSONObject()
                val errorMap = HashMap<Any, Any>()

                val result = data.getStringExtra("result")
                val paymentResponse = data.getStringExtra("payment_response")

                if (result != null && paymentResponse != null) {

                    try {
                        val obj = JSONObject(paymentResponse)
                        response.put("result", result)
                        response.put("payment_response", obj)
                        channelResult?.success(JsonConverter.convertToMap(response))
                    } catch (e: java.lang.Exception) {
                        val errorDescMap = HashMap<Any, Any>()
                        errorDescMap["error"] = result
                        errorDescMap["error_msg"] = paymentResponse
                        errorMap["result"] = result
                        errorMap["payment_response"] = errorDescMap
                        channelResult?.success(errorMap)
                    }
                } else {
                    super.onActivityResult(requestCode, resultCode, data)
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        startPayment = true

        MethodChannel(
            flutterEngine?.dartExecutor?.binaryMessenger!!,
            channel
        ).setMethodCallHandler { call, result ->
            channelResult = result
            if (call.method.equals("payWithEasebuzz")) {
                if (startPayment) {
                    startPayment = false
                    startPayment(call.arguments)
                }
            }
        }
    }
}
