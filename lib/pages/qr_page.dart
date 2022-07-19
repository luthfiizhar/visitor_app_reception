import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // late List<CameraDescription> cameras;
  // late CameraController controller;
  // bool _isReady = false;

  @override
  void initState() {
    // TODO: implement initState

    // _setupCameras();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  // Future<void> _setupCameras() async {
  //   try {
  //     // initialize cameras.
  //     cameras = await availableCameras();
  //     // initialize camera controllers.
  //     controller = new CameraController(cameras[1], ResolutionPreset.medium);
  //     await controller.initialize();
  //   } on CameraException catch (_) {
  //     // do something on error.
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _isReady = true;
  //   });
  // }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    await controller.flipCamera();

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 700.0;
    // if (!_isReady) {
    //   return Container();
    // }
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100), child: CustAppBar()),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: silver,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
    // Scaffold(
    // appBar: PreferredSize(
    //   preferredSize: Size.fromHeight(100),
    //   child: AppBar(
    //     automaticallyImplyLeading: false, // hides leading widget
    //     // flexibleSpace: SomeWidget(),
    //     // iconTheme: IconThemeData(
    //     //     color: Color(0xFFA80038), size: 32 //change your color here
    //     //     ),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //     flexibleSpace: Padding(
    //       padding: const EdgeInsets.only(top: 38, left: 38),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           IconButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               icon: Icon(
    //                 Icons.arrow_back_outlined,
    //                 size: 42,
    //                 color: redRose,
    //               )),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    //   body: Column(
    //     children: [
    //       CameraPreview(controller,
    //           child: Opacity(
    //             opacity: 0.3,
    //             child: new Image.network(
    //               'https://picsum.photos/3000/4000',
    //               fit: BoxFit.fill,
    //             ),
    //           ))
    //       // Container(
    //       //     child: Stack(
    //       //   alignment: FractionalOffset.center,
    //       //   children: <Widget>[
    //       //     new Positioned.fill(
    //       //       child: new AspectRatio(
    //       //           aspectRatio: controller.value.aspectRatio,
    //       //           child: Container(
    //       //               height: 800,
    //       //               width: 300,
    //       //               child: new CameraPreview(controller))),
    //       //     ),
    //       //     new Positioned.fill(
    //       //       child: new Opacity(
    //       //         opacity: 0.3,
    //       //         child: new Image.network(
    //       //           'https://picsum.photos/3000/4000',
    //       //           fit: BoxFit.fill,
    //       //         ),
    //       //       ),
    //       //     ),
    //       //   ],
    //       // )),
    //     ],
    //   ),
    // );
    // return Scaffold(
    //   appBar: AppBar(
    //     iconTheme: IconThemeData(
    //         color: Color(0xFFA80038), size: 32 //change your color here
    //         ),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //   ),
    //   body: Stack(
    //     alignment: FractionalOffset.center,
    //     children: <Widget>[
    //       new Positioned.fill(
    //         child: new AspectRatio(
    //             aspectRatio: controller.value.aspectRatio,
    //             child: new CameraPreview(controller)),
    //       ),
    //       new Positioned.fill(
    //         child: new Opacity(
    //           opacity: 0.3,
    //           child: new Image.network(
    //             'https://picsum.photos/3000/4000',
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}