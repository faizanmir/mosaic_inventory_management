class ItemResponse {
  String? message;
  bool? success;

//<editor-fold desc="Data Methods">

  ItemResponse({
    this.message,
    this.success,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemResponse &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          success == other.success);

  @override
  int get hashCode => message.hashCode ^ success.hashCode;

  @override
  String toString() {
    return 'ItemResponse{' +
        ' message: $message,' +
        ' success: $success,' +
        '}';
  }

  ItemResponse copyWith({
    String? message,
    bool? success,
  }) {
    return ItemResponse(
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'success': this.success,
    };
  }

  factory ItemResponse.fromMap(Map<String, dynamic> map) {
    return ItemResponse(
      message: map['message'] as String,
      success: map['success'] as bool,
    );
  }

//</editor-fold>
}
