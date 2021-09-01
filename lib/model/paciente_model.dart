import 'package:codaula/model/psicologo_model.dart';

class Paciente {

  int _codpaciente;
  String _nomepaciente;
  int _idade;
 int _codpsicologo;

 Paciente(this._codpaciente, this._nomepaciente,
      this._idade, this._codpsicologo);

 Map<String, dynamic> toMap(){
   return {
     'nomepaciente' : _nomepaciente,
     'idade' : _idade,
     'codpsicologo' : _codpsicologo,
   };
 }


  set codpaciente(int i){
    this._codpaciente = i;
  }
  int get codpaciente{
    return this._codpaciente;
  }

  String get nomepaciente{
    return this._nomepaciente;
  }
  int get idade{
    return this._idade;
  }
 // int get codpsicologo{
 //   return this._codpsicologo;
 // }
 int get codpsicologo{
   return this._codpsicologo;
 }

  @override
  String toString() {
    // TODO: implement toString
    return 'Paciente{id: $codpaciente, nome: $nomepaciente, idade: $idade, psicologo: $codpsicologo}';
  }

}