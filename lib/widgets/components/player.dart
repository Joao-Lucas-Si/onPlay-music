import 'package:flutter/material.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/marquee.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/next_button.dart';
import 'package:onPlay/widgets/components/player/play_button.dart';
import 'package:onPlay/widgets/components/player/previous_button.dart';
import 'package:onPlay/widgets/components/popup/music_popup.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';

class Player extends StatefulWidget {
  @override
  createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int? seconds;
  double volume = 1;
  final volumeController = VolumeController();

  @override
  initState() {
    super.initState();
    _initVolume();
  }

  _initVolume() async {
    volume = await volumeController.getVolume();
    setState(() {
      this.volume = volume;
    });
    volumeController.listener((p0) {
      setState(() {
        volume = p0;
      });
    });
  }

  toMinutes(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = (seconds / 60).floor();
    final restSeconds = (seconds % 60).floor();
    return "${hours > 1 ? "$hours:" : ""}${minutes < 10 ? 0 : ""}$minutes:${restSeconds < 10 ? 0 : ""}$restSeconds";
  }

  final pageController = PageController(
    initialPage: 0,
  );

  var page = 0;

  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<SongStore>(context);
    final colorStore = Provider.of<ColorStorage>(context);
    final player = Provider.of<PlayerService>(context);
    final playerStore = Provider.of<PlayerStore>(context);
    var musicPosition = seconds != null
        ? (seconds! / (playerStore.playingSong?.duration ?? 0))
        : playerStore.position / (playerStore.playingSong?.duration ?? 0);

    WidgetsBinding.instance.addPostFrameCallback((a) {
      if (pageController.hasClients &&
          playerStore.currentSong != null &&
          playerStore.currentSong != page) {
        pageController.jumpToPage(playerStore.currentSong!);
      }
    });

    return Stack(children: [
      PageView.builder(
          controller: pageController,
          itemCount: playerStore.playlist.length,
          onPageChanged: (value) {
            playerStore.currentSong = value;
            setState(() {
              page = value;
            });
          },
          itemBuilder: (context, index) => Container(
                color: colorStore.dominantColor,
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    playerStore.playingSong?.picture != null
                        ? Container(
                            foregroundDecoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.transparent,
                                  colorStore.dominantColor ?? Colors.black,
                                ],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter)),
                            child: Image.memory(
                              playerStore.playingSong!.picture!,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Icon(
                            Icons.music_off,
                            size: MediaQuery.of(context).size.height * 0.4,
                          ),
                    MarqueeWidget(
                        pauseDuration: Duration(microseconds: 0),
                        // backDuration: Duration(microseconds: 0),
                        animationDuration: Duration(seconds: 30),
                        child: Text(
                          playerStore.playingSong?.title ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: colorStore.lightColor,
                              fontSize: 20),
                        )),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [PreviousButton(), PlayButton(), NextButton()],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Wrap(
                          spacing: 5,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              toMinutes(seconds != null
                                  ? seconds!
                                  : playerStore.position),
                              style: TextStyle(color: colorStore.lightColor),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.75 -
                                        (10 * 2) -
                                        (5 * 2),
                                child: Slider(
                                  onChangeEnd: (value) {
                                    final seconds =
                                        ((playerStore.playingSong?.duration ??
                                                    0) *
                                                value)
                                            .floor();
                                    player.setPosition(seconds);
                                    setState(() {
                                      this.seconds = null;
                                    });
                                  },
                                  onChanged: (value) {
                                    final seconds =
                                        ((playerStore.playingSong?.duration ??
                                                    0) *
                                                value)
                                            .floor();
                                    setState(() {
                                      this.seconds = seconds;
                                    });
                                  },
                                  // onChangeStart: (value) {
                                  //   print(value);
                                  // },
                                  inactiveColor: colorStore.darkColor,
                                  activeColor: colorStore.lightColor,
                                  //value: 0,
                                  value: musicPosition > 1 ? 0 : musicPosition,
                                )),
                            Text(
                                toMinutes(
                                    playerStore.playingSong!.duration ?? 0),
                                style: TextStyle(color: colorStore.lightColor))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Wrap(
                        spacing: 1,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                volumeController.muteVolume();
                              },
                              icon: Icon(Icons.volume_off,
                                  size: 28, color: colorStore.lightColor)),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * 0.90) -
                                      (30 * 2) -
                                      (10 * 2) -
                                      (1 * 2),
                              child: Slider(
                                value: volume,
                                activeColor: colorStore.lightColor,
                                inactiveColor: colorStore.darkColor,
                                onChanged: (value) {
                                  volumeController.setVolume(value);
                                },
                              )),
                          IconButton(
                              onPressed: () {
                                volumeController.maxVolume();
                              },
                              icon: Icon(Icons.volume_up,
                                  size: 28, color: colorStore.lightColor))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            playerStore.velocity =
                                playerStore.velocity == playerStore.maxVelocity
                                    ? playerStore.velocityStep
                                    : playerStore.velocity +
                                        playerStore.velocityStep;
                          },
                          child: Text(
                            "${playerStore.velocity}X",
                            style: TextStyle(color: colorStore.lightColor),
                          ),
                        ),
                        MusicPopup(
                          song: playerStore.playingSong!,
                        ),
                        IconButton(
                            onPressed: () {
                              switch (playerStore.mode) {
                                case PlayModes.none:
                                  playerStore.mode = PlayModes.replayMusic;
                                  break;
                                case PlayModes.replayMusic:
                                  playerStore.mode = PlayModes.replayPlaylist;
                                  break;
                                case PlayModes.replayPlaylist:
                                  playerStore.mode = PlayModes.none;
                                  break;
                              }
                            },
                            icon: Icon(
                              playerStore.mode == PlayModes.replayPlaylist
                                  ? Icons.hourglass_full
                                  : playerStore.mode == PlayModes.replayMusic
                                      ? Icons.hourglass_bottom
                                      : Icons.hourglass_empty,
                              color: colorStore.lightColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *
                              CurrentPlaylist.minSize -
                          0.02,
                    )
                  ],
                ),
              )),
      CurrentPlaylist()
    ]);
  }
}
