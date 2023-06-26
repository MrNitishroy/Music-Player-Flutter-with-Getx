import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuary = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  RxBool isLooping = false.obs;
  RxInt currentIndex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var currentValue = 0.0.obs;
  RxInt randomNumber = 0.obs;
  RxList<SongModel> songs = <SongModel>[].obs;
  List coverImageList = [
    "assets/bg/bg.jpg",
    "assets/bg/bg1.jpg",
    "assets/bg/bg2.jpg",
    "assets/bg/bg3.jpg"
  ];
  @override
  void onInit() {
    super.onInit();
    checkStoragePermission();
  }

  void getRandomeNumber() {
    randomNumber.value = Random().nextInt(4);
  }

  playPause() {
    if (!isPlaying.value) {
      audioPlayer.play();
    } else {
      audioPlayer.pause();
    }
    isPlaying.value = !isPlaying.value;
  }

  onNextPlay() {
    audioPlayer.seekToNext();
  }

  onBackPlay() {
    audioPlayer.seekToPrevious();
    audioPlayer.setVolume(0.5);
  }

  updatePosition() {
    try {
      audioPlayer.durationStream.listen((d) {
        duration.value = d.toString().split(".")[0];
        max.value = d!.inSeconds.toDouble();
      });
      audioPlayer.positionStream.listen((p) {
        position.value = p.toString().split(".")[0];
        currentValue.value = p.inSeconds.toDouble();
      });
    } catch (e) {
      print(e);
    }
  }

  void songPlay(String? uri, index) {
    currentIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying.value = true;
      getRandomeNumber();
      updatePosition();
    } catch (e) {
      print(e);
    }
  }

  changeDurationToSecond(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  checkStoragePermission() async {
    try {
      var perm = await Permission.storage.request();
      if (perm.isGranted) {
        print('Permission granted');
        print(audioQuary.querySongs());
      } else {
        print('Permission denied');
        await Permission.storage.request();
      }
    } catch (ex) {
      print(ex);
    }
  }

  onLoopClick() {
    audioPlayer.setLoopMode(LoopMode.one);
    isLooping.value = !isLooping.value;
  }
}
