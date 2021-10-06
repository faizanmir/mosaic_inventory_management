/// message : "Successfully added category"
/// success : true

class CategoryResponse {
  CategoryResponse({
      String? message, 
      bool? success,}){
    _message = message;
    _success = success;
}

  CategoryResponse.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
  }
  String? _message;
  bool? _success;

  String? get message => _message;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}