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
    bool loggedIn = false;
    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return flutterWebView.WebView(
          javascriptMode: flutterWebView.JavascriptMode.unrestricted,
          initialUrl: authorizationUrl,
          onPageFinished: (url) {
            if (url.startsWith(redirectUrl)) {
              Navigator.pop(dialogContext, url);
              return;
            }
//             setState(() {
            print("loggedin " + loggedIn.toString());

            if(loggedIn == false) {
              loggedIn = true;
                _controller.future
                    .then((value) =>
                    value.evaluateJavascript('''
                     var email = document.getElementById("CustomerEmail");
                     var password = document.getElementById("CustomerPassword");
                     email.value = "user@gmail.com";
                     password.value = "test123";
                  //   document.getElementById('customer_login').submit();
                   '''));
              }
//             });
          },
        );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
