import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../lit_firebase_auth.dart';
import 'widgets/loading.dart';

class StandardSignInWidget extends StatelessWidget {
  const StandardSignInWidget({
    Key key,
    this.config,
  }) : super(key: key);

  final AuthConfig config;

  static const maxWidth = 500.0;

  @override
  Widget build(BuildContext context) {
    final authProviders = context.watch<AuthProviders>();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Column(
          children: [
            config?.title ?? _title(context),
            const SizedBox(height: 16),
            if (authProviders.emailAndPassword)
              SignInForm(
                child: Column(
                  children: [
                    EmailTextFormField(
                      style: config?.emailTextField?.style,
                      decoration: config?.emailTextField?.inputDecoration,
                    ),
                    const SizedBox(height: 8),
                    PasswordTextFormField(
                      style: config?.passwordTextField?.style,
                      decoration: config?.passwordTextField?.inputDecoration,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EmailAndPasswordSignInButton(
                            config: config?.signInButton,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EmailAndPasswordRegisterButton(
                            config: config?.registerButton,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'or',
              style: Theme.of(context).textTheme.overline,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const Divider(
                thickness: 2,
              ),
            ),
            if (authProviders.anonymous)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SignInAnonymouslyButton(config: config?.anonymousButton),
              ),
            if (authProviders.google)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4285F4),
                      padding: EdgeInsets.fromLTRB(1, 1, 8, 1)),
                  onPressed: context.signInWithGoogle,
                  icon: Container(
                      height: defaultButtonHeight - 1,
                      width: defaultButtonHeight - 1,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: LitAuthIcon.google(),
                      )),
                  label: Text(SignInWithGoogleButton.defaultLabel),
                ),
              ),
            if (authProviders.apple)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.fromLTRB(8, 8, 16, 8)),
                    onPressed: context.signInWithApple,
                    icon: LitAuthIcon.appleWhite(),
                    label: Text(SignInWithAppleButton.defaultLabel)),
              ),
            if (authProviders.github)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SignInWithGithubButton(
                  config: config?.githubButton,
                ),
              ),
            if (authProviders.twitter)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SignInWithTwitterButton(
                  config: config?.twitterButton,
                ),
              ),
            const LoadingWidget(),
          ],
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      'Sign in / Register',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
