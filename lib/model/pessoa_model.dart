import 'package:cartas/model/arquivo_model.dart';

class Pessoa {

  int id;
  String nome;
  List<Arquivo> arquivos;

  Pessoa({this.id, this.nome, this.arquivos});

  factory Pessoa.fromJson(Map<String, dynamic> json){
    dynamic arquivos;

    arquivos = json["arquivos"].map<Arquivo>((s) {
      Arquivo arquivo = Arquivo.fromJson(s);
      return arquivo;
    });

    dynamic arquivos2 = arquivos.toList();

    return Pessoa(
        id: json['id'],
        nome: json['nome'],
        arquivos: arquivos2
    );

  }
}