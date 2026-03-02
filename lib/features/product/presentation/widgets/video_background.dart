import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoBackground extends StatefulWidget {
  const VideoBackground({super.key});

  @override
  State<VideoBackground> createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late YoutubePlayerController _youtubeController;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeYouTube();
  }

  void _initializeYouTube() {
    const String videoUrl = 'https://youtu.be/wopPRfeeCeQ?si=Dl5kdr7eZQOykixH';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        loop: true,
        disableDragSeek: true,
        hideControls: false, // Changed to false - important!
        controlsVisibleAtStart: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(_listener);

    // Force play after a short delay to ensure initialization
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _youtubeController.play();
      }
    });
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _youtubeController.removeListener(_listener);
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height * 0.32;

    return SizedBox(
      height: containerHeight,
      child: Stack(
        children: [
          /// 🎥 CLIPPED YOUTUBE VIDEO BACKGROUND
          ClipRRect(
            child: SizedBox(
              height: containerHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  /// 🎥 YOUTUBE PLAYER
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 16 * 100, // Increased size for better rendering
                        height: 9 * 100,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: false,
                          progressIndicatorColor: Colors.transparent,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.transparent,
                            handleColor: Colors.transparent,
                            bufferedColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                          ),
                          onReady: () {
                            _isPlayerReady = true;
                            _youtubeController.play();
                          },
                          onEnded: (metaData) {
                            _youtubeController.seekTo(Duration.zero);
                            _youtubeController.play();
                          },
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: containerHeight * 0.75,
                    height: containerHeight * 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.6, 1.0],
                          colors: [
                            Theme.of(
                              context,
                            ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                            Theme.of(
                              context,
                            ).scaffoldBackgroundColor.withValues(alpha: 0.85),
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
