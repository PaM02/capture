  ajouter ça dans yaml
  image_picker: ^0.8.5+3
  copier ces script dans ios/Runner/info.plist
<key>NSCameraUsageDescription</key>
<string>hello app camera description.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>hello app photos description.</string>
<key>NSMicrophoneUsageDescription</key>
<string>hello app photos description.</string>

ajouter ces scripts dans AndroidManifets.xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />

