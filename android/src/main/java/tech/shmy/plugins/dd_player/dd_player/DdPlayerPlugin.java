package tech.shmy.plugins.dd_player.dd_player;

import android.app.Activity;
import android.app.PictureInPictureParams;
import android.content.Context;
import android.media.AudioManager;
import android.os.Build;
import android.util.Rational;
import android.view.Window;
import android.view.WindowManager;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DdPlayerPlugin
 */
public class DdPlayerPlugin implements MethodCallHandler {
    private Activity activity;
    private Context context;
    private static final String CHANNEL_NAME = "tech.shmy.plugins/dd_player/";
    private AudioManager mAudioManager;

    private DdPlayerPlugin(Activity activity, Context context) {
        this.activity = activity;
        this.context = context;
        this.mAudioManager = (AudioManager) this.context.getApplicationContext().getSystemService(Context.AUDIO_SERVICE);
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel methodChannel = new MethodChannel(registrar.messenger(), CHANNEL_NAME + "method_channel");
//        final EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL_NAME + "event_channel");
        final DdPlayerPlugin instance = new DdPlayerPlugin(registrar.activity(), registrar.context());
        methodChannel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("screen:setNormallyOn")) {
            this.setNormallyOn();
        } else if (call.method.equals("screen:unSetNormallyOn")) {
            this.unSetNormallyOn();
        } else if (call.method.equals("screen:getBrightness")) {
            result.success(this.getBrightness());
        } else if (call.method.equals("screen:incrementBrightness")) {
            result.success(this.incrementBrightness());
        } else if (call.method.equals("screen:decrementBrightness")) {
            result.success(this.decrementBrightness());
        } else if (call.method.equals("screen:enterPip")) {
            int numerator = call.argument("numerator");
            int denominator = call.argument("denominator");
            this.enterPip(numerator, denominator);
        } else if (call.method.equals("volume:getCurrentVolume")) {
            result.success(this.getCurrentVolume());
        } else if (call.method.equals("volume:getMaxVolume")) {
            result.success(this.getMaxVolume());
        } else if (call.method.equals("volume:incrementVolume")) {
            result.success(this.incrementVolume());
        } else if (call.method.equals("volume:decrementVolume")) {
            result.success(this.decrementVolume());
        } else {
            result.notImplemented();
        }
    }

    private void setNormallyOn() {
        Window window = this.activity.getWindow();
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }

    private void unSetNormallyOn() {
        Window window = this.activity.getWindow();
        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }

    private int getBrightness() {
        Window window = this.activity.getWindow();
        return (int) (window.getAttributes().screenBrightness * 100.0F);
    }

    private int incrementBrightness() {
        int val = this.getBrightness() + 5;
        if (val >= 100) {
            val = 100;
        }
        return this.setBrightness(val);
    }

    private int decrementBrightness() {
        int val = this.getBrightness() - 5;
        if (val <= 5) {
            val = 5;
        }
        return this.setBrightness(val);
    }

    private int setBrightness(int val) {
        Window window = this.activity.getWindow();
        WindowManager.LayoutParams localLayoutParams = window.getAttributes();
        localLayoutParams.screenBrightness = val / 100.0F;
        window.setAttributes(localLayoutParams);
        return val;
    }

    private int getCurrentVolume() {
        //当前音量
        return this.mAudioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
    }

    private int getMaxVolume() {
        return this.mAudioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
    }

    private int incrementVolume() {
        int maxVolume = this.getMaxVolume();
        if (this.getCurrentVolume() >= maxVolume) {
            return maxVolume;
        }
        this.mAudioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_RAISE, 0);
        return this.getCurrentVolume();
    }

    private int decrementVolume() {
        int minVolume = 0;
        if (this.getCurrentVolume() <= minVolume) {
            return minVolume;
        }
        this.mAudioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_LOWER, 0);
        return this.getCurrentVolume();
    }

    private void enterPip(int numerator, int denominator) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                System.out.println("-------------");
                System.out.println(numerator);
                System.out.println(denominator);

                // 如果有启动图 必须清除 否则Pip会有边框
                this.activity.getWindow().setBackgroundDrawable(null);
                PictureInPictureParams params = new PictureInPictureParams.Builder()
                        .setAspectRatio(new Rational(numerator, denominator)).build();
                this.activity.enterPictureInPictureMode(params);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}