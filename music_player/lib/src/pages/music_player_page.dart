import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          Column(
            children: const [
              CustomAppbar(),
              _DurationImage(),
              _PlayTitle(),
              Expanded(child: _Lyrics())
            ],
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [Color(0xff33333e), Color(0xff201e28)])),
    );
  }
}

class _Lyrics extends StatelessWidget {
  const _Lyrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return ListWheelScrollView(
      physics: const BouncingScrollPhysics(),
      itemExtent: 42,
      diameterRatio: 1.5,
      children: lyrics
          .map((linea) => Text(
                linea,
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.6)),
              ))
          .toList(),
    );
  }
}

class _PlayTitle extends StatefulWidget {
  const _PlayTitle({
    Key? key,
  }) : super(key: key);

  @override
  State<_PlayTitle> createState() => _PlayTitleState();
}

class _PlayTitleState extends State<_PlayTitle>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController playAnimation;
  bool firstTime = true;

  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    playAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    playAnimation.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
        autoStart: true, showNotification: true);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.currentDuration = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration =
          playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 40),
      child: Row(children: [
        Column(
          children: [
            Text("Far away",
                style: TextStyle(
                    fontSize: 30, color: Colors.white.withOpacity(0.8))),
            Text("-Breaking Benjamin-",
                style: TextStyle(
                    fontSize: 15, color: Colors.white.withOpacity(0.6))),
          ],
        ),
        const Spacer(),
        FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            final audioPlayerModel =
                Provider.of<AudioPlayerModel>(context, listen: false);
            isPlaying ? playAnimation.reverse() : playAnimation.forward();
            isPlaying
                ? audioPlayerModel.controller.stop()
                : audioPlayerModel.controller.repeat();
            isPlaying = !isPlaying;

            if (firstTime) {
              open();
              firstTime = false;
            } else {
              assetAudioPlayer.playOrPause();
            }
          },
          backgroundColor: const Color(0xfff8cb51),
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            color: Colors.black,
            progress: playAnimation,
          ),
        )
      ]),
    );
  }
}

class _DurationImage extends StatelessWidget {
  const _DurationImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 60),
      child: Row(
        children: const [
          _DiscImage(),
          SizedBox(width: 30),
          _ProgressBar(),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Column(
      children: [
        Text(
          audioPlayerModel.songTotalDuration,
          style: TextStyle(color: Colors.white.withOpacity(0.4)),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
                width: 3, height: 230, color: Colors.white.withOpacity(0.1)),
            Positioned(
              bottom: 0,
              child: Container(
                  width: 3,
                  height: 230 * porcentaje,
                  color: Colors.white.withOpacity(0.8)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          audioPlayerModel.currentSecond,
          style: TextStyle(color: Colors.white.withOpacity(0.4)),
        )
      ],
    );
  }
}

class _DiscImage extends StatelessWidget {
  const _DiscImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1e1c24)])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
                duration: const Duration(seconds: 10),
                infinite: true,
                controller: (animationController) =>
                    audioPlayerModel.controller = animationController,
                manualTrigger: true,
                child: const Image(image: AssetImage("assets/aurora.jpg"))),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(100)),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: const Color(0xff1c1c25),
                  borderRadius: BorderRadius.circular(100)),
            )
          ],
        ),
      ),
    );
  }
}
