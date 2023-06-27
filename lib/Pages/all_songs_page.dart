import 'package:Soundify/Pages/song_player_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/player_controller.dart';

class AllSongPage extends StatefulWidget {
  const AllSongPage({super.key});

  @override
  State<AllSongPage> createState() => _AllSongPageState();
}

class _AllSongPageState extends State<AllSongPage> {
  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.put(PlayerController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => InkWell(
          onTap: () {
            Get.to(() => SongPlayerPage(
                  song: playerController.songs[0],
                ));
          },
          child: SizedBox(
            child: playerController.isPlaying.value
                ? Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 50,
                            height: 50,
                            child: IconButton(
                              onPressed: () {
                                playerController.playPause();
                              },
                              icon: playerController.isPlaying.value
                                  ? Icon(
                                      Icons.pause_rounded,
                                      color: Colors.deepPurple,
                                    )
                                  : Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.deepPurple,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            playerController.songs[0].title,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Lottie.asset(
                          'assets/animation/playingButton.json',
                          width: 30,
                        )
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                    ),
                  ),
                  Text(
                    "All Songs",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<SongModel>>(
                  future: playerController.audioQuary.querySongs(
                    ignoreCase: true,
                    orderType: OrderType.ASC_OR_SMALLER,
                    sortType: null,
                    uriType: UriType.EXTERNAL,
                  ),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.isEmpty) {
                      return Center(child: Text('No songs found'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            playerController.songPlay(
                                snapshot.data![index].data, index);
                            playerController.songs
                                .insert(0, snapshot.data![index]);
                            Get.to(SongPlayerPage(
                              song: snapshot.data![index],
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.music_note),
                              ),
                              title: Text(
                                snapshot.data![index].title,
                                maxLines: 2,
                              ),
                              trailing: Icon(Icons.play_arrow),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
