class ToDoModel {
  String? title;
  String? content;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? successAt;

  ToDoModel({
    this.title,
    this.content,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.successAt,
  });

  ToDoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    status = json['status'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    successAt = json['success_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['status'] = status;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['success_at'] = successAt;
    return data;
  }
}
