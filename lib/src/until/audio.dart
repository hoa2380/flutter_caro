import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class Audio {
  static AudioCache player = AudioCache();

  static Future<dynamic> init() async {
    await player.loadAll([
      'audio/x.wav',
      'audio/o.wav',
      'audio/victory.wav'
    ]);
  }

  static playAsset(AudioType audioType) {
    player.play('audio/${describeEnum(audioType)}.wav');
  }

  // static play() async {
  //   AudioPlayer player = AudioPlayer();
  //   await player.play('assets/audio/swap.wav', isLocal: true);
  // }
}

enum AudioType {
  x,
  o,
  victory,
}