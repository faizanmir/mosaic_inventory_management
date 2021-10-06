

import 'default_response.dart';

class LoginModel extends DefaultResponse{
   String _message;
   bool _success;
   String _jwtToken;


   String get message => _message; //<editor-fold desc="Data Methods">

  LoginModel({
    required String message,
    required bool success,
    required String jwtToken,
  })  : _message = message,
        _success = success,
        _jwtToken = jwtToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginModel &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _success == other._success &&
          _jwtToken == other._jwtToken);

  @override
  int get hashCode =>
      _message.hashCode ^ _success.hashCode ^ _jwtToken.hashCode;

  @override
  String toString() {
    return 'LoginModel{' +
        ' _message: $_message,' +
        ' _success: $_success,' +
        ' _jwtToken: $_jwtToken,' +
        '}';
  }

  LoginModel copyWith({
    String? message,
    bool? success,
    String? jwtToken,
  }) {
    return LoginModel(
      message: message ?? this._message,
      success: success ?? this._success,
      jwtToken: jwtToken ?? this._jwtToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_message': this._message,
      '_success': this._success,
      '_jwtToken': this._jwtToken,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      message: map['message'] as String,
      success: map['success'] as bool,
      jwtToken: map['jwtToken'] as String,
    );
  }

   bool get success => _success;

   String get jwtToken => _jwtToken;

//</editor-fold>
}