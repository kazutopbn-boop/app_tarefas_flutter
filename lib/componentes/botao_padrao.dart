import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final VoidCallback onPressed;
  final Color? cor;

  const BotaoPadrao({
    super.key,
    required this.texto,
    required this.icone,
    required this.onPressed,
    this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icone),
      label: Text(texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }
}