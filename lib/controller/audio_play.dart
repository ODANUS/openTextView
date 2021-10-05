import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';

class AudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations
  PlaybackState baseState = PlaybackState(
    controls: [
      MediaControl.pause,
      MediaControl.stop,
    ],
    systemActions: const {
      MediaAction.seek,
    },
    androidCompactActionIndices: const [0],
    processingState: AudioProcessingState.ready,
    playing: true,
    updatePosition: Duration(milliseconds: 500000),
    speed: 0,
  );

  MediaItem baseItem = (MediaItem(
      id: 'tts',
      album: 'tts',
      title: '',
      artist: '',
      duration: const Duration(milliseconds: 1000000),
      extras: {"pos": 10}));
  // The most common callbacks:
  Future<void> play() async {
    // var item1 = MediaItem(
    //   id: 'https://example.com/audio.mp3',
    //   album: 'Album name',
    //   title: 'Track title',
    //   artist: 'Artist name',
    //   duration: const Duration(milliseconds: 123456),
    //   artUri: Uri.parse('https://example.com/album.jpg'),
    // );
    // mediaItem.add(item1);
    this.playbackState.add(baseState);

    mediaItem.add(MediaItem(
        id: 'asdsaaaadsa',
        album: 'asasaaaasa',
        title: '${Random().nextInt(10)}',
        artist: 'asasasaaasa',
        duration: const Duration(milliseconds: 1000000),
        extras: {"pos": 10}));
    print("start");

    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
  }

  Future<void> pause() async {
    this.playbackState.add(baseState.copyWith(
          controls: [
            MediaControl.play,
            MediaControl.stop,
          ],
          processingState: AudioProcessingState.completed,
          playing: false,
        ));
    super.pause();
  }

  Future<void> stop() async {
    // this.playbackState.close();
    this.playbackState.add(PlaybackState());

    // await playbackState.firstWhere(
    //     (state) => state.processingState == AudioProcessingState.idle);
    super.stop();
  }

  Future<void> seek(Duration position) async {}
  Future<void> skipToQueueItem(int i) async {}
}

class AudioPlay {
  static AudioHandler? _audioHandler;
  static init() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.khjde.opentextview.channel.audio',
        androidNotificationChannelName: 'Music playback',
      ),
    );
  }

  static play() {
    _audioHandler!.play();
  }

  static stop() {
    _audioHandler!.stop();
  }

  static pause() {
    _audioHandler!.pause();
  }

  static builder(
      {required Widget Function(
              BuildContext context, AsyncSnapshot<PlaybackState> snapshot)
          builder}) {
    return StreamBuilder<PlaybackState>(
      stream: _audioHandler!.playbackState,
      builder: builder,
    );
  }
}
