import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/forgot_password/bloc/bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 0) {
      bottomPadding = UISpacing.space4x;
    }

    final form = context.read<ForgotPasswordBloc>().form;

    final buttonsProvider = Theme.of(context).buttonStyles;
    final iconProvider = Theme.of(context).icons;
    final inputsProvider = Theme.of(context).inputStyles;

    final isSendingEmail = context.select(
      (ForgotPasswordBloc bloc) => bloc.state.isSendingEmail,
    );

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgotPassword_title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: Column(
                children: [
                  const SizedBox(height: UISpacing.space8x),
                  Hero(
                    tag: 'logo',
                    child: iconProvider.logo(size: UISpacing.space34x),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        const SizedBox(height: UISpacing.space4x),
                        ReactiveTextField<String>(
                          keyboardType: TextInputType.emailAddress,
                          formControlName: 'email',
                          textInputAction: TextInputAction.next,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.email,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: UISpacing.space4x,
                right: UISpacing.space4x,
                top: UISpacing.space4x,
                bottom: bottomPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.filled,
                      isLoading: isSendingEmail,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<ForgotPasswordBloc>()
                            .add(SendForgotPasswordEmail());
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
