import 'dart:convert';
import 'dart:io';

import 'package:linguagem__programacao__dart/service/imc_calcule.dart';
import 'package:linguagem__programacao__dart/service/imc_saude.dart';

void main(List<String> arguments) {
  String saindo = "";
  do {
    print("\n------------------------------");
    print("------------IMC MED-----------");
    print("------------------------------\n");

    print("Digite o seu nome ou S para sair:");
    var nome = stdin.readLineSync(encoding: utf8);

    saindo = nome
        .toString()
        .trim(); // .trim() remove espaços em branco acidentais
    if (saindo.toUpperCase() == "S") {
      break; // Sai do loop imediatamente
    }

    print("Digite o seu peso: ");
    var linePeso = stdin.readLineSync(encoding: utf8) ?? "";

    print("Digite a sua altura: ");
    var lineAltura = stdin.readLineSync(encoding: utf8) ?? "";

    double peso = double.tryParse(linePeso) ?? 0.0;
    double altura = double.tryParse(lineAltura) ?? 0.0;

    double valor = ImcCalcule.calculeIMC(peso, altura);
    print(ImcSaude.imcSaude(nome.toString(), valor));

    print("-" * 30); // Linha divisória para organizar o console
  } while (saindo.toUpperCase() != "S"); // Continua enquanto NÃO for "S"
}
