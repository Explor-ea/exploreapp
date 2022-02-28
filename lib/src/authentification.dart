import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:exploreapp/wigets/explorea-btn.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:exploreapp/wigets/explorea_btn_square.dart';
import 'package:flutter/material.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
  emailAddress,
  register,
  password,
}

class Authentification extends StatelessWidget {
  const Authentification({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
    //
    this.nextPage,
  });

  final ApplicationLoginState loginState;
  //
  final String? email;
  //
  final void Function() startLoginFlow;
  //
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  //
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  //
  final void Function() cancelRegistration;
  //
  final void Function(
    String email,
    // String displayName, // There will be no personal pseudo in Explor'ea
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  //
  final void Function() signOut;
  //
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Column(
          children: [
            ExploreaTitle(text: "Connexion"),
            ExploreaBtnSquare(
                text: "Se connecter",
                onPressed: () {
                  startLoginFlow();
                }),
          ],
        );

      case ApplicationLoginState.emailAddress:
        return Column(
          children: [
            ExploreaTitle(text: "Connexion"),
            ExploreaEmailForm(
                callback: (email) => verifyEmail(email,
                    (e) => _showErrorDialog(context, "Email invalide", e))),
          ],
        );

      case ApplicationLoginState.password:
        return Column(
          children: [
            ExploreaTitle(text: "Connexion"),
            ExploreaPasswordForm(
              cancel: () {
                cancelRegistration();
              },
              email: email!,
              login: (email, password) {
                signInWithEmailAndPassword(
                    email,
                    password,
                    (exc) => _showErrorDialog(
                        context, "Impossible de se connecter", exc));
              },
            ),
          ],
        );

      case ApplicationLoginState.register:
        return Column(
          children: [
            ExploreaTitle(text: "Inscription"),
            RegisterForm(
              email: this.email!,
              registerAccount: (email, password) {
                registerAccount(
                    email,
                    password,
                    (exc) => _showErrorDialog(
                        context, "Erreur lors de la création de compte", exc));

                if (this.nextPage != null) {
                  pushReplaceToNextPage(context, nextPage!);
                }
              },
              cancel: () {
                cancelRegistration();
              },
            ),
          ],
        );

      case ApplicationLoginState.loggedIn:
        return Column(
          children: [
            ExploreaTitle(text: "Connecté"),
            ExploreaText(
                text: this.email != null ? this.email.toString() : "??"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExploreaBtnSquare(
                      text: "Déconnexion",
                      onPressed: () {
                        signOut();
                      }),
                ),
                if (this.nextPage != null)
                  ExploreaBtn(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      if (this.nextPage != null && this.email != null) {
                        pushReplaceToNextPage(context, nextPage!);
                      }
                    },
                    disabled: this.email == null,
                  ),
              ],
            ),
          ],
        );

      default:
        return const Text("Une erreur inhabituelle est survenue");
    }
  }

  /// TODO: there should be an Explor'ea dialog
  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

//
// Email forms :

// class EmailForm extends StatefulWidget {
//   const EmailForm({required this.callback});

//   final void Function(String email) callback;

//   @override
//   _EmailFormState createState() => _EmailFormState();
// }

// class _EmailFormState extends State<EmailForm> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
//   final _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Expanded(
//         child: Column(
//           children: [
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               controller: _controller,
//               decoration: const InputDecoration(
//                 hintText: "Enter your email",
//               ),
//               validator: (value) {
//                 return value!.isEmpty ? "Renseignez votre email" : null;
//               },
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     widget.callback(_controller.text);
//                   }
//                 },
//                 child: const Text("Continuer"))
//           ],
//         ),
//       ),
//     );
//   }
// }

class ExploreaEmailForm extends StatefulWidget {
  const ExploreaEmailForm({required this.callback});

  final void Function(String email) callback;

  @override
  _ExploreaEmailFormState createState() => _ExploreaEmailFormState();
}

class _ExploreaEmailFormState extends State<ExploreaEmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ExploreaEmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: [
            ExploreaEmailField(
              controller: _controller,
              onFieldSubmitted: (unusedValue) async {
                if (_formKey.currentState!.validate()) {
                  widget.callback(_controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreaEmailField extends StatelessWidget {
  const ExploreaEmailField({Key? key, this.controller, this.onFieldSubmitted})
      : super(key: key);

  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ExploreaColors.purple,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      style: TextStyle(
        color: ExploreaColors.purple,
        decorationColor: ExploreaColors.purple,
      ),
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: ExploreaColors.purple,
        )),
        focusColor: ExploreaColors.purple,
        fillColor: ExploreaColors.purple,
        hintText: "E-mail",
        prefixIcon: Icon(
          Icons.mail_outline,
          color: ExploreaColors.purple,
        ),
      ),
      validator: (value) {
        return value!.isEmpty ? "Renseignez votre email" : null;
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

// Email forms
//

//
// Password forms

class ExploreaPasswordForm extends StatefulWidget {
  const ExploreaPasswordForm({
    required this.email,
    required this.login,
    required this.cancel,
  });

  final String email;
  final void Function(String email, String password) login;
  final void Function() cancel;

  @override
  _ExploreaPasswordFormState createState() => _ExploreaPasswordFormState();
}

class _ExploreaPasswordFormState extends State<ExploreaPasswordForm> {
  final _formKey =
      GlobalKey<FormState>(debugLabel: '_ExploreaPasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Expanded(
          child: Column(
            children: [
              ExploreaEmailField(
                controller: _emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ExploreaColors.purple,
                    ),
                  ),
                  focusColor: ExploreaColors.purple,
                  fillColor: ExploreaColors.purple,
                  hintText: "Mot de passe",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: ExploreaColors.purple,
                  ),
                ),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  return value!.isEmpty ? "Entrez votre mot de passe" : null;
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreaBtnSquare(
                        text: "Annuler", onPressed: widget.cancel),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreaBtnSquare(
                        text: "Connexion",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.login(_emailController.text,
                                _passwordController.text);
                          }
                        }),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

// class PasswordForm extends StatefulWidget {
//   const PasswordForm({
//     required this.email,
//     required this.login,
//   });

//   final String email;
//   final void Function(String email, String password) login;

//   @override
//   _PasswordFormState createState() => _PasswordFormState();
// }

// class _PasswordFormState extends State<PasswordForm> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _emailController.text = widget.email;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Expanded(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   hintText: "Entrez votre email",
//                 ),
//                 validator: (value) {
//                   return value!.isEmpty ? "Entrez votre address email" : null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                     hintText: "Entrez votre mot de passe"),
//                 obscureText: true,
//                 validator: (value) {
//                   return value!.isEmpty ? "Entrez votre mot de passe" : null;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     widget.login(
//                         _emailController.text, _passwordController.text);
//                   }
//                 },
//                 child: const Text("Connexion"),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// Password forms
//

//

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.email,
    required this.registerAccount,
    required this.cancel,
  });

  final String email;
  final void Function(String email, String password) registerAccount;
  final void Function() cancel;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  // final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: [
            ExploreaEmailField(controller: _emailController),

            // TODO: add second password to check
            TextFormField(
              // style: TextStyle(
              //   color: ExploreaColors.purple,
              //   decorationColor: ExploreaColors.purple,
              // ),

              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ExploreaColors.purple,
                  ),
                ),
                focusColor: ExploreaColors.purple,
                fillColor: ExploreaColors.purple,
                hintText: "Mot de passe",
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: ExploreaColors.purple,
                ),
              ),

              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                return value!.isEmpty ? "Entrez votre mot de passe" : null;
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExploreaBtnSquare(
                      text: "Annuler", onPressed: widget.cancel),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExploreaBtnSquare(
                    text: "Créer un compte",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.registerAccount(
                            _emailController.text, _passwordController.text);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
