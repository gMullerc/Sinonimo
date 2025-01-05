enum ModoJogoEnum {
  jogoRapido;

  static ModoJogoEnum fromString(String value) {
    return ModoJogoEnum.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
      orElse: () =>
          throw ArgumentError('Valor inválido para DificuldadeEnum: $value'),
    );
  }
}
