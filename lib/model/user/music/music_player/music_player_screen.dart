import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../resources/color-manager.dart';
import '../music_modle.dart';

class MusicPlayer extends StatefulWidget {
  final MusicModel music;
  int index;
  final String musicUrl;
  final List<MusicModel> musics;

  MusicPlayer({
    required this.index,
    required this.music,
    required this.musicUrl,
    required this.musics,
    Key? key,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer player;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await player.setUrl(widget.musicUrl);
      player.play();

      player.playerStateStream.listen((state) {
        setState(() {
          isPlaying = state.playing;
          if (state.processingState == ProcessingState.completed) {
            position = duration;
          }
        });
      });

      player.positionStream.listen((pos) {
        setState(() {
          position = pos;
        });
      });

      player.durationStream.listen((dur) {
        setState(() {
          duration = dur ?? Duration.zero;
        });
      });
    } catch (e) {
      print('Error setting audio source: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load audio source')),
      );
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  // void _skipPrevious() {
  //   final newIndex = (widget.index - 1) % widget.musics.length;
  //   final index = newIndex >= 0 ? newIndex : widget.musics.length - 1;
  //   _playNewSong(index);
  // }

  // void _skipNext() {
  //   final newIndex = (widget.index + 1) % widget.musics.length;
  //   final index = newIndex < widget.musics.length ? newIndex : 0;
  //   _playNewSong(index);
  // }

  Future<void> _playNewSong(int index) async {
    try {
      await player.stop();
      String newMusicUrl = widget.musics[index].musicUrl;
      await player.setUrl(newMusicUrl);
      player.play();
      setState(() {
        widget.index = index;
      });
    } catch (e) {
      print('Error setting new audio source: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load new audio source')),
      );
    }
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
          title: const Text(
            "New Player",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Pacifico",
            ),
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
                    "assets/images/music.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.music.musicName,
                        style: TextStyle(
                          color: ColorManager.secondPanicAttack,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightScreen * 0.02),
              if (duration != Duration.zero)
                Slider(
                  activeColor: ColorManager.secondPanicAttack,
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds
                      .toDouble()
                      .clamp(0.0, duration.inSeconds.toDouble()),
                  onChanged: (value) async {
                    final newPosition = Duration(seconds: value.toInt());
                    await player.seek(newPosition);
                  },
                )
              else
                CircularProgressIndicator(
                  color: ColorManager.secondPanicAttack,
                ),
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
              SizedBox(height: heightScreen * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // IconButton(
                  //   onPressed: _skipPrevious,
                  //   icon: const Icon(
                  //     Icons.skip_previous,
                  //     size: 36,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundColor: ColorManager.secondPanicAttack,
                    radius: 30,
                    child: IconButton(
                      onPressed: () async {
                        if (isPlaying) {
                          await player.pause();
                        } else {
                          await player.play();
                        }
                      },
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      iconSize: 40,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: _skipNext,
                  //   icon: const Icon(
                  //     Icons.skip_next,
                  //     size: 36,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
