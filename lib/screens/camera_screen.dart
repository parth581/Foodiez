import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraReady = false;
  bool _isUploading = false;
  XFile? _capturedImage;
  double _rating = 3.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() => _isCameraReady = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() => _capturedImage = image);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking picture: $e')),
      );
    }
  }

  Future<void> _retakePicture() async {
    setState(() => _capturedImage = null);
  }

  Future<void> _uploadReview() async {
    if (_capturedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a picture first')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref()
          .child('reviews')
          .child('${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      await storageRef.putFile(File(_capturedImage!.path));
      final imageUrl = await storageRef.getDownloadURL();

      // Save review data to Firestore
      await FirebaseFirestore.instance.collection('reviews').add({
        'userId': user.uid,
        'userEmail': user.email,
        'userName': user.displayName,
        'imageUrl': imageUrl,
        'rating': _rating,
        'reviewText': _reviewController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted successfully!')),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting review: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isUploading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share your experience',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Take a photo of your food and rate your experience',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  
                  // Camera Preview or Captured Image
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _capturedImage == null
                        ? FutureBuilder<void>(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CameraPreview(_controller),
                                );
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            },
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_capturedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Camera Controls
                  if (_capturedImage == null)
                    Center(
                      child: FloatingActionButton(
                        onPressed: _takePicture,
                        backgroundColor: const Color(0xFF00BFA6),
                        child: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _retakePicture,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retake'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check),
                          label: const Text('Use Photo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFA6),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'Rate your order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, 
                          color: _rating >= 1 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, 
                          color: _rating >= 2 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, 
                          color: _rating >= 3 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, 
                          color: _rating >= 4 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, 
                          color: _rating >= 5 ? Colors.amber : Colors.grey),
                      const SizedBox(width: 8),
                      Text(_rating.toStringAsFixed(1)),
                    ],
                  ),
                  Slider(
                    value: _rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    onChanged: (value) {
                      setState(() => _rating = value);
                    },
                    activeColor: const Color(0xFF00BFA6),
                  ),
                  
                  const SizedBox(height: 24),
                  const Text(
                    'Write a review (optional)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                      hintText: 'How was your food? Any comments?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _uploadReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFA6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Submit Review'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}