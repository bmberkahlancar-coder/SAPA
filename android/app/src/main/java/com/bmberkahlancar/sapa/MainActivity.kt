package com.bmberkahlancar.sapa

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val textView = TextView(this)
        textView.text = "SAPA"
        textView.textSize = 32f
        textView.setPadding(40, 80, 40, 40)

        setContentView(textView)
    }
}
