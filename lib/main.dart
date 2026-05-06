import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tarefa_provider.dart';
import 'telas/tela_cadastro.dart';
import 'telas/tela_detalhes.dart';
import 'telas/tela_lista.dart';
import 'util/rotas.dart';

void main() {
  runApp(const AppTarefas());
}

class AppTarefas extends StatelessWidget {
  const AppTarefas({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TarefaProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Tarefas',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: Rotas.telaLista,
        routes: {
          Rotas.telaLista: (context) => const TelaLista(),
          Rotas.telaCadastro: (context) => const TelaCadastro(),
          Rotas.telaDetalhes: (context) => const TelaDetalhes(),
        },
      ),
    );
  }
}
