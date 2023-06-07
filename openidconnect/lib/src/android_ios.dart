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
  bool loggedin = false;
    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(dialogContext, null),
              icon: Icon(Icons.close),
            ),
          ],
          content: Container(
            width:
                min(popupWidth.toDouble(), MediaQuery.of(context).size.width),
            height:
                min(popupHeight.toDouble(), MediaQuery.of(context).size.height),
            child: flutterWebView.WebView(
              javascriptMode: flutterWebView.JavascriptMode.unrestricted,
              initialUrl: authorizationUrl,
            if (url.startsWith(redirectUrl)) {
              Navigator.pop(dialogContext, url);
              return;
            }
                    setState(() {
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

                      
                    });
                  },
            ),
          ),
          title: Text(title),
        );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
