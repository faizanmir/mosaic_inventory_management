/// categories : [{"id":82,"categoryName":"generic-category-name-2-2-2--7-8-6-2-4","requiresAction":false},{"id":83,"categoryName":"generic-category-name-2-2-2--7-8-6-2-4","requiresAction":false},{"id":84,"categoryName":"generic-category-name-2-2-2--7-8-6-2-4","requiresAction":false}]
/// success : true
/// message : "Successfully fetched categories"

class UserCategoryResponse {
  UserCategoryResponse({
    List<Category>? categories,
    bool? success,
    String? message,
  }) {
    _categories = categories;
    _success = success;
    _message = message;
  }

  UserCategoryResponse.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Category.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Category>? _categories;
  bool? _success;
  String? _message;

  List<Category>? get categories => _categories;
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }
}

/// id : 82
/// categoryName : "generic-category-name-2-2-2--7-8-6-2-4"
/// requiresAction : false

class Category {
  Category({
    int? id,
    String? categoryName,
    bool? requiresAction,
  }) {
    _id = id;
    _categoryName = categoryName;
    _requiresAction = requiresAction;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['categoryName'];
    _requiresAction = json['requiresAction'];
  }
  int? _id;
  String? _categoryName;
  bool? _requiresAction;

  int? get id => _id;
  String? get categoryName => _categoryName;
  bool? get requiresAction => _requiresAction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryName'] = _categoryName;
    map['requiresAction'] = _requiresAction;
    return map;
  }
}
