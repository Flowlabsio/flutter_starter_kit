import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/home/bloc/bloc.dart';
import 'package:app_initial/src/features/profile/views/views.dart';
import 'package:app_initial/src/features/settings/views/views.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final buttonsProvider = Theme.of(context).buttonStyles;

    final userName = context.select((HomeBloc bloc) => bloc.state.userName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName.isNotEmpty ? l10n.home_welcomeUser(userName) : l10n.home,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () {
                context.pushNamed(ProfileScreen.path);
              },
              child: Text(l10n.profile),
            ),
            const SizedBox(height: UISpacing.space1x),
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () {
                context.pushNamed(SettingsScreen.path);
              },
              child: Text(l10n.settings),
            ),
          ],
        ),
      ),
    );
  }
}
