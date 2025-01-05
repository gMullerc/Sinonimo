enum DificuldadeEnum {
  facil,
  medio,
  dificil;

  static DificuldadeEnum fromString(String value) {
    return DificuldadeEnum.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
      orElse: () =>
          throw ArgumentError('Valor inválido para DificuldadeEnum: $value'),
    );
  }
}
