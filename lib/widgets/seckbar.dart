// import 'dart:math';

// import 'package:flutter/material.dart';

// class SeckBarData {
//   //where am i standing with the audio
//   final Duration position;
//   //audio clip length
//   final Duration duration;

//   SeckBarData(this.position, this.duration);
// }

// class SeckBar extends StatefulWidget {
//   final Duration position;
//   final Duration duration;
//   final ValueChanged<Duration>? onChanged;
//   final ValueChanged<Duration>? onChangedEnd;

//   const SeckBar(
//       {super.key,
//       required this.position,
//       required this.duration,
//       this.onChanged,
//       this.onChangedEnd});

//   @override
//   State<SeckBar> createState() => _SeckBarState();
// }

// class _SeckBarState extends State<SeckBar> {
//   double? _dragValue;
//   String _formatDuration(Duration? duration) {
//     if (duration == null) {
//       return "--:--";
//     } else {
//       String minutes = duration.inMilliseconds.toString().padLeft(2, "0");
//       String second =
//           duration.inSeconds.remainder(60).toString().padLeft(2, "0");
//       return "$minutes:$second";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(_formatDuration(widget.position)),
//         Expanded(
//           child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                   trackHeight: 4,
//                   thumbShape: const RoundSliderThumbShape(
//                       disabledThumbRadius: 4, enabledThumbRadius: 4),
//                   overlayShape:
//                       const RoundSliderOverlayShape(overlayRadius: 10),
//                   activeTrackColor: Colors.white.withOpacity(0.2),
//                   inactiveTickMarkColor: Colors.white,
//                   thumbColor: Colors.white,
//                   overlayColor: Colors.white),
//               child: Slider(
//                 min: 0.0,
//                 max: widget.duration.inMilliseconds.toDouble(),
//                 value: min(
//                     _dragValue ?? widget.position.inMilliseconds.toDouble(),
//                     widget.duration.inMilliseconds.toDouble()),
//                 onChanged: (value) {
//                   setState(() {
//                     _dragValue = value;
//                   });
//                   if (widget.onChanged != null) {
//                     widget.onChanged!(Duration(milliseconds: value.round()));
//                   }
//                 },
//                 onChangeEnd: (value) {
//                   if (widget.onChangedEnd != null) {
//                     widget.onChanged!(Duration(milliseconds: value.round()));
//                   }
//                   _dragValue = null;
//                 },
//               )),
//         ),
//         Text(_formatDuration(widget.duration)),
//       ],
//     );
//   }
// }
