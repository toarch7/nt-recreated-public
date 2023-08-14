package ${YYAndroidPackageName};

// Basic imports
import android.util.Log;
import java.lang.String;
import java.lang.Object;
import android.net.Uri;
import java.io.*;
import java.nio.file.*;

// Android
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.os.Environment;
import android.content.ContentResolver;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.View;

// Import Game Maker classes
import ${YYAndroidPackageName}.R;
import ${YYAndroidPackageName}.RunnerActivity;
import com.yoyogames.runner.RunnerJNILib;

// Android
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.widget.EditText;
import android.text.InputType;
import android.content.DialogInterface;
import android.view.ViewGroup.LayoutParams;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;


public class YYExtra extends ExtensionBase {
	private static final int EVENT_OTHER_SOCIAL = 70;
	private static final int FILE_SELECT_CODE = 42;
	public double volumeControl = 0.0;
	
	public double SetVolumeControl( double val ) {
		Log.i("yoyo", "Set volume control to " + val);
		return volumeControl = val;
	}
	
	public boolean onKeyDown( int keyCode, KeyEvent event ) {
		if (volumeControl < 1.0)
			return false;
		
		String type = "";

		if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
			type = "up";
		} else if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
			type = "down";
		}
		else return false;
		
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "volumeButtonPressed" );
		RunnerJNILib.DsMapAddString( dsMapIndex, "volume", type );

		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);

		return true;
	}
	
	public boolean onKeyUp( int keyCode, KeyEvent event ) {
		if (volumeControl < 1.0)
			return false;
		
		String type = "";

		if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
			type = "up";
		}
		else if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
			type = "down";
		}
		else return false;
		
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "volumeButtonReleased" );
		RunnerJNILib.DsMapAddString( dsMapIndex, "volume", type );

		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);

		return true;
	}

	public double IsKitKat() {
		if (android.os.Build.VERSION.SDK_INT >= 19) {
			return 1.0;
		}
		
		return 0.0;
	}
}
