class Dare {
  final int id;
  final String name;
  final bool is_delete;
  final int idTopic;

  Dare({required this.id, required this.name, required this.is_delete, required this.idTopic});

  Map<String, dynamic> toMap(){
    return {'id': id, 'name': name, 'is_delete': is_delete, 'id_topic': idTopic};
  }

  factory Dare.fromMap(Map<String, dynamic> map) {
    return Dare(id: map['id'], name: map['name'], is_delete: map['is_delete'] == 1 ? true : false, idTopic: map['id_topic']);
  }

  @override
  String toString() {
    return 'Dare(id: $id, name: $name, is_delete: ${is_delete ? 1 : 0}, id_topic: $idTopic)';
  }
}
