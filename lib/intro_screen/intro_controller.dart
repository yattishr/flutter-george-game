import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../audio/audio_controller.dart';
import 'intro_george_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import '../style/palette.dart';
import '../settings/settings.dart';
import '../audio/sounds.dart';

class IntroController extends StatelessWidget {
  final IntroGeorgeGame game;
  IntroController({Key? key, required this.game}) : super(key: key);

  final TextPaint textPaint =
  TextPaint(style: const TextStyle(color: Colors.white, fontSize: 20));
  final countdown = Timer(2);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    return SafeArea(
      child: Container(
        color: Colors.black12, // Adjust opacity for desired darkness
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.introStoryLine1,
                style: TextStyle(
                  color: Colors.yellow.shade200,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.introStoryLine2,
                style: TextStyle(
                  color: Colors.yellow.shade200,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/george');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text(AppLocalizations.of(context)!.helpGeorgeButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}