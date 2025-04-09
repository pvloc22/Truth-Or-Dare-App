class Truth {
  final int id;
  final String name;
  final bool is_delete;
  final int idTopic;
  Truth({required this.id, required this.name, required this.is_delete, required this.idTopic});

  Map<String, Object?> toMap(){
    return {'id': id, 'name': name, 'is_delete': is_delete, 'id_topic': idTopic};
  }

  factory Truth.fromMap(Map<String, dynamic> map) {
    return Truth(id: map['id'], name: map['name'], is_delete: map['is_delete'] == 1 ? true : false , idTopic: map['id_topic']);
  }

  @override
  String toString() {
    return 'Truth(id: $id, name: $name, is_delete: ${is_delete ? 1 : 0} , id_topic: $idTopic)';
  }
}