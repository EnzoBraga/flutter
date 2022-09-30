  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

  const List<String> list = <String>['Adulto saudável com cerca de 70 kg', 'Crianças e adolescentes', 'Gestantes e lactantes', 'Sensíveis à cafeína'];

  void main() {
    //Código do Braga
    runApp(MaterialApp(
        title: "Vai um cafézin?",
        home: Home()));
  }

  class Home extends StatefulWidget {
    const Home({Key? key}) : super(key: key);

    @override
    State<Home> createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    TextEditingController quantidadeCafeina100ml = TextEditingController();
    TextEditingController quantidadeBebida = TextEditingController();

    int _tipoCafe=0;
    double _totalCafeina=0;

    String _dropdownValue = list[0];
    String _infoText= "Você está dentro do limite de cafeína";

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void _resetFields(){
      quantidadeBebida.text = "";
      quantidadeCafeina100ml.text ="";
      _tipoCafe=0;
      _totalCafeina=0;
      _formKey = GlobalKey<FormState>();
      setState(() {
        _infoText="Você está dentro do limite de cafeína";
      });
    }

    void _calculate(){
      setState(() {

        if(_tipoCafe==1){
          int ml= int.parse(quantidadeBebida.text);
          _totalCafeina+= ml * (85/125);
        }else if(_tipoCafe==2){
          int ml= int.parse(quantidadeBebida.text);
          _totalCafeina+= ml * 2;
        }else if(_tipoCafe==3){
          int ml= int.parse(quantidadeBebida.text);
          _totalCafeina+= ml * (int.parse(quantidadeCafeina100ml.text)/100);
        }

        if(_dropdownValue==list[0]){
          if(_totalCafeina>400){
            _infoText="Estourou a cafeína";
          }
        }
        else if(_dropdownValue==list[1]){
          if(_totalCafeina>100){
            _infoText="Estourou a cafeína";
          }
        }else if(_dropdownValue==list[2]||_dropdownValue==list[3]){
          if(_totalCafeina>200){
            _infoText="Estourou a cafeína";
          }
        }
      }
      );
      quantidadeBebida.text = "";
      quantidadeCafeina100ml.text ="";
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quantidade de cafeína"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
                onPressed: _resetFields),
          ],
        ),
        backgroundColor: Colors.black,
        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://media.discordapp.net/attachments/901110165300977684/1024375749874040842/wallpaper.jpeg?width=322&height=572"),
                fit: BoxFit.cover),
          ),


          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  DropdownButton(
                      value: _dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: list.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;

                        });}
                  ),
                  Text("Cafeína ingerida: ($_totalCafeina mg)", style: TextStyle(color: Colors.green, fontSize: 30.0), textAlign: TextAlign.center,),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: "Quantidade de bebida (ml)",
                      labelStyle: TextStyle(color:
                      Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green,
                        fontSize: 20.0),
                    controller: quantidadeBebida,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Insira a quantidade de bebida";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RadioListTile(
                      title: Text("Café normal"),
                      value: 1,
                      groupValue: _tipoCafe,
                      onChanged: (value){
                        setState(() {
                          _tipoCafe = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RadioListTile(
                      title: Text("Café Expresso"),
                      value: 2,
                      groupValue: _tipoCafe,
                      onChanged: (value){
                        setState(() {
                          _tipoCafe = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RadioListTile(
                      title: Text("Outros (Favor inserir quantidade de cafeína por 100ml)"),
                      value: 3,
                      groupValue: _tipoCafe,
                      onChanged: (value){
                        setState(() {
                          _tipoCafe = int.parse(value.toString());
                        });
                      },
                    ),
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: "Quantidade de cafeína por 100ml",
                      labelStyle: TextStyle(color:
                      Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green,
                        fontSize: 20.0),
                    controller: quantidadeCafeina100ml,
                    validator: (value){
                      if(value!.isEmpty && _tipoCafe==3){
                        return "Insira a quantidade de cafeína";
                      }
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calculate();
                          _tipoCafe=0;
                        }
                      },
                      child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                  ),
                  Text("$_infoText", style: TextStyle(color: Colors.green, fontSize: 30.0), textAlign: TextAlign.center,),

                ],
              ),
            ),
          ),
        ),
      );
    }
  }