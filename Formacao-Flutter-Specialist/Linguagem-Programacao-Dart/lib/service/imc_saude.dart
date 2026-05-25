class ImcSaude {
  static String imcSaude(String nome, double valorIMC) {
    // 1. Tratamento de erro para valores impossíveis
    if (valorIMC <= 0 || valorIMC.isInfinite || valorIMC.isNaN) {
      throw ArgumentError(
        "O valor do IMC ($valorIMC) é inválido para classificação.",
      );
    }
    var valor = valorIMC.toStringAsFixed(2);
    switch (valorIMC) {
      case < 16:
        return "$nome seu valor IMC é: $valor \nSaúde status: Magreza Grave.";
      case >= 16 && < 17:
        return "$nome seu valor IMC é: $valor \nSaúde status: Magreza Moderada.";
      case >= 17 && < 18.5:
        return "$nome seu valor IMC é: $valor \nSaúde status: Magreza Leve.";
      case >= 18.5 && < 25:
        return "$nome seu valor IMC é: $valor \nSaúde status: Saudavel.";
      case >= 25 && < 30:
        return "$nome seu valor IMC é: $valor \nSaúde status: Sobrepeso.";
      case >= 30 && < 35:
        return "$nome seu valor IMC é: $valor \nSaúde status: Obsidade Grau I.";
      case >= 35 && < 40:
        return "$nome seu valor IMC é: $valor \nSaúde status: Obsidade Grau II.";
      case >= 40:
        return "$nome seu valor IMC é: $valor \nSaúde status: Obsidade Grau III.";
      default:
        return "Não foi possivel avaliar sua saúde!";
    }
  }
}
