package com.example.your_app_name

import android.content.Context
import android.content.SharedPreferences

class SharedPrefManager(context: Context) {
    private val sharedPreferences: SharedPreferences = context.getSharedPreferences("AppPrefs", Context.MODE_PRIVATE)

    fun saveData(key: String, value: String) {
        sharedPreferences.edit().putString(key, value).apply()
    }

    fun getData(key: String): String? {
        return sharedPreferences.getString(key, null)
    }
}
