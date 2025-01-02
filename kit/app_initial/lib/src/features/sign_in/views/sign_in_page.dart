import 'dart:io';

import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/sign_in/bloc/bloc.dart';
import 'package:app_initial/src/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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

    final form = context.read<SignInBloc>().form;

    final buttonsProvider = Theme.of(context).buttonStyles;
    final colorsProvider = Theme.of(context).colors;
    final iconProvider = Theme.of(context).icons;
    final inputsProvider = Theme.of(context).inputStyles;

    final isSingingWithEmailAndPassword = context.select(
      (SignInBloc bloc) => bloc.state.isSingingWithEmailAndPassword,
    );

    final isSingingWithGoogle = context.select(
      (SignInBloc bloc) => bloc.state.isSingingWithGoogle,
    );

    final isSingingWithApple = context.select(
      (SignInBloc bloc) => bloc.state.isSingingWithApple,
    );

    final l10n = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: Column(
                children: [
                  SizedBox(height: topPadding),
                  const SizedBox(height: UISpacing.space8x),
                  Hero(
                    tag: 'logo',
                    child: iconProvider.logo(size: UISpacing.space34x),
                  ),
                  const SizedBox(height: UISpacing.space8x),
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        ReactiveTextField<String>(
                          keyboardType: TextInputType.emailAddress,
                          formControlName: 'email',
                          textInputAction: TextInputAction.next,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.email,
                          ),
                        ),
                        const SizedBox(height: UISpacing.space4x),
                        ReactivePasswordField(
                          formControlName: 'password',
                          textInputAction: TextInputAction.done,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.password,
                          ),
                        ),
                        const SizedBox(height: UISpacing.space4x),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(l10n.forgotMyPassword),
                              onPressed: () {
                                context
                                    .read<SignInBloc>()
                                    .add(ForgotPassword());
                              },
                            ),
                          ],
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
                      isLoading: isSingingWithEmailAndPassword,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<SignInBloc>()
                            .add(SignInWithEmailAndPassword());
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.signIn),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.outlined,
                      onPressed: () {
                        context.read<SignInBloc>().add(SignUpAccount());
                      },
                      style: buttonsProvider.primaryOutline,
                      child: Text(l10n.signUp),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space8x),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: colorsProvider.onSurface,
                        ),
                      ),
                      const SizedBox(width: UISpacing.space3x),
                      Text(l10n.or),
                      const SizedBox(width: UISpacing.space3x),
                      Expanded(
                        child: Divider(
                          color: colorsProvider.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UISpacing.space8x),
                  if (Platform.isIOS || Env.appleServiceId.isNotEmpty) ...[
                    SizedBox(
                      width: UISpacing.infinity,
                      child: LoadingButton(
                        type: ButtonType.outlined,
                        isLoading: isSingingWithApple,
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(SignInWithAppleAccount());
                        },
                        style: buttonsProvider.primaryOutline,
                        loaderColor: colorsProvider.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconProvider.apple(),
                            const SizedBox(width: UISpacing.space2x),
                            Text(l10n.signInWithApple),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: UISpacing.space4x),
                  ],
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.outlined,
                      isLoading: isSingingWithGoogle,
                      onPressed: () {
                        context
                            .read<SignInBloc>()
                            .add(SignInWithGoogleAccount());
                      },
                      style: buttonsProvider.primaryOutline,
                      loaderColor: colorsProvider.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconProvider.google(),
                          const SizedBox(width: UISpacing.space2x),
                          Text(l10n.signInWithGoogle),
                        ],
                      ),
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
