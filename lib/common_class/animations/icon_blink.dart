import 'dart:async';
import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final Icon icon;
  final Duration duration;

  const BlinkingIcon({required this.icon, this.duration = const Duration(milliseconds: 1000), super.key});

  @override
  State<BlinkingIcon> createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon> {
  bool _visible = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Toggle visibility every duration
    _timer = Timer.periodic(widget.duration, (_) {
      if (!mounted) return;
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: widget.icon,
    );
  }
}
