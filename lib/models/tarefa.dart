class Tarefa {
  final int? id;
  final String titulo;
  final String descricao;
  final String dataPrevista;
  final bool importante;
  final bool realizada;
  final String categoria;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataPrevista,
    required this.importante,
    required this.realizada,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataPrevista': dataPrevista,
      'importante': importante ? 1 : 0,
      'realizada': realizada ? 1 : 0,
      'categoria': categoria,
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
      categoria: map['categoria'],
    );
  }

  DateTime get data {
    return DateTime.parse(dataPrevista);
  }

  String get dataFormatada {
    final d = data;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  bool get atrasada {
    final hoje = DateTime.now();
    final hojeSemHora = DateTime(hoje.year, hoje.month, hoje.day);
    final dataSemHora = DateTime(data.year, data.month, data.day);

    return !realizada && dataSemHora.isBefore(hojeSemHora);
  }
}