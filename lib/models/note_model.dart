class NoteModel {
  int? id;
  String title;
  String description;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
  });

  static NoteModel fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
