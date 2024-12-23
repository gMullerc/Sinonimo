abstract class Failure {
  final String mensagemErro;

  Failure(this.mensagemErro);
}

class GenericFailure extends Failure {
  GenericFailure(super.mensagemErro);
}
