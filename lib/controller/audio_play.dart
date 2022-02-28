import 'dart:async';

import 'dart:math';
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/objectbox.g.dart';

class AudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  AudioHandler() {
    // AudioSession.instance.then((value) async {
    //   this.session = value;
    //   this.session!.configure(AudioSessionConfiguration.speech());
    //   await this.session!.configure(AudioSessionConfiguration.speech());

    //   session!.devicesChangedEventStream.listen((event) {
    //     if (event.devicesRemoved.isNotEmpty && playstat == STAT_PLAY) {
    //       stop();
    //     }
    //   });
    //   this.session!.interruptionEventStream.listen((event) {
    //     if (event.type == AudioInterruptionType.pause) {
    //       if (event.begin) {
    //         bool laststat = playstat == STAT_PLAY;
    //         pause();
    //         listenPlaying = laststat;
    //       } else if (listenPlaying == true) {
    //         play();
    //       }
    //       return;
    //     }
    //     if (event.begin && event.type == AudioInterruptionType.unknown) {
    //       if (ttsOption.audiosession) {
    //         pause();
    //       } else {}
    //     }
    //   });
    // });
  }

  FlutterTts tts = FlutterTts();
  bool bInitTts = false;
  SettingBox setting = SettingBox();
  List<FilterBox> filter = List.of([FilterBox()]);
  HistoryBox currentHistory = HistoryBox();
  List<String> contents = [];

  AudioSession? session;

  // mix in default seek callback implementations
  PlaybackState baseState = PlaybackState(
    controls: [
      // MediaControl.rewind,
      MediaControl.pause,
      MediaControl.stop,
      // MediaControl.fastForward,
    ],
    // systemActions: const {
    //   MediaAction.seek,
    //   MediaAction.skipToNext,
    //   MediaAction.skipToPrevious,
    // },
    // systemActions: const {
    //   MediaAction.pause,
    //   MediaAction.play,
    //   MediaAction.stop,
    // },

    androidCompactActionIndices: const [0, 1],
    processingState: AudioProcessingState.ready,
    playing: true,
    speed: 0,
  );

  MediaItem baseItem = MediaItem(
      id: 'tts',
      album: 'tts',
      title: '',
      artist: '',
      duration: const Duration(milliseconds: 1000000));
  final int STAT_STOP = 0;
  final int STAT_PLAY = 1;
  final int STAT_PAUSE = 2;

  int playstat = 0;
  bool listenPlaying = false;
  DateTime? autoExitDate;

  Completer<bool> _completer = Completer<bool>();
  Future<void> setTts() async {
    await tts.setSpeechRate(setting.speechRate);
    await tts.setVolume(setting.volume);
    await tts.setPitch(setting.pitch);
    // await tts.awaitSpeakCompletion(true);
  }

  // Future<void> skipToPrevious() {
  //   dev.log("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  //   return super.skipToPrevious();
  // }

  // Future<void> skipToNext() {
  //   dev.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  //   return super.skipToNext();
  // }

  Future<void> initTts() async {
    if (!bInitTts) {
      bInitTts = true;

      var engine = await tts.getDefaultEngine;
      await tts.setEngine(engine);
      await Future.delayed(300.milliseconds);
      // tts.getDefaultEngine.then((engine) {
      //
      //   if (engine != null && engine.isNotEmpty) {
      //
      //     try {
      //       tts.setEngine(engine);
      //     } catch (e) {}
      //
      //   }
      // });
    }

    setTts();

    tts.awaitSpeakCompletion(true);

    // tts.setStartHandler(() {});
    // tts.setCompletionHandler(() {
    //   _completer.complete(true);
    // });
    // tts.setProgressHandler(
    //     (String text, int startOffset, int endOffset, String word) {});
    // tts.setErrorHandler((msg) {
    //   playstat = STAT_STOP;
    //   _completer.complete(false);
    // });
    // tts.setCancelHandler(() {
    //   _completer.complete(false);
    // });
  }

  Future<bool> speak(String text) {
    _completer = Completer<bool>();
    try {
      tts.speak(text);
    } catch (e) {
      _completer.complete(false);
    }
    return _completer.future;
  }

  // onplay
  Future<void> play() async {
    playstat = STAT_PLAY;
    AudioService.androidForceEnableMediaButtons();

    if (this.session == null) {
      this.session = await AudioSession.instance;

      await this.session!.configure(AudioSessionConfiguration.speech());
      session!.devicesChangedEventStream.listen((event) {
        if (event.devicesRemoved.isNotEmpty && playstat == STAT_PLAY) {
          this.stop();
        }
      });
      this.session!.interruptionEventStream.listen((event) {
        if (event.type == AudioInterruptionType.pause) {
          if (event.begin) {
            bool laststat = playstat == STAT_PLAY;
            this.pause();
            listenPlaying = laststat;
          } else if (listenPlaying == true) {
            this.play();
          }
          return;
        }
        if (event.begin && event.type == AudioInterruptionType.unknown) {
          if (setting.audiosession) {
            this.pause();
          } else {}
        }
      });
    }

    this.session!.setActive(true);

    await initTts();
    mediaItem.add(MediaItem(
      id: 'opentextView',
      album: '',
      title: '${currentHistory.name}',
      duration: Duration(seconds: contents.length),
    ));

    // while (contents.isNotEmpty) {
    //   int end = min(ttsOption.groupcnt, contents.length);
    //   String speakText = contents.getRange(0, end).join("\n");
    //   filter.forEach((e) {
    //     if (e.enable) {
    //       if (e.expr) {
    //         speakText =
    //             speakText.replaceAllMapped(RegExp(e.filter), (match) => e.to);
    //       } else {
    //         speakText = speakText.replaceAll(e.filter, e.to);
    //       }
    //     }
    //   });
    //   if (this.autoExitDate != null) {
    //     mediaItem.first.then((e) {
    //       var now = DateTime.now();
    //       if (autoExitDate!.isBefore(now)) {
    //         autoExitDate = null;
    //         this.stop();
    //       } else {
    //         var ss = autoExitDate!.difference(now);
    //         mediaItem.add(e!.copyWith(
    //             album: "Auto_shut_down_after_@min_minute"
    //                 .trParams({"min": ss.inMinutes.toString()})));
    //       }
    //     });
    //   }

    //   playbackState.add(baseState.copyWith(
    //       updatePosition: Duration(seconds: contentsLength - contents.length)));
    //   bool bspeak = await speak(speakText);
    //   if (!bspeak) {
    //     break;
    //   }
    //   contents.removeRange(0, end);
    //   if (contents.isEmpty) {
    //     stop();
    //     break;
    //   }
    // }

    // ====================================

    for (var i = currentHistory.pos;
        i < contents.length;
        i += setting.groupcnt) {
      Store? store;
      try {
        store = await BoxCtl.createStore();
      } catch (e) {}

      if (playstat != STAT_PLAY) break;
      int end = min(i + setting.groupcnt, contents.length);

      String speakText = contents.getRange(i, end).join("\n");

      filter.forEach((e) {
        if (e.enable) {
          if (e.expr) {
            speakText =
                speakText.replaceAllMapped(RegExp(e.filter), (match) => e.to);
          } else {
            speakText = speakText.replaceAll(e.filter, e.to);
          }
        }
      });
      if (this.autoExitDate != null) {
        mediaItem.first.then((e) {
          var now = DateTime.now();
          if (autoExitDate!.isBefore(now)) {
            autoExitDate = null;
            this.stop();
          } else {
            var ss = autoExitDate!.difference(now);
            mediaItem.add(e!.copyWith(
                album: "Auto_shut_down_after_@min_minute"
                    .trParams({"min": ss.inMinutes.toString()})));
          }
        });
      }
      playbackState
          .add(baseState.copyWith(updatePosition: Duration(seconds: i)));

      // bool bspeak = await speak(speakText);
      var bspeak = await tts.speak(speakText);

      try {
        store?.box<HistoryBox>().put(currentHistory);
      } catch (e) {}
      currentHistory.pos = i;

      // await Utils.setLastData(lastData.toJson());

      // if (!bspeak) {
      //   break;
      // }

      if (end >= contents.length) {
        stop();
        break;
      }
    }
  }

  Future<void> pause() async {
    AudioService.androidForceEnableMediaButtons();

    await tts.stop();
    this.playbackState.add(baseState.copyWith(
          controls: [
            MediaControl.play,
            MediaControl.stop,
          ],
          androidCompactActionIndices: const [0, 1],
          processingState: AudioProcessingState.completed,
          updatePosition: Duration(seconds: currentHistory.pos),
          playing: false,
        ));

    playstat = STAT_PAUSE;
    super.pause();
  }

  Future<void> stop() async {
    if (session != null) {
      session!.setActive(false);
    }
    // this.playbackState.close();
    await tts.stop();
    this.playbackState.add(PlaybackState());
    // await playbackState.firstWhere(
    //     (state) => state.processingState == AudioProcessingState.idle);
    playstat = STAT_STOP;
    super.stop();
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    if (name == "init" && extras != null) {
      this.contents = List<String>.from(extras["contents"]);
      this.setting = SettingBox.fromMap(extras["setting"]);
      this.filter = (extras["filter"] as List<Map<String, dynamic>>)
          .map((e) => FilterBox.fromMap(e))
          .toList();
      this.currentHistory = HistoryBox.fromMap(extras["currentHistory"]);
    }
    if (name == "setting" && extras != null) {
      this.setting = SettingBox.fromMap(extras["setting"]);
      setTts();
    }
    if (name == "filter" && extras != null) {
      this.filter = (extras["filter"] as List<Map<String, dynamic>>)
          .map((e) => FilterBox.fromMap(e))
          .toList();
    }
    if (name == "autoExit" && extras != null) {
      this.autoExitDate = extras["autoExit"];
    }
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    if (setting.headsetbutton) {
      if (playstat == STAT_PLAY) {
        pause();
      } else if (playstat == STAT_PAUSE) {
        play();
      }
    }
    // return super.click(button);
  }
}

class AudioPlay {
  static AudioHandler? _audioHandler;
  static List<Function(PlaybackState)> lisenFunction = [];
  static init() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        // androidNotificationChannelId: 'com.khjde.opentextview.channel.audio',
        androidNotificationChannelName: 'tts',
        androidNotificationOngoing: true,
      ),
    );
    _audioHandler!.playbackState.stream.listen((event) {
      lisenFunction.forEach((e) {
        e(event);
      });
    });
    return _audioHandler;
  }

  static lisen(Function(PlaybackState) fn) {
    lisenFunction.add(fn);
  }

  static removeLisen(Function(PlaybackState) fn) {
    lisenFunction.remove(fn);
  }

  static setSetting({
    required SettingBox setting,
  }) {
    _audioHandler!.customAction("setting", {
      "setting": setting.toMap(),
    });
  }

  static setFilter({
    required List<FilterBox> filter,
  }) {
    _audioHandler!.customAction("filter", {
      "filter": filter.map((e) => e.toMap()).toList(),
    });
  }

  static setAutoExit({required DateTime t}) {
    _audioHandler!.customAction("autoExit", {
      "autoExit": t,
    });
  }

  static play({
    required List<String> contents,
    required List<FilterBox> filter,
    required SettingBox setting,
    required HistoryBox currentHistory,
  }) {
    if (_audioHandler != null) {
      _audioHandler!.customAction("init", {
        "contents": contents,
        "filter": filter.map((e) => e.toMap()).toList(),
        "setting": setting.toMap(),
        "currentHistory": currentHistory.toMap(),
      });
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
  static builder(
      {required Widget Function(
              BuildContext context, AsyncSnapshot<PlaybackState> snapshot)
          builder}) {
    return StreamBuilder<PlaybackState>(
      stream: _audioHandler!.playbackState,
      builder: (context, snapshot) {
        return builder(context, snapshot);
      },
    );
  }
}
