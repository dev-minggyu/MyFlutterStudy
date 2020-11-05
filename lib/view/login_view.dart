import 'package:flutter/material.dart';
import 'package:flutter_dio/data/repository/repository.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Repository _repository = Repository();
  final _formKey = GlobalKey<FormState>();
  final _companyTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  String requiredFieldValidator(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: AutofillGroup(
        child: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(32.0), children: [
            SizedBox(height: 16),
            TextFormField(
              validator: requiredFieldValidator,
              controller: _companyTextController,
              autofillHints: [AutofillHints.username],
              decoration: InputDecoration(
                labelText: 'Company',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextFormField(
              validator: requiredFieldValidator,
              controller: _usernameTextController,
              autofillHints: [AutofillHints.username],
              decoration: InputDecoration(
                labelText: 'Username',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextFormField(
              validator: requiredFieldValidator,
              controller: _passwordTextController,
              autofillHints: [AutofillHints.password],
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) return;
                var loginResult = _repository.login(
                    'smk513', 'smk513', 2, '', 'Test Device', 'A');
                // setState(() {
                //   _loginFuture = _handleLogin(context);
                // });
              },
              child: const Text('Login'),
            )
          ]),
        ),
      ),
    );
  }
}
