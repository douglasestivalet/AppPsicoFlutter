import 'package:codaula/database/openDatabaseDB.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:codaula/database/psicologo_dao.dart';

class PacienteDAO {
  // static final List<Paciente> _pacientes = List();

  static const String _nomeTabela = 'paciente';
  static const String _col_codpaciente = 'codpaciente';
  static const String _col_nomepaciente = 'nomepaciente';
  static const String _col_idade = 'idade';
  static const String _col_codpsicologo = 'codpsicologo';


  static const String sqlTabelaPaciente = 'CREATE TABLE $_nomeTabela ('
      '$_col_codpaciente INTEGER PRIMARY KEY, '
      '$_col_nomepaciente TEXT , '
      '$_col_idade INTEGER , '
      '$_col_codpsicologo INTEGER,';

  adicionar(Paciente p) async {
    //   _pacientes.add(p);

    final Database db = await getDatabase();
    await db.insert(_nomeTabela, p.toMap());
  }

  static Paciente getPaciente(int index) {
    return null;
    //  return _pacientes.elementAt(index);
  }

  remove(dynamic codpaciente) async {
    final Database db = await getDatabase();
    await db.delete(
      _nomeTabela,
      where: "codpaciente = ?",
      whereArgs: [codpaciente],
    );

  }

  autalizar(Paciente p) async {
    final Database db = await getDatabase();
    db.update(_nomeTabela, p.toMap(),
        where: 'codpaciente=?', whereArgs: [p.codpaciente]);
  }

  static get listarPacientes {
 //   return _pacientes;
   }

  Future<List<Paciente>> getPacientes() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);
    return List.generate(maps.length, (i) {
      return Paciente(maps[i][_col_codpaciente],
          maps[i][_col_nomepaciente],
          maps[i][_col_idade],
          maps[i][_col_codpsicologo],
      );
    });
  }


}
