import 'dart:io';

import 'package:audio_service/audio_service.dart';

import 'package:flutter/widgets.dart';
import 'package:open_textview/controller/audio_handler_android.dart';
import 'package:open_textview/controller/audio_handler_ios.dart';

class AudioPlay {
  static AudioHandler? _audioHandler;
  static init() async {
    _audioHandler = await AudioService.init(
      builder: () => Platform.isAndroid ? AudioHandlerAndroid() : AudioHandlerIOS(),
      config: AudioServiceConfig(
        androidNotificationIcon: 'mipmap/ic_launcher_play',
        // androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelId: 'com.khjde.opentextview.channel.audio',
        androidNotificationChannelName: 'tts',
        androidNotificationOngoing: true,
      ),
    );
    return _audioHandler;
  }

  static setAutoExit({required DateTime t}) {
    _audioHandler!.customAction("autoExit", {
      "autoExit": t,
    });
  }

  static play() {
    if (_audioHandler != null) {
      _audioHandler!.play();
    }
  }

  static stop() {
    if (_audioHandler != null) {
      _audioHandler!.stop();
    }
  }

  static pause() {
    if (_audioHandler != null) {
      _audioHandler!.pause();
    }
  }

  static AudioHandler? get audioHandler => _audioHandler;
  static builder({required Widget Function(BuildContext context, AsyncSnapshot<PlaybackState> snapshot) builder}) {
    return StreamBuilder<PlaybackState>(
      stream: _audioHandler!.playbackState,
      builder: (context, snapshot) {
        return builder(context, snapshot);
      },
    );
  }
}
