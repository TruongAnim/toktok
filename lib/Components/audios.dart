import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/music_controller.dart';
import 'package:toktok/models/audio_details.dart';

class Audios extends StatefulWidget {
  Audios({Key? key}) : super(key: key);

  @override
  State<Audios> createState() => _AudiosState();
}

class _AudiosState extends State<Audios> {
  late List<AudioDetails> _audioDetails;
  late MusicController musicController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    musicController = Get.find();
    _audioDetails = musicController.getListAudio();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _audioDetails.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  musicController.currentSong = _audioDetails[index];
                  Get.back(result: _audioDetails[index]);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  leading: Container(
                    width: 34,
                    height: 34,
                    child: Image.asset(
                      _audioDetails[index].image,
                    ),
                  ),
                  title: Text(
                    _audioDetails[index].title,
                    style: TextStyle(color: secondaryColor, fontSize: 14),
                  ),
                  subtitle: Text(
                    _audioDetails[index].subtitle,
                    style: theme.textTheme.caption,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        color: secondaryColor,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        backgroundColor: darkColor,
                        child: Icon(
                          Icons.play_arrow,
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: darkColor,
                width: double.infinity,
              ),
            ],
          );
        });
  }
}
