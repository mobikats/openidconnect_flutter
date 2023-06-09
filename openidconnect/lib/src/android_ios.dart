part of openidconnect;

class OpenIdConnectAndroidiOS {
  static Future<String> authorizeInteractive({
    required BuildContext context,
    required String title,
    required String authorizationUrl,
    required String redirectUrl,
    required int popupWidth,
    required int popupHeight,
  }) async {
    //Create the url
    // final _controller = Completer<flutterWebView.WebViewController>();
    // String email = '';
    // String password = '';

    // final javascriptCode = '''
    //   document.getElementById('username').value = '$email';
    //   document.getElementById('password').value = '$password';
    // ''';
    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AuthorizationWebView();
        // return flutterWebView.WebView(
        //   javascriptMode: flutterWebView.JavascriptMode.unrestricted,
        //   initialUrl: authorizationUrl,
        //   onWebViewCreated:
        //       (flutterWebView.WebViewController webViewController) {
        //     _controller.complete(webViewController);
        //   },
        //   onPageFinished: (String url) {
        //     if (url.startsWith(redirectUrl)) {
        //       Navigator.pop(dialogContext, url);
        //       return;
        //     }
        //     _controller.future.then((controller) {
        //       controller.runJavascript(javascriptCode);
        //     });
        //   },
        // );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
