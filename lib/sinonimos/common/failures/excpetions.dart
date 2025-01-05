class NotFoundException implements Exception {
  final String mensagem;

  NotFoundException({
    required this.mensagem,
  });
}
