package ${YYAndroidPackageName};

// Basic imports
import java.lang.String;
import java.lang.Object;
// Unzip
import java.io.*;
import java.nio.file.*;

// Android
import android.util.Log;
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.os.Environment;
import android.content.ContentResolver;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.View;
import android.os.AsyncTask;
import android.net.Uri;

// Import Game Maker classes
import ${YYAndroidPackageName}.R;
import ${YYAndroidPackageName}.RunnerActivity;
import com.yoyogames.runner.RunnerJNILib;

import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

// Android (fancy stuff)
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.widget.EditText;
import android.text.InputType;
import android.content.DialogInterface;
import android.view.ViewGroup.LayoutParams;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.text.ClipboardManager;
import androidx.core.content.ContextCompat;
import androidx.core.app.ActivityCompat;
import android.provider.Settings;
import android.content.pm.PackageManager;
import android.content.ContentResolver;




public class YYExtra extends ExtensionBase {
	private static final int EVENT_OTHER_SOCIAL = 70;
	private static final int FILE_SELECT_CODE = 42;
	public static String unzipFirstEntry = "";
	public double volumeControl = 0.0;
	Context ctx;

	public void onStart() {
		ctx = RunnerActivity.CurrentActivity.getBaseContext();
	}
	
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
		if (android.os.Build.VERSION.SDK_INT >= 19)
			return 1.0;
		
		return 0.0;
	}

	public double IsVersionR() {
		if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R)
			return 1.0;

		return 0.0;
	}
	
	public double SetClipboard(String text) {
		ClipboardManager clipboard = (ClipboardManager) RunnerActivity.CurrentActivity.getSystemService(Context.CLIPBOARD_SERVICE); 
		clipboard.setText(text);
		
		Log.i("yoyo", "Set clipboard text to " + text);
		
		return 0.0;
	}
	
	public double CheckPermission() {
		if (IsVersionR() > 0.0) {
			if (Environment.isExternalStorageManager())
				return 1.0;
		}
		else {
			int result = ContextCompat.checkSelfPermission(ctx, "READ_EXTERNAL_STORAGE");
			int result1 = ContextCompat.checkSelfPermission(ctx, "WRITE_EXTERNAL_STORAGE");

			if (result == PackageManager.PERMISSION_GRANTED && result1 == PackageManager.PERMISSION_GRANTED)
				return 1.0;
		}

		return 0.0;
	}
	
	public double RequestPermission() {
		if (IsVersionR() > 0.0) {
			try {
				Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
				intent.addCategory("android.intent.category.DEFAULT");
				intent.setData(Uri.parse(String.format("package:%s", ctx.getPackageName())));

				RunnerActivity.CurrentActivity.startActivityForResult(intent, 2296);
			}
			catch (Exception e) {
				Intent intent = new Intent();
				intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);

				RunnerActivity.CurrentActivity.startActivityForResult(intent, 2296);
			}
		}

		return 0.0;
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == 2296) {
			if (IsVersionR() > 0.0) {
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);

				RunnerJNILib.DsMapAddString( dsMapIndex, "type", "permissionStatus" );
				RunnerJNILib.DsMapAddDouble( dsMapIndex, "resultCode", resultCode );
				
				if (Environment.isExternalStorageManager()) {
					RunnerJNILib.DsMapAddDouble( dsMapIndex, "success", 1.0 );
				}
				else RunnerJNILib.DsMapAddDouble( dsMapIndex, "success", 0.0 );

				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
			}
		}
		else if (requestCode == 48) {
			ContentResolver contentResolver = ctx.getContentResolver();

			int flags = Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION;
			Uri uri = data.getData();

			int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);

			RunnerJNILib.DsMapAddString( dsMapIndex, "type", "documentTreeIntent" );
			RunnerJNILib.DsMapAddString( dsMapIndex, "path", uri.getPath().split(":")[1] );

			try {
				contentResolver.takePersistableUriPermission(uri, flags);
				RunnerJNILib.DsMapAddDouble( dsMapIndex, "permitted", 1.0 );
			}
			catch(Exception e) {
				RunnerJNILib.DsMapAddDouble( dsMapIndex, "permitted", 0.0 );
			}
			
			RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
		}
	}

	public double OpenDirectoryTree() {
		Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
		intent.addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
		intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);


		RunnerActivity.CurrentActivity.startActivityForResult(intent, 48);

		return 0.0;
	}







	public double ResourcepackInstall(String path, String dest) {
		YYExtra.unzipFirstEntry = "";
		UnzipTask unzipTask = new UnzipTask();
		unzipTask.execute(path, dest);

		return 0.0;
	}

	public static void resourcepackFinish(String dest) {
		//
	}

	public static Boolean unzipFile(String zipFilePath, String destinationFolderPath, Boolean recusive) {
		try {
			ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(zipFilePath));

			ZipEntry zipEntry;
			
			byte[] buffer = new byte[1024];

			while ((zipEntry = zipInputStream.getNextEntry()) != null) {
				String entryName = zipEntry.getName();
				String entryFilename = entryName.substring(entryName.lastIndexOf("/") + 1);

				if (entryFilename.startsWith(".")) {
					zipInputStream.closeEntry();
					continue;
				}


				File entryFile = new File(destinationFolderPath, entryName);
				
				if (YYExtra.unzipFirstEntry.equals(""))
					YYExtra.unzipFirstEntry = entryFile.getPath();

				if (!zipEntry.isDirectory()) {
					BufferedOutputStream outputStream = new BufferedOutputStream(new FileOutputStream(entryFile));
					int count;
					
					while ((count = zipInputStream.read(buffer)) != -1) {
						outputStream.write(buffer, 0, count);
					}
					
					outputStream.close();
				}
				else {
					entryFile.mkdirs();
				}

				if (entryFile.getName().endsWith(".zip")) {
					String dest = entryFile.getName().replace(".zip", "");
					String src = entryFile.getPath().replace(entryFile.getName(), "");

					File destFile = new File(src + dest);

					if (!destFile.exists())
						destFile.mkdir();

					YYExtra.unzipFile(entryFile.getPath(), src, false);

					entryFile.delete();
				}


				zipInputStream.closeEntry();
			}

			zipInputStream.close();
		}
		catch (IOException e) {
			Log.e("yoyo", "Error unzipping file: " + e.getMessage());

			return false;
		}

		return true;
	}

	private class UnzipTask extends AsyncTask<String, Void, Boolean> {
		@Override
		protected Boolean doInBackground(String... params) {
			String zipFilePath = params[0];
			String destinationFolderPath = params[1];

			if (!unzipFile(zipFilePath, destinationFolderPath, true))
				return false;
			
			File zipFile = new File(zipFilePath);

			if (zipFile.exists())
				zipFile.delete();

			return true;
		}

		@Override
		protected void onPostExecute(Boolean result) {
			double status = result ? 1.0 : 0.0;

			int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
			RunnerJNILib.DsMapAddString( dsMapIndex, "type", "unzip" );
			RunnerJNILib.DsMapAddString( dsMapIndex, "entry", YYExtra.unzipFirstEntry );
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "status", status );
			RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
		}
	}
}
