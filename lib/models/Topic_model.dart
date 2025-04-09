class Topic {
  final int id;
  final String title;
  Topic({required this.id, required this.title});

  Map<String, Object?> toMap(){
    return {'id': id, 'title': title};
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(id: map['id'], title: map['title'] ?? '');
  }

  @override
  String toString() {
    return 'Topic(id: $id, title: $title)';
  }
}
