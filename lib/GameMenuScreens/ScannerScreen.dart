import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Interpreter? _interpreter;
  bool _modelLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      print('Model loaded successfully');
      print('Input shape: ${_interpreter!.getInputTensor(0).shape}');
      print('Output shape: ${_interpreter!.getOutputTensor(0).shape}');
      setState(() {
        _modelLoaded = true;
      });
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<void> _scanBottle() async {
    if (!_modelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Model not loaded yet. Please wait.')),
      );
      return;
    }

    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        File imageFile = File(image.path);
        var result = await classifyImage(imageFile);
        int reward = Random().nextInt(7) + 1; // Random reward between 1 and 7

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Bottle Scanned'),
            content: Text('Bottle is $result. You earned $reward lives!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(reward); // Return to previous screen with reward
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error in _scanBottle: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning bottle: $e')),
      );
    }
  }

  Future<String> classifyImage(File imageFile) async {
    var image = img.decodeImage(imageFile.readAsBytesSync())!;
    image = img.copyResize(image, width: 64, height: 64);
    var input = Float32List(1 * 64 * 64 * 3);
    var inputIndex = 0;
    
    for (var y = 0; y < 64; y++) {
      for (var x = 0; x < 64; x++) {
        var pixel = image.getPixel(x, y);
        input[inputIndex++] = img.getRed(pixel) / 255.0;
        input[inputIndex++] = img.getGreen(pixel) / 255.0;
        input[inputIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    var inputShape = [1, 64, 64, 3];
    var outputShape = [1, 3];

    try {
      var outputs = List.filled(1 * 3, 0.0).reshape(outputShape);
      _interpreter!.run(input.reshape(inputShape), outputs);

      var result = outputs[0] as List<double>;
      var maxIndex = result.indexOf(result.reduce((a, b) => a > b ? a : b));
      
      switch (maxIndex) {
        case 0: return 'Empty';
        case 1: return 'Half Full';
        case 2: return 'Full/Overflowing';
        default: return 'Unknown';
      }
    } catch (e) {
      print('Error running model inference: $e');
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottle Scanner')),
      body: Center(
        child: ElevatedButton(
          child: Text('Scan Bottle'),
          onPressed: _scanBottle,
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