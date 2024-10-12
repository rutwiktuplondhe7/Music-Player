import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playlist;

      //get current song
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    //title
                    const Text('P L A Y L I S T'),

                    //menu button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //album box
                NeuBox(
                  child: Column(
                    children: [
                      //image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),

                      //song and artist name
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //song duration progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start time
                          Text(formatTime(value.currentDuration)),

                          //suffle icon
                          Icon(Icons.shuffle),

                          //repeat icon
                          Icon(Icons.repeat),

                          //end time
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 7),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          //during when the user is sliding around
                        },
                        onChangeEnd: (double double) {
                          //sliding has ended and go to that position
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //playback controlls
                Row(
                  children: [
                    //skip previous
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),

                    const SizedBox(width: 25),

                    //play pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                      ),
                    ),

                    const SizedBox(width: 25),

                    //skip forward
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),

                    const SizedBox(width: 25),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
