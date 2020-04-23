import 'package:cartas/model/pessoa_model.dart';
import 'package:cartas/screens/arquivos_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {

  final _searchController = TextEditingController();
  Future _gifs;

  Future<List<Pessoa>> _getGifs(String nome) async {
    http.Response response = await http.get(
        "http://acervoaal.ddns.net:8080/api/pessoa/search?nome=" + nome);
    List<dynamic> body = jsonDecode(response.body);

    List<Pessoa> posts = body
        .map(
          (dynamic item) => Pessoa.fromJson(item),
    )
        .toList();

    return posts;

  }

  @override
  Widget build(BuildContext context) {

    return
        Scaffold(
          appBar: AppBar(
            title: Text("Correspondências de Alceu Amoroso Lima"),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              TextFormField(
                controller: _searchController,
                onFieldSubmitted: (text){
                  setState(() {
                    _gifs = _getGifs(text);
                  });
                },
                decoration: InputDecoration(
                    hintText: "Digite aqui para procurar"
                ),
              ),
              FlatButton(
                child: Text("Procurar"),
                onPressed: (){
                  setState(() {
                    _gifs = _getGifs(_searchController.text);
                  });
                },
              ),
              Expanded(
                child: FutureBuilder(
                    future: _gifs,
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: 200.0,
                            height: 200.0,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 5.0,
                            ),
                          );
                        default:
                          if(snapshot.hasError) return Container();
                          else return _createGifTable(context, snapshot);                      }
                    }
                ),
              ),
            ],
          )
        );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot){
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _getCount(snapshot.data),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArquivosScreen(snapshot.data[index].arquivos))
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text((snapshot.data[index].id).toString()),
                      ),
                      Flexible(
                        child: Container(
                          child: Text(snapshot.data[index].nome),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
         }
         );

        }


  int _getCount(List data){
      return data.length;
  }
}



