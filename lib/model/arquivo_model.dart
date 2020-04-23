class Arquivo {

  int id;
  String enderecoPDF;

  Arquivo({this.id, this.enderecoPDF});

  factory Arquivo.fromJson(Map<String, dynamic> json){
    return Arquivo(
        id: json['id'],
        enderecoPDF: json['enderecoPDF']
    );

  }
}