import 'dart:async';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/utils.dart';

class AudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  FlutterTts tts = FlutterTts();
  Tts ttsOption = Tts();
  List<Filter> filter = List.of([Filter()]);
  History lastData = History();
  List<String> contents = [];

  AudioSession? session;

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
    speed: 0,
  );

  MediaItem baseItem = (MediaItem(
      id: 'tts',
      album: 'tts',
      title: '',
      artist: '',
      duration: const Duration(milliseconds: 1000000)));
  final int STAT_STOP = 0;
  final int STAT_PLAY = 1;
  final int STAT_PAUSE = 2;

  int playstat = 0;
  bool listenPlaying = false;

  Completer<bool> _completer = Completer<bool>();
  Future<void> initTts() async {
    await tts.setEngine(await tts.getDefaultEngine);
    // await tts.awaitSpeakCompletion(true);
    await tts.setSpeechRate(ttsOption.speechRate);
    await tts.setVolume(ttsOption.volume);
    await tts.setPitch(ttsOption.pitch);
    tts.setStartHandler(() {
      print("setStartHandler");
    });
    tts.setCompletionHandler(() {
      _completer.complete(true);
    });
    tts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {});
    tts.setErrorHandler((msg) {
      playstat = STAT_STOP;
    });
    tts.setCancelHandler(() {
      _completer.complete(false);
    });
  }

  Future<bool> speak(String text) {
    _completer = Completer<bool>();
    tts.speak(text);
    return _completer.future;
  }

  // onplay
  Future<void> play() async {
    playstat = STAT_PLAY;

    session = await AudioSession.instance;
    session!.interruptionEventStream.listen((event) {
      if (event.type == AudioInterruptionType.pause) {
        if (event.begin) {
          bool laststat = playstat == STAT_PLAY;
          pause();
          listenPlaying = laststat;
        } else if (listenPlaying == true) {
          play();
        }
        return;
      }
      if (event.begin && event.type == AudioInterruptionType.unknown) {
        if (ttsOption.audiosession) {
          pause();
        } else {}
      }
    });

    await initTts();

    mediaItem.add(MediaItem(
      id: 'opentextView',
      album: '',
      title: '${lastData.name}',
      duration: Duration(seconds: contents.length),
    ));

    for (var i = lastData.pos; i < contents.length; i += ttsOption.groupcnt) {
      // for (var i = lastData.pos; i < 30; i += 2) {
      if (playstat != STAT_PLAY) break;
      int end = min(i + ttsOption.groupcnt, contents.length - 1);
      String speakText = contents.getRange(i, end).join("\n");
      filter.forEach((e) {
        if (e.expr) {
          speakText =
              speakText.replaceAllMapped(RegExp(e.filter), (match) => e.to);
        } else {
          speakText = speakText.replaceAll(e.filter, e.to);
        }
      });

      playbackState
          .add(baseState.copyWith(updatePosition: Duration(seconds: i)));
      print(speakText);
      await speak(speakText);
      lastData.pos = i;
      await Utils.setLastData(lastData.toJson());
      if (end >= contents.length - 1) {
        stop();
        break;
      }
    }
  }

  Future<void> pause() async {
    playstat = STAT_PAUSE;

    this.playbackState.add(baseState.copyWith(
          controls: [
            MediaControl.play,
            MediaControl.stop,
          ],
          processingState: AudioProcessingState.completed,
          updatePosition: Duration(seconds: lastData.pos),
          playing: false,
        ));
    tts.stop();
    super.pause();
  }

  Future<void> stop() async {
    playstat = STAT_STOP;
    // this.playbackState.close();
    this.playbackState.add(PlaybackState());
    tts.stop();
    // await playbackState.firstWhere(
    //     (state) => state.processingState == AudioProcessingState.idle);
    super.stop();
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    if (name == "init" && extras != null) {
      this.ttsOption = Tts.fromMap(extras["tts"]);
      this.contents = extras["contents"] as List<String>;
      this.filter = extras["filter"];
      this.lastData = History.fromMap(extras["lastData"]);
    }
  }

  Future<void> seek(Duration position) async {}
  Future<void> skipToQueueItem(int i) async {}
}

class AudioPlay {
  static AudioHandler? _audioHandler;
  static List<Function(PlaybackState)> lisenFunction = [];
  static init() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.khjde.opentextview.channel.audio',
        androidNotificationChannelName: 'Music playback',
      ),
    );
    _audioHandler!.playbackState.stream.listen((event) {
      lisenFunction.forEach((e) {
        e(event);
      });
    });
  }

  static lisen(Function(PlaybackState) fn) {
    lisenFunction.add(fn);
  }

  static removeLisen(Function(PlaybackState) fn) {
    lisenFunction.remove(fn);
  }

  static play(
      {required List<String> contents,
      required Map<String, dynamic> tts,
      required List<dynamic> filter,
      required Map<String, dynamic> lastData}) {
    _audioHandler!.customAction("init", {
      "contents": contents,
      "tts": tts,
      "filter": filter,
      "lastData": lastData,
    });
    _audioHandler!.play();
    print(_audioHandler!.playbackState.stream);
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
      builder: (context, snapshot) {
        return builder(context, snapshot);
      },
    );
  }
}
