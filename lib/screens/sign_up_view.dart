import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'error_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmationCodeController = TextEditingController();

  String _signUpError = "";
  bool _isSignedUp = false;

  @override
  void initState() {
    super.initState();
  }

  void _signUp() async {
    setState(() {
      _signUpError = "";
    });

    Map<String, String> userAttributes = {
      "email": emailController.text,
      "phone_number": phoneController.text,
    };
    try {
      SignUpResult res = await Amplify.Auth.signUp(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          options: CognitoSignUpOptions(userAttributes: userAttributes));

      setState(() {
        _isSignedUp = true;
      });
    } on AuthException catch (error) {
      _setError(error);
    }
  }

  void _confirmSignUp() async {
    setState(() {
      _signUpError = "";
    });

    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: usernameController.text.trim(),
          confirmationCode: confirmationCodeController.text.trim());
      Navigator.pop(context, true);
    } on AuthException catch (error) {
      _setError(error);
    }
  }

  void _setError(AuthException error) {
    setState(() {
      _signUpError = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          // wrap your Column in Expanded
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Visibility(
                  visible: !_isSignedUp,
                  child: Column(children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Email',
                        labelText: 'Email *',
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                        labelText: 'Password *',
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Phone number (Country Code)',
                        labelText: 'Phone number *',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign Up'),
                    ),
                  ]),
                ),
                Visibility(
                    visible: _isSignedUp,
                    child: Column(children: [
                      TextFormField(
                          controller: confirmationCodeController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.confirmation_number),
                            hintText: 'Check your Email',
                            labelText: 'Confirmation Code *',
                          )),
                      ElevatedButton(
                        onPressed: _confirmSignUp,
                        child: const Text('Confirm Sign Up'),
                      ),
                    ])),
                const Padding(padding: EdgeInsets.all(10.0)),
                ErrorView(_signUpError)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
