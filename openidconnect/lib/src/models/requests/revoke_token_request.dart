part of openidconnect;

enum TokenType { idToken, accessToken }

class RevokeTokenRequest {
  final OpenIdConfiguration configuration;
  final String token;
  final TokenType tokenType;
  final String clientId;
  final String clientSecret;

  const RevokeTokenRequest({
    required this.configuration,
    required this.token,
    required this.tokenType,
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, String> toMap() => {
        "token": token,
        "token_type_hint": tokenType == TokenType.accessToken
            ? "access_token"
            : "refresh_token",
        "client_id": clientId,
        "client_secret": clientSecret,
      };
}
