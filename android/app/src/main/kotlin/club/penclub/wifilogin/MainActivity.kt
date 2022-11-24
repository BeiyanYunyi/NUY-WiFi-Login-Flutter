package club.penclub.wifilogin

import android.content.Context
import android.net.CaptivePortal
import android.net.ConnectivityManager
import android.net.Network
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

@Suppress("DEPRECATION")
class MainActivity : FlutterActivity() {
  private val CHANNEL = "club.penclub.wifilogin/default"

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(
      flutterEngine.dartExecutor.binaryMessenger,
      CHANNEL
    ).setMethodCallHandler { call, result ->
      if (call.method == "reportCaptivePortalDismissed") {
        val cp = intent.getParcelableExtra<CaptivePortal>(ConnectivityManager.EXTRA_CAPTIVE_PORTAL)
        cp?.reportCaptivePortalDismissed()
      } else {
        result.notImplemented()
      }
    }
  }

  override fun onStart() {
    super.onStart()
    var net: Network? = null
    val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val nets = cm.allNetworks
    nets.forEach { network ->
      val info = cm.getNetworkInfo(network)
      if (info?.type == ConnectivityManager.TYPE_WIFI) {
        net = network
      }
    }
    Log.e("FFF", "asdfasf!")
    if (net != null) {
      Log.e("FFF", "FkYou!")
      cm.bindProcessToNetwork(net)
    }
  }
}
