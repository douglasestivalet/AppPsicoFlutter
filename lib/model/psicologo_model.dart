class Psicologo {

  int _codpsicologo;
  String _nomepsicologo;
  String _emailpsicologo;
  String _senhapsicologo;


  Psicologo(this._codpsicologo, this._nomepsicologo,
      this._emailpsicologo, this._senhapsicologo);

  Map<String, dynamic> toMap(){
    return {
      'nomepsicologo' : _nomepsicologo,
      'emailpsicologo' : _emailpsicologo,
      'senhapsicologo' : _senhapsicologo,
    };
  }

  set codpsicologo(int i){
    this._codpsicologo = i;
  }
  int get codpsicologo{
    return this._codpsicologo;
  }

  String get nomepsicologo{
    return this._nomepsicologo;
  }

  String get emailpsicologo{
    return this._emailpsicologo;
  }

  String get senhapsicologo{
    return this._senhapsicologo;
  }


  @override
  String toString() {
    // TODO: implement toString
    return 'Psicologo{id: $codpsicologo, nome: $nomepsicologo, email: $emailpsicologo, senha: $senhapsicologo}';
  }

}