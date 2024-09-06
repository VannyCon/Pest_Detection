import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PestDetailView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String information;
  final String solutionSteps;

  const PestDetailView({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.information,
    required this.solutionSteps,
  }) : super(key: key);

  @override
  _PestDetailViewState createState() => _PestDetailViewState();
}

class _PestDetailViewState extends State<PestDetailView> {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    // Set the language to Filipino (Tagalog)
    await flutterTts.setLanguage("fil-PH");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
  }

  Future<void> _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) {
      setState(() {
        isSpeaking = true;
      });
    }
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      setState(() {
        isSpeaking = false;
      });
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF172447),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: const Color(0xFF172447),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC4376),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    widget.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Information',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.information,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 16),
                    _buildPlayButton(widget.information),
                    const SizedBox(height: 16),
                    const Text(
                      'Solution',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    ...widget.solutionSteps
                        .split('\n')
                        .asMap()
                        .entries
                        .map((entry) {
                      int idx = entry.key + 1;
                      String step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$idx. ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Expanded(
                              child: Text(
                                step,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    _buildPlayButton(widget.solutionSteps),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton(String text) {
    return SizedBox(
      width: 120,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFEFF0FA),
          backgroundColor: isSpeaking
              ? const Color(0xFFEC4376) // Change color when speaking
              : const Color(0xFF43D3EC), // Default color when not speaking
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSpeaking
                  ? Icons.stop
                  : Icons.volume_up, // Toggle between stop and play icons
              size: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 5),
            Text(
              isSpeaking
                  ? 'Stop'
                  : 'Play', // Toggle between "Stop" and "Play" text
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
        onPressed: () {
          if (isSpeaking) {
            _stop(); // Stop the speech if currently speaking
          } else {
            _speak(text); // Start the speech if not speaking
          }
        },
      ),
    );
  }
}
