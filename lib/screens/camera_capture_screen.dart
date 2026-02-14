import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; 

class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool isVideoMode = true;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    
    final cameras = await availableCameras();
    
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller!),
                Column(
                  children: [
                    const Spacer(),
                    Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
                    const Spacer(),
                    Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    VerticalDivider(color: Colors.white.withOpacity(0.3), thickness: 1),
                    const Spacer(),
                    VerticalDivider(color: Colors.white.withOpacity(0.3), thickness: 1),
                    const Spacer(),
                  ],
                ),
                _buildInterface(),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFF6D3B)));
          }
        },
      ),
    );
  }

  Widget _buildInterface() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                _buildCircleButton(Icons.flash_on, () {}),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Captura evidencia clara de la pesca\nilegal",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.greenAccent, size: 14),
                const SizedBox(width: 4),
                const Text("Ubicación: Activa", style: TextStyle(color: Colors.white, fontSize: 12)),
                Container(height: 12, width: 1, color: Colors.white30, margin: const EdgeInsets.symmetric(horizontal: 10)),
                const Icon(Icons.signal_cellular_connected_no_internet_4_bar, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
                const Text("SIN SEÑAL", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const Spacer(),

          if (isVideoMode) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                _buildTimerText("00", "MIN"),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Text(":", style: TextStyle(color: Color(0xFFFF6D3B), fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _buildTimerText("15", "SEG"),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 120, height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              child: Row(
                children: [
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFFF6D3B), borderRadius: BorderRadius.circular(2))),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModeChip("FOTO", !isVideoMode),
                _buildModeChip("VIDEO", isVideoMode),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Galería
                Container(
                  width: 45, height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.grey,
                  ),
                  child: const Icon(Icons.photo, color: Colors.white, size: 20),
                ),

                GestureDetector(
                  onTap: () {
                     print("Capturando...");
                  },
                  child: Container(
                    width: 80, height: 80,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xFFFF6D3B), shape: BoxShape.circle),
                      child: Center(
                        child: isVideoMode 
                          ? Container(width: 24, height: 24, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)))
                          : null,
                      ),
                    ),
                  ),
                ),

                // Switch Camera
                GestureDetector(
                   onTap: () {
                   },
                   child: Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.flip_camera_ios_outlined, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildTimerText(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFFFF6D3B).withOpacity(0.2), shape: BoxShape.circle),
          child: Text(value, style: const TextStyle(color: Color(0xFFFF6D3B), fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildModeChip(String text, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isVideoMode = text == "VIDEO";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF6D3B) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if(text == "VIDEO" && isActive) const Padding(padding: EdgeInsets.only(right: 6), child: Icon(Icons.videocam, size: 16, color: Colors.white)),
            if(text == "FOTO" && isActive) const Padding(padding: EdgeInsets.only(right: 6), child: Icon(Icons.camera_alt, size: 16, color: Colors.white)),
            Text(text, style: TextStyle(color: isActive ? Colors.white : Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}