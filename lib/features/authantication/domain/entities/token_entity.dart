import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  final String token;
  final String refreshToken;

  const TokenEntity({
    required this.token,
    required this.refreshToken,
  });

  // tokenEntityFromJson
  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
      token: json['access'],
      refreshToken: json['refresh'],
    );
  }

  // tokenEntityToJson
  Map<String, dynamic> toJson() {
    return {
      'access': token,
      'refresh': refreshToken,
    };
  }

  @override
  List<Object?> get props => [token, refreshToken];
}
