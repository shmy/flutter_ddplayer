package tech.shmy.plugins.dd_player.dd_player_example;

import tech.shmy.plugins.dd_player.dd_player.*;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }

  @Override
  public void onPictureInPictureModeChanged(boolean isInPictureInPictureMode) {
    System.out.println("----onPictureInPictureModeChanged---");
    System.out.println(isInPictureInPictureMode);
    System.out.println(BrowseRegistryListener.eventSink);
  }

}
