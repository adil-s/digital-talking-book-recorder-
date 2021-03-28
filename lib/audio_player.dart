import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String path;

  const AudioPlayer({
    required this.path,
  });

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));
    _init();

    super.initState();
  }

  Future<void> _init() async {
    await _audioPlayer.setFilePath(widget.path);
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end, children: [_buildSlider()]),
      bottomNavigationBar: BottomAppBar(
        child: _buildControl(),
      ),
    );
  }

  Widget _buildControl() {
    Icon icon;
    late Color color;

    if (_audioPlayer.playerState.playing) {
      icon = Icon(Icons.pause,
          semanticLabel: "pause", color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow,
          semanticLabel: "play", color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.fast_rewind,
            semanticLabel: "rewind ",
          ),
          onPressed: () {
            Duration currentPosition = _audioPlayer.position;
            Duration rewindDuration = Duration(seconds: 10, minutes: 0);
            currentPosition = currentPosition - rewindDuration;
            _audioPlayer.seek(currentPosition);
          },
        ),
        IconButton(
          icon: icon,
          onPressed: () {
            if (_audioPlayer.playing) {
              _audioPlayer.pause();
            } else {
              _audioPlayer.play();
            }
          },
        ),
        IconButton(
          onPressed: () {
            Duration currentPosition = _audioPlayer.position;
            Duration forwardDuration = Duration(seconds: 10, minutes: 0);
            currentPosition = currentPosition + forwardDuration;
            _audioPlayer.seek(currentPosition);
          },
          icon: Icon(
            Icons.forward_rounded,
            semanticLabel: "forward",
          ),
        )
      ],
    );
  }

  Widget _buildSlider() {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Slider(
            label: "play",
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).accentColor,
            onChanged: (v) {
              if (duration != null) {
                final position = v * duration.inMilliseconds;
                _audioPlayer.seek(Duration(milliseconds: position.round()));
              }
            },
            value: canSetValue && duration != null
                ? position.inMilliseconds / duration.inMilliseconds
                : 0.0,
          ),
        ),
      ],
    );
  }

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
}
