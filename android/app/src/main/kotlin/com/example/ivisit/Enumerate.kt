package com.tnetic.ivisit

import android.content.Context

// Define the Reader class if it's not already defined
class Reader {
    fun GetActiveID(buffer: IntArray, length: Int): Int {
        return 0
    }
}

object Enumerate {
    @Throws(SDKException::class)
    fun USBConnect(context: Context): Array<Reader>? {
        return arrayOf(Reader())
    }
    fun USBDisConnect(context: Context): Array<Reader>? {
        return arrayOf(Reader())
    }
}
class SDKException(message: String) : Exception(message)