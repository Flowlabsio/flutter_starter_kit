import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/lock/bloc/bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockPage extends StatelessWidget {
  const UnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 0) {
      bottomPadding = UISpacing.space4x;
    }

    var topPadding = MediaQuery.of(context).padding.top;
    if (topPadding == 0) {
      topPadding = UISpacing.space4x;
    }

    final buttonsProvider = Theme.of(context).buttonStyles;
    final colorsProvider = Theme.of(context).colors;
    final textProvider = Theme.of(context).textStyles;

    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: topPadding),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(UISpacing.space4x),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorsProvider.onPrimary,
                      ),
                      child: Icon(
                        Icons.lock_outlined,
                        size: UISpacing.space20x,
                        color: colorsProvider.primary,
                      ),
                    ),
                    const SizedBox(height: UISpacing.space2x),
                    Text(
                      l10n.lock_title,
                      style: textProvider.headlineSmall,
                    ),
                    const SizedBox(height: UISpacing.space2x),
                    Text(
                      l10n.lock_description,
                      style: textProvider.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: SizedBox(
                width: UISpacing.infinity,
                child: LoadingButton(
                  type: ButtonType.filled,
                  onPressed: () {
                    context.read<LockBloc>().add(LockApp());
                  },
                  style: buttonsProvider.primaryFilled,
                  child: Text(l10n.lock_button),
                ),
              ),
            ),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}
