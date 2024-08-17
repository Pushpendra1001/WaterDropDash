import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class BottleScannerGame extends StatefulWidget {
  @override
  _BottleScannerGameState createState() => _BottleScannerGameState();
}

class _BottleScannerGameState extends State<BottleScannerGame> {
  Interpreter? _interpreter;
  bool _modelLoaded = false;
  int _lives = 0;
  String _result = '';
  final List<String> _categories = ['Beer Bottles', 'Plastic Bottles', 'Soda Bottle', 'Water Bottle', 'Wine Bottle'];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/bottle_classification_model.tflite');
      setState(() {
        _modelLoaded = true;
      });
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

 Future<void> _scanBottle() async {
  if (!_modelLoaded) {
    setState(() {
      _result = 'Model not loaded yet. Please wait.';
    });
    return;
  }

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  
  if (image != null) {
    File imageFile = File(image.path);
    var result = await classifyImage(imageFile);
    int newLives = _calculateLives(result.cast<String, double>());
    
    setState(() {
      _lives += newLives;
      if (result.containsKey('Invalid')) {
        _result = 'Invalid image or low confidence detection.';
      } else {
        String detectedBottle = result.keys.first;
        _result = 'Detected: $detectedBottle\nConfidence: ${(result[detectedBottle]! * 100).toStringAsFixed(2)}%';
        if (newLives > 0) {
          _result += '\nYou earned $newLives lives!';
        } else {
          _result += '\nNo lives earned.';
        }
      }
    });
  }
}

  
Future<Map<String, dynamic>> classifyImage(File imageFile) async {
  
  Uint8List imageBytes = await imageFile.readAsBytes();
  
  
  final ui.Image image = await decodeImageFromList(imageBytes);
  
  
  final scaledImage = await createResizedImage(image, 224, 224);
  
  
  ByteData? byteData = await scaledImage.toByteData(format: ui.ImageByteFormat.rawRgba);
  Uint8List uint8List = byteData!.buffer.asUint8List();

  
  var input = List.filled(1 * 224 * 224 * 3, 0.0);
  int pixelIndex = 0;
  for (int i = 0; i < uint8List.length; i += 4) {
    input[pixelIndex] = uint8List[i] / 255.0;     
    input[pixelIndex + 1] = uint8List[i + 1] / 255.0; 
    input[pixelIndex + 2] = uint8List[i + 2] / 255.0; 
    pixelIndex += 3;
  }

   var output = List.filled(1 * _categories.length, 0.0).reshape([1, _categories.length]);

  
  _interpreter!.run(input.reshape([1, 224, 224, 3]), output);

  
  var result = Map.fromIterables(_categories, output[0]);
  
  
  var highConfidenceCategory = result.entries.firstWhere(
    (entry) => entry.value >= 0.70,
    orElse: () => MapEntry('Invalid', 0.0)
  );

  
  if (highConfidenceCategory.key != 'Invalid') {
    return {highConfidenceCategory.key: highConfidenceCategory.value};
  } else {
    return {'Invalid': 0.0};
  }
}

Future<ui.Image> createResizedImage(ui.Image image, int width, int height) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  
  canvas.drawImageRect(
    image,
    Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
    Rect.fromLTRB(0, 0, width.toDouble(), height.toDouble()),
    Paint(),
  );

  final ui.Picture picture = pictureRecorder.endRecording();
  return await picture.toImage(width, height);
}

int _calculateLives(Map<String, double> result) {
  if (result.containsKey('Invalid')) return 0;

  String category = result.keys.first; 
  
  switch (category) {
    case 'Beer Bottles':
    case 'Wine Bottle':
      return 0;
    case 'Soda Bottle':
      return 1;
    case 'Plastic Bottles':
      return Random().nextInt(2) + 2; 
    case 'Water Bottle':
      return Random().nextInt(3) + 4; 
    default:
      return 0;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottle Scanner Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lives: $_lives', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBottle,
              child: Text('Scan Bottle'),
            ),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}