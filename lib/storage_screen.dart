import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {

  List<dynamic> imagenes = [];
  
  @override
  void initState() {
    //TODO: todo
    super.initState();
    _obtenerImagenes();
  }
  // https://firebasestorage.googleapis.com/v0/b/fir-flutter-62ba6.appspot.com/o/imagenes%2Fimagen1.jpg?alt=media&token=9e071e42-6763-43b2-8c8e-06295e4d1d75
  // Image.network('https://firebasestorage.googleapis.com/v0/b/fir-flutter-62ba6.appspot.com/o/${imagenes[index]['name']}?alt=media&token=9e071e42-6763-43b2-8c8e-06295e4d1d75');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pruebas'),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: imagenes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Image.network('https://firebasestorage.googleapis.com/v0/b/fir-flutter-62ba6.appspot.com/o/${imagenes[index]}?alt=media')
            );
          }
        )
      )
    );
  }

  _obtenerImagenes() async {
    String url = 'https://firebasestorage.googleapis.com/v0/b/fir-flutter-62ba6.appspot.com/o/';
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body)['items'];
      for(int i=0; i < jsonResponse.length; i++) {
        var temp = jsonResponse[i]['name'].replaceAll('/', '%2F');
        imagenes.add(temp);
      }
      print(imagenes);
    } else {
      print('Erorrrrr');
    }
  }
}

