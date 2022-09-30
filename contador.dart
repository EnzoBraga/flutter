import 'package:flutter/material.dart';

void main() {
  //Código do Braga
  runApp(MaterialApp(
      title: "Contando os alunos",
      home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _num_alunos = 0;
  String _texto = "Chega mais";

  void _change(int increment) {
    setState(() {
      _num_alunos += increment;
    });
    if (_num_alunos < 0) {
      _texto = "Tem gente negativa nisso aí não";
      _num_alunos=0;
      return;
    }
    if (_num_alunos > 35) {
      _texto = "Tá lotado, paro paro";
      if(_num_alunos>36){
        _texto ="Zé, não cabe mais para";
        _num_alunos=36;
      }
      return;
    }
    _texto = "Chega mais";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/dc3b2546601081.585ad762e70eb.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Alunos: $_num_alunos",
              style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.all(9.0),
                child: TextButton(
                  onPressed: () {
                    _change(-1);
                  },
                  child: Text(
                    "-1",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: TextButton(
                  onPressed: () {
                    _change(1);
                  },
                  child: Text(
                    "+1",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ]),
            Text(
              "$_texto",
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
