import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';
import '../providers/tarefa_provider.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();

  DateTime? _dataPrevista;
  bool _importante = false;

  Tarefa? _tarefaEditando;
  bool _dadosCarregados = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_dadosCarregados) {
      final tarefa = ModalRoute.of(context)?.settings.arguments;

      if (tarefa != null && tarefa is Tarefa) {
        _tarefaEditando = tarefa;
        _tituloController.text = tarefa.titulo;
        _descricaoController.text = tarefa.descricao;
        _categoriaController.text = tarefa.categoria;
        _dataPrevista = DateTime.parse(tarefa.dataPrevista);
        _importante = tarefa.importante;
      }

      _dadosCarregados = true;
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataPrevista ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (data != null) {
      setState(() {
        _dataPrevista = data;
      });
    }
  }

  Future<void> _salvar() async {
    if (_tituloController.text.trim().isEmpty ||
        _descricaoController.text.trim().isEmpty ||
        _categoriaController.text.trim().isEmpty ||
        _dataPrevista == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios.'),
        ),
      );
      return;
    }

    final tarefa = Tarefa(
      id: _tarefaEditando?.id,
      titulo: _tituloController.text.trim(),
      descricao: _descricaoController.text.trim(),
      dataPrevista: _dataPrevista!.toIso8601String(),
      importante: _importante,
      realizada: _tarefaEditando?.realizada ?? false,
      categoria: _categoriaController.text.trim(),
    );

    final provider = Provider.of<TarefaProvider>(context, listen: false);

    if (_tarefaEditando == null) {
      await provider.adicionarTarefa(tarefa);
    } else {
      await provider.editarTarefa(tarefa);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final editando = _tarefaEditando != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar Tarefa' : 'Cadastrar Tarefa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dataPrevista == null
                        ? 'Nenhuma data selecionada'
                        : 'Data prevista: ${_formatarData(_dataPrevista!)}',
                  ),
                ),
                ElevatedButton(
                  onPressed: _selecionarData,
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Importante'),
              value: _importante,
              onChanged: (valor) {
                setState(() {
                  _importante = valor ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: Text(editando ? 'Salvar Alterações' : 'Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}