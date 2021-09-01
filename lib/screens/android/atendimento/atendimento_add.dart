import 'dart:io';
import 'package:codaula/database/atendimento_dao.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/atendimento_model.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AtendimentoScrean extends StatefulWidget {
  int index;
  Atendimento atendimento;

  AtendimentoScrean({Atendimento atendimento}) {
    if (atendimento == null) {
      this.index = -1;
    } else {
      this.index = atendimento.codatendimento;
      this.atendimento = atendimento;
    }
  }

  @override
  _AtendimentoScreanState createState() => _AtendimentoScreanState();
}

class _AtendimentoScreanState extends State<AtendimentoScrean> {
  final TextEditingController _codpacienteController = TextEditingController();
  final TextEditingController _codpsicologoController = TextEditingController();
  final TextEditingController _dataatendimentoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Atendimento _atendimento;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index >= 0 && this._isUpdate == false) {
      debugPrint('editar index = ' + widget.index.toString());

      this._atendimento = widget.atendimento;
      this._atendimento.codatendimento = widget.index;
      this._codpacienteController.text = this._atendimento.codpaciente.toString();
      this._codpsicologoController.text = this._atendimento.codpsicologo.toString();
      this._dataatendimentoController.text = this._atendimento.dataatendimento.toString();
      this._isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Atendimento'),
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
                      return 'cod paciente obrigatório';
                    }
                    return null;
                  },
                  controller: this._codpacienteController,
                  decoration: InputDecoration(labelText: "Cod.paciente"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Cod psicologo obrigatório';
                    }
                    return null;
                  },
                  controller: this._codpsicologoController,
                  decoration: InputDecoration(labelText: "Cod.psicologo"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Data do atendimento obrigatória';
                    }
                    return null;
                  },
                    controller: this._dataatendimentoController,
                  decoration: InputDecoration(labelText: "Data do Atendimento"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.datetime,
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
                          Atendimento p = new Atendimento(
                            widget.index,
                            int.tryParse(this._codpacienteController.text),
                            int.tryParse(this._codpsicologoController.text),
                            DateTime.parse(this._dataatendimentoController.text),
                          );

                          if (widget.index >= 0) {
                            AtendimentoDAO().autalizar(p);
                            Navigator.of(context).pop();
                          } else {
                            AtendimentoDAO().adicionar(p);
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
              ,
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
