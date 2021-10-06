

import 'default_response.dart';

/// timestamp : "2021-10-05T08:08:07.604+00:00"
/// status : 403
/// error : "Forbidden"
/// path : "/auth/login/"

class ApiError extends DefaultResponse {
  ApiError({
      String? timestamp, 
      int? status, 
      String? error, 
      String? path,}){
    _timestamp = timestamp;
    _status = status;
    _error = error;
    _path = path;
}

  ApiError.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _error = json['error'];
    _path = json['path'];
  }
  String? _timestamp;
  int? _status;
  String? _error;
  String? _path;

  String? get timestamp => _timestamp;
  int? get status => _status;
  String? get error => _error;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['error'] = _error;
    map['path'] = _path;
    return map;
  }

}