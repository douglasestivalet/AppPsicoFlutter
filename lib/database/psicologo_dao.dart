import 'package:codaula/database/openDatabaseDB.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class PsicologoDAO {

  static const String _nomeTabela = 'psicologo';
  static const String _col_codpsicologo = 'codpsicologo';
  static const String _col_nomepsicologo = 'nomepsicologo';
  static const String _col_emailpsicologo = 'emailpsicologo';
  static const String _col_senhapsicologo = 'senhapsicologo';


  static const String sqlTabelaPsicologo = 'CREATE TABLE $_nomeTabela ('
      '$_col_codpsicologo INTEGER PRIMARY KEY, '
      '$_col_nomepsicologo TEXT , '
      '$_col_emailpsicologo TEXT , '
      '$_col_senhapsicologo TEXT)';

  adicionar(Psicologo p) async {
    final Database db = await getDatabase();
    await db.insert(_nomeTabela, p.toMap());
  }

  static Psicologo getPsicologo(int index) {
    return null;
    //  return _pacientes.elementAt(index);
  }

  remove(dynamic codpsicologo) async {
    final Database db = await getDatabase();
    await db.delete(
      _nomeTabela,
      where: "codpsicologo = ?",
      whereArgs: [codpsicologo],
    );

  }


  autalizar(Psicologo p) async {
    final Database db = await getDatabase();
    db.update(_nomeTabela, p.toMap(),
        where: 'codpsicologo=?', whereArgs: [p.codpsicologo]);
  }

  Future<List<Psicologo>> getPsicologos() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    return List.generate(maps.length, (i) {
      return Psicologo(maps[i][_col_codpsicologo],
        maps[i][_col_nomepsicologo],
        maps[i][_col_emailpsicologo],
        maps[i][_col_senhapsicologo],
      );
    });
  }
}
