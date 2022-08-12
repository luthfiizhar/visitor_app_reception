import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  Timer? _timer;
  int _timerCount = 5;

  @override
  void dispose() {
    _cameraController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![1]);
  }

  Future takePicture(MainModel model) async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      // startTimer();
      _timer = Timer(const Duration(seconds: 1), () async {
        // setState(() {});
        if (_timerCount == 0) {
          await _cameraController.setFlashMode(FlashMode.off);
          XFile picture = await _cameraController.takePicture();
          model.setPhotoFile(picture);
          print(picture.toString());
          Navigator.pop(context);
          return;
        } else {
          setState(() {});
          _timerCount--;
        }

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PreviewPage(
        //               picture: picture,
        //             )));
      });
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Consumer<MainModel>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: eerieBlack,
          body: SafeArea(
            child: Stack(children: [
              (_cameraController.value.isInitialized)
                  ? Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: CameraPreview(_cameraController)))
                  : Container(
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator())),
              IgnorePointer(
                child: ClipPath(
                  clipper: InvertedCircleClipper(),
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              ),
              FutureBuilder(
                future: takePicture(model),
                builder: (context, snapshot) {
                  return SizedBox();
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  _timerCount.toString(),
                  style: const TextStyle(fontSize: 82, color: Colors.white),
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     color: Color.fromARGB(103, 0, 0, 0),
              //     width: MediaQuery.of(context).size.width,
              //     height: 500,
              //     child: Container(
              //       height: 100,
              //       width: 100,
              //       decoration: BoxDecoration(color: Colors.transparent),
              //     ),
              //   ),
              // ),
              // Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       height: MediaQuery.of(context).size.height * 0.18,
              //       decoration: const BoxDecoration(
              //           borderRadius:
              //               BorderRadius.vertical(top: Radius.circular(24)),
              //           color: Colors.black),
              //       child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Expanded(
              //                 child: IconButton(
              //               padding: EdgeInsets.zero,
              //               iconSize: 30,
              //               icon: Icon(
              //                   _isRearCameraSelected
              //                       ? CupertinoIcons.switch_camera
              //                       : CupertinoIcons.switch_camera_solid,
              //                   color: Colors.white),
              //               onPressed: () {
              //                 setState(() =>
              //                     _isRearCameraSelected = !_isRearCameraSelected);
              //                 initCamera(
              //                     widget.cameras![_isRearCameraSelected ? 0 : 1]);
              //               },
              //             )),
              //             Expanded(
              //                 child: IconButton(
              //               onPressed: takePicture,
              //               iconSize: 50,
              //               padding: EdgeInsets.zero,
              //               constraints: const BoxConstraints(),
              //               icon: const Icon(Icons.circle, color: Colors.white),
              //             )),
              //             const Spacer(),
              //           ]),
              //     )),
            ]),
          ));
    });
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.4))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
