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

    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return
            // AlertDialog(
            //   actions: [
            //     IconButton(
            //       onPressed: () => Navigator.pop(dialogContext, null),
            //       icon: Icon(Icons.close),
            //     ),
            //   ],
            //   content: Container(
            //     width:
            //         min(popupWidth.toDouble(), MediaQuery.of(context).size.width),
            //     height:
            //         min(popupHeight.toDouble(), MediaQuery.of(context).size.height),
            //     child:
            flutterWebView.WebView(
          javascriptMode: flutterWebView.JavascriptMode.unrestricted,
          initialUrl: authorizationUrl,
          onPageFinished: (url) {
            if (url.startsWith(redirectUrl)) {
              Navigator.pop(dialogContext, url);
            }

            // ML: write the cookies to see if we can get them into app webviews
            var cookies = WebviewCookieManager().getCookies(null);
            print('COOKS: $cookies');
            // final storage = FlutterSecureStorage();
            // storage.write(key: 'kCookieKey', value: cookies);
          },
          onWebViewCreated: (webViewController) {
            //_controller.complete(webViewController);
            // webViewController.clearCache();
            // final cookieManager = CookieManager();
            // WebviewCookieManager().clearCookies();
          },
          //   ),
          // ),
          // title: Text(title),
        );
      },
    );

    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
