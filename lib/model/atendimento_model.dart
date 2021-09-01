import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/model/psicologo_model.dart';

class Atendimento {

  int _codatendimento;
  int _codpaciente;
  int _codpsicologo;
  DateTime _dataatendimento;

  Atendimento(this._codatendimento, this._codpaciente,
      this._codpsicologo, this._dataatendimento);

  Map<String, dynamic> toMap(){
    return {
      'codpaciente' : _codpaciente,
      'codpsicologo' : _codpsicologo,
      'dataatendimento' : _dataatendimento.toIso8601String(),
    };
  }

  set codatendimento(int i){
    this._codatendimento = i;
  }
  int get codatendimento{
    return this._codatendimento;
  }

  int get codpaciente{
    return this._codpaciente;
  }
  int get codpsicologo{
    return this._codpsicologo;
  }
  DateTime get dataatendimento{
    return this._dataatendimento;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Atendimento{id: $codatendimento, paciente: $codpaciente, psicologo: $codpsicologo, data: $dataatendimento}';
  }

}