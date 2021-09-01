import 'dart:io';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/paciente/paciente_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PacienteList extends StatefulWidget {
  @override
  _PacienteListState createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PACIENTES'),
        actions: [IconButton(
          onPressed: (){
            setState(() {
              print('....');
            });
          },
          icon: Icon(Icons.update),
        )],
      ),
      body: Column(
        children: <Widget>[
          Container(
            //color: Colors.red,
            child: TextField(
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: "Pesquisar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: _futureBuilderPaciente(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PacienteScrean()))
                .then((value) {
              setState(() {
                debugPrint(' retornou do add pacientes ');
              });
            });
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _futureBuilderPaciente() {
    return FutureBuilder<List<Paciente>>(
      initialData: List(),
      future: PacienteDAO().getPacientes(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Loading')
                ],
              ),
            );
            break;
          case ConnectionState.active:
            break;

          case ConnectionState.done:
            final List<Paciente> pacientes = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Paciente p = pacientes[index];
                return ItemPaciente(
                  p,
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => PacienteScrean(
                                  paciente: p,
                                )))
                        .then((value) {
                      setState(() {
                        debugPrint('...voltou do editar');
                     });
                    });
                  },
                );
              },
              itemCount: pacientes.length,
            );
            break;
        }
        return Text('Problemas em gerar a lista');
      },
    );
  }

  Widget _oldListPaciente() {
    List<Paciente> _pacientes = null;
    return ListView.builder(
        itemCount: _pacientes.length,
        itemBuilder: (context, index) {
          final Paciente p = _pacientes[index];
          p.codpaciente = index;
          return ItemPaciente(
            p,
            onClick: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => PacienteScrean(
                            paciente: p,
                          )))
                  .then((value) {
                setState(() {
                  debugPrint('... voltou do editar');
                });
              });
            },
          );
        });
  }
}

class ItemPaciente extends StatelessWidget {
  final Paciente _paciente;
  final Function onClick;

  ItemPaciente(this._paciente, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          leading: circleAvatar(),
          title:  Text(
            this._paciente.nomepaciente,
            style: TextStyle(fontSize: 25),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                iconRemoveButton(context, (){
                 PacienteDAO dao =  new PacienteDAO();
                 dao.remove(_paciente.codpaciente);
                 Navigator.of(context).pop();
                })
              ],
            ),
          ),
          ),

        Divider(
          color: Colors.blueAccent,
          indent: 10.0,
          endIndent: 20,
          thickness: 2.0,
          height: 10.0,
        )
      ],
    );
  }
  CircleAvatar circleAvatar()  {
    return
      CircleAvatar(child: Icon(Icons.assignment_ind_sharp));
  }
  Widget iconRemoveButton(BuildContext context, Function remove){
    return IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder:  (context) => AlertDialog(
                title: Text('Excluir'),
                content: Text('Confirma a Exclusão?'),
                actions: [
                  FlatButton(
                    child: Text('Não'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Sim'),
                    onPressed: remove,
                  ),
                ],
              )
          );
        }
    );
  }
}
