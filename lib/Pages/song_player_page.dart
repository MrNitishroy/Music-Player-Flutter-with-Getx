import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/player_controller.dart';
import 'all_songs_page.dart';

class SongPlayerPage extends StatelessWidget {
  final SongModel song;
  const SongPlayerPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.put(PlayerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Soundify"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.queue_music_rounded, size: 30),
            onPressed: () {
              Get.to(const AllSongPage());
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          image: DecorationImage(
            image: AssetImage(playerController
                .coverImageList[playerController.randomNumber.value]),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  song.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                )
              ],
            ),
            Column(
              children: [
                Obx(
                  () => Slider(
                      value: playerController.currentValue.value
                          .clamp(0.0, playerController.max.value),
                      min: 0.0,
                      max: playerController.max.value,
                      onChanged: (seconds) {
                        playerController
                            .changeDurationToSecond(seconds.toInt());
                        seconds = seconds;
                      }),
                ),
                // Obx(
                //   () => Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(playerController.position.value == null
                //           ? "00:00"
                //           : playerController.position.value.toString()),
                //       Text(playerController.duration.value.toString()),
                //     ],
                //   ),
                // ),
                Obx(
                  () => Lottie.asset(
                    'assets/animation/wwave.json',
                    animate: playerController.isPlaying.value,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous_rounded, size: 30),
                      onPressed: () {
                        playerController.onBackPlay();
                      },
                    ),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: playerController.isLooping.value
                              ? Colors.white12
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.loop_rounded, size: 25),
                          onPressed: () {
                            playerController.onLoopClick();
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          playerController.playPause();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.all(10),
                          child: playerController.isPlaying.value
                              ? Icon(
                                  Icons.pause_rounded,
                                  size: 50,
                                  color: Colors.deepPurple,
                                )
                              : Icon(
                                  Icons.play_arrow_rounded,
                                  size: 50,
                                  color: Colors.deepPurple,
                                ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shuffle_rounded, size: 30),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next_rounded, size: 30),
                      onPressed: () {
                        playerController.onNextPlay();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
