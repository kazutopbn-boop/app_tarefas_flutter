class Tarefa {
  final int? id;
  final String titulo;
  final String descricao;
  final String dataPrevista;
  final bool importante;
  final bool realizada;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataPrevista,
    required this.importante,
    required this.realizada,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataPrevista': dataPrevista,
      'importante': importante ? 1 : 0,
      'realizada': realizada ? 1 : 0,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      dataPrevista: map['dataPrevista'],
      importante: map['importante'] == 1,
      realizada: map['realizada'] == 1,
    );
  }
}
