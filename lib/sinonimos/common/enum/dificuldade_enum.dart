enum DificuldadeEnum {
  facil(0, null),
  medio(1600, DificuldadeEnum.facil),
  dificil(2500, DificuldadeEnum.medio);

  const DificuldadeEnum(this.pontuacaoMinima, this.dificuldadeAnterior);

  final double pontuacaoMinima;
  final DificuldadeEnum? dificuldadeAnterior;

  static DificuldadeEnum fromString(String value) {
    return DificuldadeEnum.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
      orElse: () =>
          throw ArgumentError('Valor inválido para DificuldadeEnum: $value'),
    );
  }
}
