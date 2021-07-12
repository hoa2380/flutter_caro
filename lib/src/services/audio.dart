import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class Audio {
  static AudioCache player = AudioCache();

  static Future<dynamic> init() async {
    await player.loadAll([
      'audio/x.wav',
      'audio/o.wav',
      'audio/victory.wav',
      'audio/audio_bg.wav',
      'audio/xo.wav',
    ]);
  }

  static playAsset(AudioType audioType) {
    player.play('audio/${describeEnum(audioType)}.wav');
  }

  static play() async {
    AudioPlayer player = AudioPlayer();
    await player.play('assets/audio/audio_bg.wav', isLocal: true);
  }
}

enum AudioType {
  x,
  o,
  victory,
  xo,
}