package com.example.background_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.NetworkInfo

class NetworkChangeReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context != null) {
            val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork: NetworkInfo? = cm.activeNetworkInfo
            val isConnected = activeNetwork?.isConnectedOrConnecting == true
            if (isConnected) {
                // Check if there is any unsent data in SharedPreferences and send it to Firebase
            }
        }
    }
}
