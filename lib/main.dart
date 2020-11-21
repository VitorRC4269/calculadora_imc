import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController celsiusController = TextEditingController();
  TextEditingController fahController = TextEditingController();
  TextEditingController kelvinController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe uma temperatura!";

  void _resetFields() {
    celsiusController.text = "";
    fahController.text = "";
    kelvinController.text = "";
    setState(() {
      _infoText = "Informe uma temperatura!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double c;
      double f;
      double k;
      if(celsiusController.text != ""){
        c = double.parse(celsiusController.text);
      }
      else{
        c = null;
      }

      if(fahController.text != ""){
        f = double.parse(fahController.text);
      }
      else{
        f = null;
      }

      if(kelvinController.text != ""){
        k = double.parse(kelvinController.text);
      }
      else{
        k = null;
      }
/*
      print("\nC == $c");
      print("\nF == $f");
      print("\nK == $k");*/
      /*
      double c = double.parse(celsiusController.text);
      double f = double.parse(fahController.text);
      double k = double.parse(kelvinController.text);
      double imc;
*/
      if (c != null && f == null && k == null) {
        f = c * 1.8 + 32;
        k = c + 273.15;

        fahController.text = "${f.toStringAsFixed(2)}";
        kelvinController.text = "${k.toStringAsFixed(2)}";
        _infoText = "";
      } else if (c == null && f != null && k == null) {
        c = (f - 32) / 1.8;
        k = c + 273.15;

        celsiusController.text = "${c.toStringAsFixed(2)}";
        kelvinController.text = "${k.toStringAsFixed(2)}";
        _infoText = "";
      } else if (c == null && f == null && k != null) {
        c = k - 273.15;
        f = c * 1.8 + 32;

        celsiusController.text = "${c.toStringAsFixed(2)}";
        fahController.text = "${f.toStringAsFixed(2)}";
        _infoText = "";
      } else if (c == null && f == null && k == null){
        _infoText = "Preencha algum campo!";
      }
      else{
        _infoText = "Preencha apenas um campo!";
      }
/*
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40.0) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }*/
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Temperatura"),
        centerTitle: true,
        backgroundColor: Colors.purple[600],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.thermostat_outlined, size: 120.0, color: Colors.purple[600]),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Celsius (°C)",
                    labelStyle: TextStyle(color: Colors.purple[600])),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple[600], fontSize: 25.0),
                controller: celsiusController,
                /*validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },*/
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Fahrenheit (°F)",
                    labelStyle: TextStyle(color: Colors.purple[600])),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple[600], fontSize: 25.0),
                controller: fahController,
               /* validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },*/
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Kelvin (K)",
                    labelStyle: TextStyle(color: Colors.purple[600])),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple[600], fontSize: 25.0),
                controller: kelvinController,
               /* validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },*/
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                     // if (_formKey.currentState.validate()) {
                        _calculate();
                    //  }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.purple[600],
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple[600], fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
