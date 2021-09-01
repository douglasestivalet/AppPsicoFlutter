import 'dart:io';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:codaula/database/psicologo_dao.dart';
import 'package:codaula/model/psicologo_model.dart';

class PacienteScrean extends StatefulWidget {
  int index;
  Paciente paciente;

  PacienteScrean({Paciente paciente}) {
    if (paciente == null) {
      this.index = -1;
    } else {
      this.index = paciente.codpaciente;
      this.paciente = paciente;
    }
  }

  @override
  _PacienteScreanState createState() => _PacienteScreanState();
}

class _PacienteScreanState extends State<PacienteScrean> {
  final TextEditingController _nomepacienteController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _codpsicologoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Paciente _paciente;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index >= 0 && this._isUpdate == false) {
      debugPrint('editar index = ' + widget.index.toString());

      this._paciente = widget.paciente;
      this._paciente.codpaciente = widget.index;
      this._nomepacienteController.text = this._paciente.nomepaciente;
      this._idadeController.text = this._paciente.idade.toString();
      this._codpsicologoController.text = this._paciente.codpsicologo.toString();
      this._isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Paciente'),
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
                  controller: this._nomepacienteController,
                  decoration: InputDecoration(labelText: "Nome"),
                  style: TextStyle(fontSize: 24),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Idade obrigatório';
                    }
                    return null;
                  },
                  controller: this._idadeController,
                  decoration: InputDecoration(labelText: "Idade"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Codigo do psicologo obrigatório';
                    }
                    return null;
                  },
                  controller: this._codpsicologoController,
                  decoration: InputDecoration(labelText: "Codigo psicologo"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
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
                        Paciente p = new Paciente(
                            widget.index,
                            this._nomepacienteController.text,
                            int.tryParse(this._idadeController.text),
                            int.tryParse(this._codpsicologoController.text),

                        );

                        if (widget.index >= 0) {
                          PacienteDAO().autalizar(p);
                          Navigator.of(context).pop();
                        } else {
                          PacienteDAO().adicionar(p);
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
