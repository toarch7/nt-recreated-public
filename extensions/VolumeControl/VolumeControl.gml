#define _GetPickedFile
return GetExternalStorageDir() + "/_temp";

#define _FilePickerCleanup

if file_exists(GetExternalStorageDir() + "/_temp")
	file_delete(GetExternalStorageDir() + "/_temp");