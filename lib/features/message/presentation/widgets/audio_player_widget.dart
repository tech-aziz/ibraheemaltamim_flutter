import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final bool isMe;

  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
    required this.isMe,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    if (widget.audioUrl.startsWith('http')) {
      await _audioPlayer.setSource(UrlSource(widget.audioUrl));
    } else {
      await _audioPlayer.setSource(DeviceFileSource(widget.audioUrl));
    }

    // Try fetching duration multiple times with increasing delays
    _fetchDurationWithRetry();

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted && duration != Duration.zero) {
        setState(() => _duration = duration);
      }
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
          // Update duration if position exceeds it (fallback for streaming)
          if (p > _duration) {
            _duration = p;
          }
        });

        // Continuously try to fetch the actual duration during playback if it's still unknown
        if (_duration == Duration.zero || _duration == _position) {
          _audioPlayer.getDuration().then((duration) {
            if (duration != null && duration != Duration.zero && mounted) {
              setState(() => _duration = duration);
            }
          });
        }
      }
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _playerState = PlayerState.stopped;
          _position = Duration.zero;
        });
      }
    });

    _playerStateChangeSubscription = _audioPlayer.onPlayerStateChanged.listen((
      state,
    ) async {
      if (mounted) {
        setState(() => _playerState = state);
        // Try fetching duration again when state changes
        if (state != PlayerState.stopped && _duration == Duration.zero) {
          final d = await _audioPlayer.getDuration();
          if (d != null && mounted) {
            setState(() => _duration = d);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _fetchDurationWithRetry() async {
    for (int i = 0; i < 5; i++) {
      if (!mounted || (_duration != Duration.zero)) break;
      await Future.delayed(Duration(milliseconds: 500 * (i + 1)));
      final d = await _audioPlayer.getDuration();
      if (d != null && d != Duration.zero && mounted) {
        setState(() => _duration = d);
        break;
      }
    }
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (widget.audioUrl.startsWith('http')) {
        await _audioPlayer.play(UrlSource(widget.audioUrl));
      } else {
        await _audioPlayer.play(DeviceFileSource(widget.audioUrl));
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (hours > 0) {
      return "${twoDigits(hours)}:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isMe ? Colors.white : const Color(0xff000066);
    final activeColor = widget.isMe ? Colors.white : const Color(0xff000066);
    final inactiveColor = widget.isMe
        ? Colors.white54
        : const Color(0xFF8896A6);

    return Container(
      width: 220.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _playPause,
            child: CircleAvatar(
              backgroundColor: activeColor.withOpacity(0.1),
              radius: 18.r,
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: activeColor,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 3.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
                  ),
                  child: Builder(
                    builder: (context) {
                      double maxDuration = _duration.inMilliseconds > 0
                          ? _duration.inMilliseconds.toDouble()
                          : 1.0;
                      double currentPosition = _position.inMilliseconds
                          .toDouble()
                          .clamp(0.0, maxDuration);
                      return Slider(
                        value: currentPosition,
                        max: maxDuration,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor.withOpacity(0.3),
                        onChanged: (value) async {
                          final position = Duration(
                            milliseconds: value.toInt(),
                          );
                          await _audioPlayer.seek(position);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: textColor.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: textColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
