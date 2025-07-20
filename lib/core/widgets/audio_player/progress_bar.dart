import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../utils/dimensions.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.player});

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, durationSnapshot) {
        final duration = durationSnapshot.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: player.positionStream,
          builder: (context, positionSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;
            final progress = duration.inMilliseconds == 0
                ? 0.0
                : position.inMilliseconds / duration.inMilliseconds;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingMedium,
                vertical: Dimensions.paddingSmall,
              ),
              child: LinearProgressIndicator(
                value: progress,
                color: Colors.green,
                backgroundColor: Colors.grey.shade300,
                minHeight: 6,
              ),
            );
          },
        );
      },
    );
  }
}
