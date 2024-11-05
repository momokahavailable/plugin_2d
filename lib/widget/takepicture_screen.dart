import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plugin_2d/widget/displaypicture_screen.dart';

class TakepictureScreen extends StatefulWidget {
  const TakepictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakepictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text('Take a picture - 000123123123')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
             return CameraPreview(_controller);
           } else {
             return const Center(child: CircularProgressIndicator());
           }
         }),

        floatingActionButton: FloatingActionButton(
          onPressed:() async{
            try{
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
            } catch(e) {
              print(e);
            }

          },

          child: const Icon(Icons.camera_alt),

          )
    );
}
}