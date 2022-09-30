import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText= "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    _formKey = GlobalKey<FormState>();
    setState(() {
      _infoText="Informe seus dados";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100.0;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        return;
      }
      if(imc<=24.9){
        _infoText="Peso Normal (${imc.toStringAsPrecision(4)})";
        return;
      }
      if(imc<=29.9){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
        return;
      }
      if(imc<=34.9){
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(4)})";
        return;
      }
      if(imc<=39.9){
        _infoText = "Obesidade grau 2 (${imc.toStringAsPrecision(4)})";
        return;
      }
      _infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(4)}";
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.black,
      body:SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color:
                    Colors.green
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green,
                      fontSize: 20.0),
                  controller: weightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira seu peso";
                    }
                    if(double.parse(value)>500){
                      return "Impossível esse peso aí camarada";
                    }
                    if(double.parse(value)<0){
                      return "Parabéns você quebrou a física";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color:
                    Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green,
                      fontSize: 20.0),
                  controller: heightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira a altura";
                    }
                    if(int.parse(value)>300){
                      return "Proibido gigantes";
                    }
                    if(int.parse(value)<0){
                      return "Pare de tentar quebrar a física por favor";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                      _calculate();
                      }
                      },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
                Text("$_infoText", style: TextStyle(color: Colors.green, fontSize: 15.0), textAlign: TextAlign.center,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}