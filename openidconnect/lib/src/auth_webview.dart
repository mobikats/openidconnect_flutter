import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthorizationWebView extends StatefulWidget {
  final String initialUrl;

  AuthorizationWebView({required this.initialUrl});

  @override
  _AuthorizationWebViewState createState() => _AuthorizationWebViewState();
}

class _AuthorizationWebViewState extends State<AuthorizationWebView> {
  InAppWebViewController? _webViewController;
  final _controllerCompleter = Completer<InAppWebViewController>();
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    getEmailFromStorage().then((value) {
      setState(() {
        email = value ?? '';
      });
    });

    getPasswordFromStorage().then((value) {
      setState(() {
        password = value ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorization WebView'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.initialUrl)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          _controllerCompleter.complete(controller);

          injectJavaScript();
        },
        onConsoleMessage: (controller, consoleMessage) {
          print('Console Message: ${consoleMessage.message}');
        },
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }

  void injectJavaScript() async {
    await _webViewController?.evaluateJavascript(
      source: '''
        var email = '$email';
        var password = '$password';

        setTimeout(function() {
          var emailInput = document.getElementById('email');
          var passwordInput = document.getElementById('password');

          if (emailInput && passwordInput) {
            emailInput.value = email;
            passwordInput.value = password;
          }
        }, 100);
      ''',
    );
  }
}

final _storage = FlutterSecureStorage();

Future<String?> getEmailFromStorage() async {
  return await _storage.read(key: 'email');
}

Future<void> saveEmailToStorage(String email) async {
  await _storage.write(key: 'email', value: email);
}

Future<String?> getPasswordFromStorage() async {
  return await _storage.read(key: 'password');
}

Future<void> savePasswordToStorage(String password) async {
  await _storage.write(key: 'password', value: password);
}
