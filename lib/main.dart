import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pest_detection/data/data.dart';
import 'package:pest_detection/view/solution.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the camera
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ObjectDetectionScreen(camera: camera),
    );
  }
}

class ObjectDetectionScreen extends StatefulWidget {
  final CameraDescription camera;
  const ObjectDetectionScreen({super.key, required this.camera});

  @override
  _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? _image;
  File? _imageFile;
  bool _isCameraInitialized = false;
  bool _isInitializing = false;
  bool _isDetecting = false;
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    loadModel();
  }

  @override
  void dispose() {
    if (_isCameraInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _startCamera() async {
    setState(() {
      _isInitializing = true;
      _isDetecting = true;
    });

    // Check if camera permission is granted
    if (await Permission.camera.request().isGranted) {
      try {
        if (_isCameraInitialized) {
          await _controller.dispose();
        }

        _controller = CameraController(widget.camera, ResolutionPreset.high);
        _initializeControllerFuture = _controller.initialize();
        await _initializeControllerFuture;

        setState(() {
          _isCameraInitialized = true;
          _isInitializing = false;
          _isDetecting = false;
        });
      } catch (e) {
        print('Error initializing camera: $e');
        setState(() {
          _isInitializing = false;
          _isDetecting = false;
        });
      }
    } else {
      // Handle permission not granted
      setState(() {
        _isInitializing = false;
      });
      // Optionally show a message to the user
      print('Camera permission not granted');
    }
  }

  Future<void> _captureImage() async {
    if (!_isCameraInitialized) return;

    try {
      final image = await _controller.takePicture();
      setState(() {
        _image = image;
        _imageFile = File(image.path);
      });

      // Stop the camera
      await _controller.dispose();
      setState(() {
        _isCameraInitialized = false;
      });

      // Start object detection
      detectImage(_imageFile!);
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    String label = recognitions != null && recognitions.isNotEmpty
        ? recognitions[0]["label"]
        : "No label detected";

    // Remove numbers from the label
    String labelWithoutNumbers = label.replaceAll(RegExp(r'\d'), '');
    String imagePath = "assests/$labelWithoutNumbers" + ".png";

    _showResultDialog(labelWithoutNumbers, imagePath);
  }

  void _showResultDialog(String label, String imagePath) {
    String labelWithoutNumbers = label.replaceAll(RegExp(r'\d'), '');
    PestInfo pestInfo = PestDescriptions.getPestInfo(labelWithoutNumbers);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFF272F43),
          // ... (keep the existing Dialog setup)
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // ... (keep the existing Container setup)
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Detected",
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 233, 234),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ... (keep the existing top part of the dialog)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      pestInfo.imagePath,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    pestInfo.name.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFFE11D48),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ... (keep the existing buttons)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFFEFF0FA),
                              backgroundColor: Color.fromARGB(255, 61, 238, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Solution',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PestDetailView(
                                    title: pestInfo.name,
                                    imageUrl: pestInfo.imagePath,
                                    information: pestInfo.information,
                                    solutionSteps: pestInfo.solution,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Cancel deletion
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 236, 231, 232),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF172447),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              widthFactor: double.infinity,
              child: Image.asset(
                'assets/icon.png',
                height: 100,
                width: 100,
              ),
            ),
            if (_isCameraInitialized)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.white, // Border color
                      //     width: 3, // Border width
                      //   ),
                      //   borderRadius: BorderRadius.circular(
                      //       10), // Border radius for the rounded corners
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            5), // Ensure this matches the Container's border radius
                        child: CameraPreview(_controller),
                      ),
                      width: double.infinity,
                      height: 550,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isCameraInitialized ? _captureImage : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFEFF0FA),
                          backgroundColor: Color(0xFFEC4376),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Capture',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isCameraInitialized = false;
                        _isInitializing = false;
                        _isDetecting = false;
                      });
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFEC4376),
                      ),
                    ),
                  ),
                ],
              )
            else
              isWaiting()
          ],
        ),
      ),
    );
  }

  Column isWaiting() {
    return Column(
      children: [
        Column(
          children: [
            Center(
              child: const Text(
                'Start Camera then Capture to Start Detection',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plants',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1. Click Start \n2. Place the Camera to Pest \n3. Click Detect \n4. To Know More Click Solution Button',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isInitializing ? null : _startCamera,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFEFF0FA),
                    backgroundColor: Color(0xFF43D3EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
