package com.example.background_app

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/service"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startService") {
                val intent = Intent(this, ForegroundService::class.java)
                startForegroundService(intent)
                result.success("Service Started")
            } else if (call.method == "scheduleWork") {
                val workRequest = OneTimeWorkRequestBuilder<MyWorker>().build()
                WorkManager.getInstance(this).enqueue(workRequest)
                result.success("Work Scheduled")
            } else {
                result.notImplemented()
            }
        }
    }
}
