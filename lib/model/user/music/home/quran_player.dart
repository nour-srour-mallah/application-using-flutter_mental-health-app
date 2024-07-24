import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../resources/color-manager.dart';

class QuranPlayer extends StatefulWidget {
  final String surahName;
  final String audioUrl;

  QuranPlayer({
    required this.surahName,
    required this.audioUrl,
    Key? key,
  }) : super(key: key);

  @override
  _QuranPlayerState createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  late AudioPlayer _player;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setSourceUrl(widget.audioUrl);

      _player.onPlayerStateChanged.listen((state) {
        if (mounted) {
          setState(() {
            isPlaying = state == PlayerState.playing;
          });
        }
      });

      _player.onDurationChanged.listen((newDuration) {
        if (mounted) {
          setState(() {
            duration = newDuration;
          });
          print('Duration: $duration');
        }
      });

      _player.onPositionChanged.listen((newPosition) {
        if (mounted) {
          setState(() {
            position = newPosition;
          });
          print('Position: $position');
        }
      });

      // fetch the duration
      var currentDuration = await _player.getDuration();
      setState(() {
        duration = currentDuration!;
      });
      print('Initial Duration: $duration');
    } catch (e) {
      print('Error setting audio: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load audio: $e'),
      ));
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          title: Text(
            widget.surahName,
            style: TextStyle(fontSize: 20, fontFamily: "Pacifico"),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: heightScreen * 0.55,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorManager.sectioHeaderPanicAttack,
                        Color.fromARGB(35, 255, 255, 255),
                        ColorManager.secondPanicAttack,
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Image.asset(
                    "assets/images/q.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.surahName,
                      style: TextStyle(
                        color: ColorManager.secondPanicAttack,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightScreen * 0.02),
              if (duration > Duration.zero)
                Slider(
                  activeColor: ColorManager.secondPanicAttack,
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds
                      .toDouble()
                      .clamp(0, duration.inSeconds.toDouble()),
                  onChanged: (value) async {
                    final newPosition = Duration(seconds: value.toInt());
                    await _player.seek(newPosition);
                    if (!isPlaying) {
                      await _player.resume();
                    }
                  },
                )
              else
                CircularProgressIndicator(
                    color: ColorManager.secondPanicAttack),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(position),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: ColorManager.secondPanicAttack,
                      ),
                    ),
                    Text(
                      formatTime(duration - position),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: ColorManager.secondPanicAttack,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: ColorManager.secondPanicAttack,
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    if (isPlaying) {
                      await _player.pause();
                    } else {
                      await _player.resume();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
