import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'splashscreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<PermissionStatus> _permissionStatus;

  @override
  void initState() {
    super.initState();
    _permissionStatus = requestCameraPermission();
  }

  Future<PermissionStatus> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<PermissionStatus>(
        future: _permissionStatus,
        builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the permission status is being checked.
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == PermissionStatus.denied || snapshot.data == PermissionStatus.permanentlyDenied) {
              // Exit the app if the user denies or permanently denies camera permission.
              WidgetsBinding.instance!.addPostFrameCallback((_) => exit(0));
              return const SizedBox();
            } else {
              // Show the splash screen if the camera permission is granted or restricted.
              return const splashscreen();
            }
          }
        },
      ),
    );
  }
}
