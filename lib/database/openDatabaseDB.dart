import 'package:codaula/database/atendimento_dao.dart';
import 'package:codaula/database/psicologo_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:codaula/database/paciente_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bancoconsultorio.db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute(PacienteDAO.sqlTabelaPaciente);
        db.execute(PsicologoDAO.sqlTabelaPsicologo);
        db.execute(AtendimentoDAO.sqlTabelaAtendimento);
      },
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
      version: 1
  );
}