import 'package:codaula/database/openDatabaseDB.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:codaula/model/atendimento_model.dart';

class AtendimentoDAO {

  static const String _nomeTabela = 'atendimento';
  static const String _col_codatendimento = 'codatendimento';
  static const String _col_codpaciente = 'codpaciente';
  static const String _col_codpsicologo = 'codpsicologo';
  static const String _col_dataatendimento = 'dataatendimento';

  static const String sqlTabelaAtendimento = 'CREATE TABLE $_nomeTabela ('
      '$_col_codatendimento INTEGER PRIMARY KEY, '
      '$_col_codpaciente INTEGER , '
      '$_col_codpsicologo INTEGER , '
      '$_col_dataatendimento TEXT,)';

  adicionar(Atendimento p) async {
    final Database db = await getDatabase();
    await db.insert(_nomeTabela, p.toMap());
  }

  remove(dynamic codatendimento) async {
    final Database db = await getDatabase();
    await db.delete(
      _nomeTabela,
      where: "codatendimento = ?",
      whereArgs: [codatendimento],
    );
  }

  autalizar(Atendimento p) async {
    final Database db = await getDatabase();
    db.update(_nomeTabela, p.toMap(),
        where: 'codatendimento=?', whereArgs: [p.codatendimento]);
  }

  Future<List<Atendimento>> getAtendimentos() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    return List.generate(maps.length, (i) {
      return Atendimento(maps[i][_col_codatendimento],
        maps[i][_col_codpaciente],
        maps[i][_col_codpsicologo],
        DateTime.parse(maps[i][_col_dataatendimento]),
      );
    });
  }
}
