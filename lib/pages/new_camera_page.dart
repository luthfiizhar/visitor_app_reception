import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/orientations.dart';
import 'package:flutter/material.dart';

class NewCameraPage extends StatefulWidget {
  const NewCameraPage({Key? key}) : super(key: key);

  @override
  State<NewCameraPage> createState() => _NewCameraPageState();
}

class _NewCameraPageState extends State<NewCameraPage> {
  // Notifiers
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.FRONT);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<Size> _photoSize = ValueNotifier(Size.zero);
  ValueNotifier<double> _zoomNotifier = ValueNotifier(0);

  // Controllers
  PictureController _pictureController = new PictureController();
  VideoController _videoController = new VideoController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: CameraAwesome(
                  testMode: false,
                  onPermissionsResult: (bool? result) {},
                  selectDefaultSize: (List<Size> availableSizes) =>
                      Size(1920, 1080),
                  onCameraStarted: () {},
                  onOrientationChanged: (CameraOrientations? newOrientation) {},
                  zoom: _zoomNotifier,
                  sensor: _sensor,
                  photoSize: _photoSize,
                  switchFlashMode: _switchFlash,
                  captureMode: _captureMode,
                  fitted: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
