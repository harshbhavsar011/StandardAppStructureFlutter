package com.example.standardappstructure;

import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;

import java.io.File;
import java.io.IOException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    final String CHANNEL = "com.example.standardappstructure/wallpaper";


    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("setWallpaper")) {
                  int setWallpaper=setWallpaper((String) call.arguments);

                  if (setWallpaper ==0) {
                    result.success(setWallpaper);
                  } else {
                    result.error("UNAVAILABLE", "", null);
                  }
                } else {
                  result.notImplemented();
                }
              }
            });
  }


  @TargetApi(Build.VERSION_CODES.ECLAIR)
  private int setWallpaper(String path) {
    int setWallpaper=1;
    File imgFile = new  File(this.getApplicationContext().getCacheDir(), path);
    // set bitmap to wallpaper
    Bitmap bitmap = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
    WallpaperManager wm = null;
    //if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
    wm = WallpaperManager.getInstance(this);
    // }
    try{
      // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
      wm.setBitmap(bitmap);
      //  }
      setWallpaper=0;
    }catch (IOException e){
      setWallpaper=1;
    }
    return setWallpaper;
  }

}
