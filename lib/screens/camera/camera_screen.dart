import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_camera.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:tuple/tuple.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  var imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = (size.width / size.height);

    return Scaffold(
      backgroundColor: ConstantsGraphics.COLOR_DIARY_BLUE,
      appBar: AppBar(
        // title: Text('Fotografa il referto',
        //     textAlign: TextAlign.left,
        //     style: TextStyle(
        //         fontSize: 35,
        //         color: Colors.black,
        //         fontWeight: FontWeight.w300)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: size.width * 0.15,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: size.width * 0.1,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return Transform.scale(
                      scale: _controller.value.aspectRatio / deviceRatio * 0.85,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: CameraPreview(_controller), //cameraPreview
                        ),
                      ));
                } else {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Otherwise, display a loading indicator.
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Center(
                    child: Icon(Icons.camera_alt,
                        color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                        size: size.width * 0.08)),
                // Provide an onPressed callback.
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Construct the path where the image should be saved using the
                    // pattern package.
                    final path = join(
                      // Store the picture in the temp directory.
                      // Find the temp directory using the `path_provider` plugin.
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );

                    // Attempt to take a picture and log where it's been saved.
                    await _controller.takePicture(path);

                    // If the picture was taken, display it on a new screen.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocCameraProvider(
                          child: DisplayPictureScreen(imagePath: path),
                        ),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //BlocCamera bloc = BlocCameraProvider.of(context);
    print(imagePath);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              )),
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.file(File(imagePath),
                      height: MediaQuery.of(context).size.height * 0.75)),
              RaisedButton(
                color: Color(0xff4768b7),
                elevation: 1.0,
                onPressed: () {
                  int count = 0;
                  //
                  // bloc.uploadOutcome.add(Tuple2<String, File>(
                  //   'TCeW2rTnWCdteupnMuq8',
                  //   File(imagePath),
                  // ));
                  // 
                  CameraFileManager.addFileImage(File(imagePath));
                  Navigator.of(context).popUntil((_) {
                    if(count++ >= 2){
                      return true;
                    } else return false;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Text('Salva',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FilsonSoft')),
              ),
            ],
          ),
        ));
  }
}
