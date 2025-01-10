import 'dart:async';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class TimeTracker extends StatefulWidget {
  final Duration duration;
  final Function()? onStart;
  final Function(Duration)? onStop;
  final bool initiallyStart;

  const TimeTracker({
    super.key,
    required this.duration,
    this.onStart,
    this.onStop,
    this.initiallyStart = false,
  });

  @override
  State<TimeTracker> createState() => _TimeTrackerState();
}

class _TimeTrackerState extends State<TimeTracker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer;
  late Duration _elapsedTime;
  bool _isRunning = false;
  late String _currentTime;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: kDefaultDuration);
    _elapsedTime = widget.duration;
    _currentTime = _formatDuration(_elapsedTime);
    super.initState();

    if (widget.initiallyStart) {
      _startTimer();
    }
  }

  void _startTimer() {
    widget.onStart?.call();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
        _currentTime = _formatDuration(_elapsedTime);
      });
    });
    _animationController.forward();
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    widget.onStop?.call(_elapsedTime);
    _animationController.reverse();
    setState(() {
      _isRunning = false;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: theme.colorScheme.primary.withOpacity(0.1),
        ),
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 36,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _animationController,
                  color: theme.colorScheme.primary,
                ),
                padding: const EdgeInsets.all(0),
                onPressed: _toggleTimer,
              ),
            ),
            Text(
              _currentTime,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    fontSize: 14,
                    color: theme.colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
