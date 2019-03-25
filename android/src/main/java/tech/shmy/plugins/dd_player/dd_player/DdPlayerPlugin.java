package tech.shmy.plugins.dd_player.dd_player;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import org.fourthline.cling.android.AndroidUpnpService;
import org.fourthline.cling.android.AndroidUpnpServiceImpl;
import org.fourthline.cling.model.action.ActionInvocation;
import org.fourthline.cling.model.message.UpnpResponse;
import org.fourthline.cling.model.meta.Service;
import org.fourthline.cling.support.avtransport.callback.Play;
import org.fourthline.cling.support.avtransport.callback.SetAVTransportURI;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

/** DdPlayerPlugin */
public class DdPlayerPlugin implements MethodCallHandler, StreamHandler {
  private boolean isSearchStrarted = false;
  private Activity activity;
  private Context context;
  private BrowseRegistryListener browseRegistryListener = new BrowseRegistryListener();
  private AndroidUpnpService androidUpnpService;
  private static final String CHANNEL_NAME = "tech.shmy.plugins/dd_player/";
  private ServiceConnection serviceConnection = null;
  private DdPlayerPlugin(Activity activity, Context context) {
    this.activity = activity;
    this.context = context;
  }
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel methodChannel = new MethodChannel(registrar.messenger(), CHANNEL_NAME + "method_channel");
    final EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL_NAME + "event_channel");
    final DdPlayerPlugin instance = new DdPlayerPlugin(registrar.activity(), registrar.context());
    methodChannel.setMethodCallHandler(instance);
    eventChannel.setStreamHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("dlna:search")) {
      this.search();
    } else if (call.method.equals("dlna:stop")) {
      this.stop();
    } else if (call.method.equals("dlna:playUrl")) {
      String url = Objects.requireNonNull(call.argument("url")).toString();
      String uuid = Objects.requireNonNull(call.argument("uuid")).toString();
      this.playUrl(uuid, url);
    } else if (call.method.equals("dlna:getList")) {
      result.success(browseRegistryListener.getDevices());
    } else {
      result.notImplemented();
    }
  }
  @Override
  public void onListen(Object arguments, EventSink events) {
    BrowseRegistryListener.eventSink = events;
  }
  @Override
  public void onCancel(Object arguments) {
    System.out.println("-- onCancel -----");
    BrowseRegistryListener.eventSink = null;
    this.stop();
  }

  private void search() {
    if (isSearchStrarted) {
      return;
    }
    System.out.println("-- start ---serviceConnection-----");
    serviceConnection = new ServiceConnection() {

      @Override
      public void onServiceConnected(ComponentName name, IBinder service) {
        androidUpnpService = (AndroidUpnpService) service;
        System.out.println("---got a androidUpnpService-----");
        androidUpnpService.getRegistry().addListener(browseRegistryListener);
        androidUpnpService.getControlPoint().search();
      }

      @Override
      public void onServiceDisconnected(ComponentName name) {
        System.out.println(name);
      }
    };
    isSearchStrarted = this.context.getApplicationContext().bindService(new Intent(this.activity, AndroidUpnpServiceImpl.class),
            serviceConnection, Context.BIND_AUTO_CREATE);
  }
  private void playUrl(String uuid, String url) {
    final DdPlayerPlugin c = this;
    final Service avtService = browseRegistryListener.getDeviceForUuid(uuid);
    androidUpnpService.getControlPoint().execute(new SetAVTransportURI(avtService, url) {
      @Override
      public void success(ActionInvocation invocation) {
        System.out.println("setUrl success:--defaultMsg--" + invocation.toString());
        c.doPlay(avtService);
      }
      @Override
      public void failure(ActionInvocation invocation, UpnpResponse operation, String defaultMsg) {
        System.out.println("setUrl err --defaultMsg--" + defaultMsg);
      }
    });

    System.out.println(url);
  }
  private void stop() {
    if (serviceConnection != null) {
      System.out.println("---stop service---");
      this.context.getApplicationContext().unbindService(serviceConnection);
      serviceConnection = null;
      isSearchStrarted = false;
    }
  }
  private void doPlay(Service avtService) {
    androidUpnpService.getControlPoint().execute(new Play(avtService) {
      @Override
      public void success(ActionInvocation invocation) {
        System.out.println("play success:--defaultMsg--" + invocation.toString());
      }
      @Override
      public void failure(ActionInvocation invocation, UpnpResponse operation, String defaultMsg) {
        System.out.println("play err:--defaultMsg--" + defaultMsg);
      }
    });
  }
}
