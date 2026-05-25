import 'package:linguagem__programacao__dart/service/imc_calcule.dart';
import 'package:linguagem__programacao__dart/service/imc_saude.dart';
import 'package:test/test.dart';

void main() {
  test('Test IMC Real', () {
    expect(
      double.parse(ImcCalcule.calculeIMC(82.0, 1.72).toStringAsFixed(2)),
      27.72,
    );
  });
  test("teste Saude", () {
    double valorIMC = ImcCalcule.calculeIMC(82.0, 1.72);
    expect(
      ImcSaude.imcSaude("Oliveira", valorIMC),
      equals("Oliveira seu valor IMC é: 27.72 \nSaúde status: Sobrepeso."),
    );
  });
}
