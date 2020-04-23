import 'package:cartas/model/arquivo_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArquivosScreen extends StatelessWidget {

  List<Arquivo> arquivos;

  ArquivosScreen(this.arquivos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Arquivos")),
      body: ListView(
        children: this.arquivos.map((f){
          return GestureDetector(
            onTap: (){
              launch("http://acervoaal.ddns.net/files" + f.enderecoPDF.replaceAll("\\", "/"));
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  Icon(Icons.picture_as_pdf),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Visualizar'),
                  ),
                ],

              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
