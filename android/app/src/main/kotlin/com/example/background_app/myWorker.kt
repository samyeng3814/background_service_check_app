package com.example.background_app

import android.content.Context
import androidx.work.Worker
import androidx.work.WorkerParameters

class MyWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        sendDataToFirebase()
        return Result.success()
    }

    private fun sendDataToFirebase() {
        println("NOTHING TO FETCH ONLY INSERT DATA") 
    }
}
