import 'dart:async';
import 'dart:io';

import 'dart:math';
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:open_textview/provider/utils.dart';

class AudioHandlerIOS extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  AudioHandlerIOS() {
    this.tts = FlutterTts();
    AudioSession.instance.then((session) async {
      this.session = session;
      await this.session!.configure(AudioSessionConfiguration.speech());

      AVAudioSession().interruptionNotificationStream.listen((note) {
        print('received interrupt');
        print('type: ${note.type}');
        print('wasSuspended: ${note.wasSuspended}');
      });
      session.interruptionEventStream.listen((e) {
        print("interruptionEventStream : $e");
      });
    });

    // AudioSession.instance.then((session) async {
    //   this.session = session;

    //   await this.session!.configure(AudioSessionConfiguration.music());

    //   this.session!.devicesChangedEventStream.listen((event) {
    //     if (event.devicesRemoved.isNotEmpty && playstat == STAT_PLAY) {
    //       this.stop();
    //     }
    //   });

    //   this.session!.interruptionEventStream.listen((event) {
    //     if (event.type == AudioInterruptionType.duck && (IsarCtl.setting?.audioduck ?? true)) {
    //       if (event.begin) {
    //         bool laststat = playstat == STAT_PLAY;
    //         this.pause();
    //         listenPlayingduck = laststat;
    //       } else if (listenPlayingduck == true) {
    //         this.play();
    //       }
    //       return;
    //     }
    //     if (event.type == AudioInterruptionType.pause && (IsarCtl.setting?.audiosession ?? true)) {
    //       if (event.begin) {
    //         bool laststat = playstat == STAT_PLAY;
    //         this.pause();
    //         listenPlaying = laststat;
    //       } else if (listenPlaying == true) {
    //         this.play();
    //       }
    //       return;
    //     }

    //     if (event.begin && event.type == AudioInterruptionType.unknown) {
    //       if (IsarCtl.setting?.audiosession ?? true) {
    //         this.pause();
    //       } else {}
    //     }
    //   });
    // });

    IsarCtl.streamSetting.listen((event) {
      if (tts != null) {
        setTts();
      }
    });
    // Timer.periodic(Duration(milliseconds: 200), (timer) {
    //   errorCnt = 0;
    //   errorLen = 0;
    // });
  }

  FlutterTts? tts;
  bool bInitTts = false;
  int lastProgrss = 0;
  AudioSession? session;

  PlaybackState baseState = PlaybackState(
    controls: [
      MediaControl.pause,
      MediaControl.stop,
    ],
    androidCompactActionIndices: const [0, 1],
    processingState: AudioProcessingState.ready,
    playing: true,
    speed: 0,
  );

  MediaItem baseItem = MediaItem(id: 'tts', album: 'tts', title: '', artist: '', duration: const Duration(milliseconds: 1000000));
  final int STAT_STOP = 0;
  final int STAT_PLAY = 1;
  final int STAT_PAUSE = 2;

  int playstat = 0;
  bool listenPlaying = false;
  bool listenPlayingduck = false;
  DateTime? autoExitDate;
  var lastPos = 0;
  int errorCnt = 0;
  int errorLen = 0;
  int retry = 0;

  Future<void> setTts() async {
    await tts?.setSpeechRate(IsarCtl.setting?.speechRate ?? 1);
    await tts?.setVolume(IsarCtl.setting?.volume ?? 1);
    await tts?.setPitch(IsarCtl.setting?.pitch ?? 1.0);
  }

  Future<void> initTts() async {
    setTts();
    tts?.awaitSpeakCompletion(true);
  }

  // onplay
  Future<void> play() async {
    playstat = STAT_PLAY;
    AVAudioSession().setActive(true);

    // session?.setActive(true, avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation);

    // this.session?.setActive(true,
    //     androidWillPauseWhenDucked: true,
    //     androidAudioAttributes: AndroidAudioAttributes(
    //       contentType: AndroidAudioContentType.music,
    //     ));
    mediaItem.add(MediaItem(
      id: 'opentextView',
      album: '',
      title: 'Load Name ...',
      duration: Duration(milliseconds: 10000),
    ));
    playbackState.add(baseState.copyWith(updatePosition: Duration(milliseconds: 100)));

    int pos = IsarCtl.cntntPstn;
    String contents = IsarCtl.contents.text;
    HistoryIsar history = IsarCtl.lastHistory!;
    SettingIsar setting = IsarCtl.setting!;

    await initTts();
    mediaItem.add(MediaItem(
      id: 'opentextView',
      album: '',
      title: '${history.name}',
      duration: Duration(seconds: contents.length),
    ));
    DateTime? lastTtsDate;

    tts!.setProgressHandler((text, start, end, word) {
      lastTtsDate = null;
    });

    for (var i = pos; i < contents.length;) {
      if (playstat != STAT_PLAY) break;
      var listContents = contents.substring(i, min(i + 3000, contents.length)).split("\n");

      int end = min(setting.groupcnt, listContents.length);
      String speakText = listContents.getRange(0, end).toList().join(" ");
      int nextPos = speakText.length;
      if (speakText.isEmpty) {
        nextPos += 1;
      }
      speakText = speakText.replaceAll(RegExp("X{2,}"), "ᄋ");
      speakText = speakText.replaceAll(RegExp("x{2,}"), "ᄋ");

      // contents.substring(i, end);

      // .join("\n");

      IsarCtl.filters.forEach((e) {
        if (e.enable) {
          if (e.expr) {
            speakText = speakText.replaceAllMapped(RegExp(e.filter), (match) => e.to);
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
            mediaItem.add(e!.copyWith(album: "Auto_shut_down_after_@min_minute".trParams({"min": ss.inMinutes.toString()})));
          }
        });
      }
      playbackState.add(baseState.copyWith(updatePosition: Duration(seconds: i)));

      history.cntntPstn = i;
      history.date = DateTime.now();
      IsarCtl.putHistory(history);
      // IsarCtl.cntntPstn = i;
      try {
        IsarCtl.tctl.offsetY = 0;
        IsarCtl.tctl.bHighlight = true;
        IsarCtl.tctl.highlightPos = i;
        IsarCtl.tctl.highlightCnt = nextPos;
      } catch (e) {}
      if (lastProgrss > 1 && speakText.length > lastProgrss && lastPos == i) {
        speakText = speakText.substring(lastProgrss - 1);
        lastProgrss = 0;
      }
      lastPos = i;
      // var bspeak = await tts?.speak(speakText);
      lastTtsDate = DateTime.now();
      Future.delayed(500.milliseconds, () async {
        if (lastTtsDate != null) {
          await stop();
          lastTtsDate = null;
          history.cntntPstn += 5;
          history.date = DateTime.now();
          IsarCtl.putHistory(history);
          await Future.delayed(300.milliseconds);
          await play();
          return;
        }
      });
      var bspeak = await tts?.speak(speakText);

      i += nextPos;

      if (bspeak == null) {
        stop();
      }

      if (i >= contents.length) {
        stop();
        break;
      }
    }
  }

  Future<void> pause() async {
    await tts?.pause();
    // session?.setActive(false);
    this.playbackState.add(baseState.copyWith(
          controls: [
            MediaControl.play,
            MediaControl.stop,
          ],
          androidCompactActionIndices: const [0, 1],
          processingState: AudioProcessingState.completed,
          updatePosition: Duration(milliseconds: IsarCtl.cntntPstn),
          playing: false,
        ));

    playstat = STAT_PAUSE;

    IsarCtl.tctl.bHighlight = false;

    super.pause();
  }

  Future<void> stop() async {
    await tts?.stop();
    // session?.setActive(false);
    this.playbackState.add(PlaybackState());
    playstat = STAT_STOP;
    IsarCtl.tctl.bHighlight = false;
    super.stop();
  }

  @override
  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == "autoExit" && extras != null) {
      this.autoExitDate = extras["autoExit"];
    }
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>clickclickclick>>>>>>>$button");
    // if (IsarCtl.setting?.headsetbutton ?? false) {
    //   if (playstat == STAT_PLAY) {
    //     pause();
    //   } else if (playstat == STAT_PAUSE) {
    //     play();
    //   }
    // }
    return super.click(button);
  }
}
