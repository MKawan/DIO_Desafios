class ImcCalcule {
  static calculeIMC(double peso, double altura) {
    // 1. Validação de Regra de Negócio (Exceções Manuais)
    if (altura <= 0) {
      throw ArgumentError("A altura não pode ser zero ou negativa.");
    }
    if (peso <= 0) {
      throw ArgumentError("O peso deve ser maior que zero.");
    }

    try {
      return peso / (altura * altura);
    } catch (e) {
      // 2. Relançar ou tratar erros inesperados
      throw Exception("Erro ao calcular IMC: $e");
    }
  }
}
