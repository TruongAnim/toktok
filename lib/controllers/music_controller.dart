import 'package:get/get.dart';
import 'package:toktok/models/audio_details.dart';

class MusicController extends GetxController {
  AudioDetails? currentSong;
  List<AudioDetails> getListAudio() {
    final List<AudioDetails> _audioDetails = [
      AudioDetails("assets/audio_thum.jpg", "Dance on Heaven", "JAmes Carlo"),
      AudioDetails(
          "assets/audio_thum.jpg", "Nothing can stop me", "Taylor Haydon"),
      AudioDetails("assets/audio_thum.jpg", "I drop a picture", "JAmes Carlo"),
      AudioDetails(
          "assets/audio_thum.jpg", "Breaup up with your girl", "JAmes Carlo"),
      AudioDetails("assets/audio_thum.jpg", "I wear my crown", "JAmes Carlo"),
      AudioDetails(
          "assets/audio_thum.jpg", "I wanna be your end game", "JAmes Carlo"),
      AudioDetails("assets/audio_thum.jpg", "Come and put cha", "JAmes Carlo"),
      AudioDetails("assets/audio_thum.jpg", "Dance on Heaven", "JAmes Carlo"),
      AudioDetails("assets/audio_thum.jpg", "Dance on Heaven", "JAmes Carlo"),
    ];
    return _audioDetails;
  }
}
