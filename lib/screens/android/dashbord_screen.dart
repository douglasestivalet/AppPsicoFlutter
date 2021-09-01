import 'package:codaula/screens/android/login_screen.dart';
import 'package:codaula/screens/android/paciente/paciente_list.dart';
import 'package:codaula/screens/android/psicologo/psicologo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'atendimento/atendimento_list.dart';

class Dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Psico Assistente'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Column(children: <Widget>[
            Container(
              //color: Colors.green,
              height: 700,
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _ItemElemento(
                    'PACIENTES',
                    Icons.accessibility_new,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PacienteList()));
                    },
                  ),
                  _ItemElemento(
                    'PSICOLOGOS',
                    Icons.accessibility_new,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PsicologoList()));
                    },
                  ),
                  _ItemElemento(
                    'ATENDIMENTOS',
                    Icons.check_circle_outline,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AtendimentoList()));
                    },
                  ),
                ],
              ),
            )
          ]),
        ));
  }

}

class _ItemElemento extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Function onClick;

  _ItemElemento(this.titulo, this.icone, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10.0,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  this.icone,
                  color: Colors.white,
                ),
                Text(
                  this.titulo,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
