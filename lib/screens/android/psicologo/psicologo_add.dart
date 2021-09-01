import 'dart:io';

import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/database/psicologo_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PsicologoScrean extends StatefulWidget {
  int index;
  Psicologo psicologo;

  PsicologoScrean({Psicologo psicologo}) {
    if (psicologo == null) {
      this.index = -1;
    } else {
      this.index = psicologo.codpsicologo;
      this.psicologo = psicologo;
    }
  }

  @override
  _PsicologoScreanState createState() => _PsicologoScreanState();
}

class _PsicologoScreanState extends State<PsicologoScrean> {
  final TextEditingController _nomepsicologoController = TextEditingController();
  final TextEditingController _emailpsicologoController = TextEditingController();
  final TextEditingController _senhapsicologoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Psicologo _psicologo;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index >= 0 && this._isUpdate == false) {
      debugPrint('editar index = ' + widget.index.toString());

      this._psicologo = widget.psicologo;
      this._psicologo.codpsicologo = widget.index;
      this._nomepsicologoController.text = this._psicologo.nomepsicologo;
      this._emailpsicologoController.text = this._psicologo.emailpsicologo;
      this._senhapsicologoController.text = this._psicologo.senhapsicologo;
      this._isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Psicologo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'nome obrigatório';
                    }
                    return null;
                  },
                  controller: this._nomepsicologoController,
                  decoration: InputDecoration(labelText: "Nome"),
                  style: TextStyle(fontSize: 24),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email obrigatório';
                    }
                    return null;
                  },
                  controller: this._emailpsicologoController,
                  decoration: InputDecoration(labelText: "Email"),
                  style: TextStyle(fontSize: 24),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Senha obrigatória';
                    }
                    return null;
                  },
                  controller: this._senhapsicologoController,
                  decoration: InputDecoration(labelText: "Senha"),
                  style: TextStyle(fontSize: 24),
                ),

                Container(
                  //color: Colors.red,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(18),
                    elevation: 6.0,
                    color: Colors.lightBlue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Psicologo p = new Psicologo(
                          widget.index,
                          this._nomepsicologoController.text,
                          this._emailpsicologoController.text,
                          this._senhapsicologoController.text
                        );

                        if (widget.index >= 0) {
                          PsicologoDAO().autalizar(p);
                          Navigator.of(context).pop();
                        } else {
                          PsicologoDAO().adicionar(p);
                          Navigator.of(context).pop();
                        }
                      } else {
                        debugPrint('formuláiro inválido');
                      }
                    },
                    child: Text(
                      'SALVAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
