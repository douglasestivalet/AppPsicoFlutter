import 'dart:io';
import 'package:codaula/database/atendimento_dao.dart';
import 'package:codaula/model/atendimento_model.dart';
import 'package:codaula/screens/android/atendimento/atendimento_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AtendimentoList extends StatefulWidget {
  @override
  _AtendimentoListState createState() => _AtendimentoListState();
}

class _AtendimentoListState extends State<AtendimentoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATENDIMENTOS'),
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
                hintText: "       DIA        |       HORA",
                prefixIcon: Icon(Icons.check_circle_outline),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: _futureBuilderAtendimento(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => AtendimentoScrean()))
                .then((value) {
              setState(() {
                debugPrint(' retornou do add atendimentos ');
              });
            });
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _futureBuilderAtendimento() {
    return FutureBuilder<List<Atendimento>>(
      initialData: List(),
      future: AtendimentoDAO().getAtendimentos(),
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
            final List<Atendimento> atendimentos = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Atendimento p = atendimentos[index];
                return ItemAtendimento(
                  p,
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => AtendimentoScrean(
                                  atendimento: p,
                                )))
                        .then((value) {
                      setState(() {
                        debugPrint('...voltou do editar');
                      });
                    });
                  },
                );
              },
              itemCount: atendimentos.length,
            );
            break;
        }
        return Text('Problemas em gerar a lista');
      },
    );
  }

  Widget _oldListAtendimento() {
    List<Atendimento> _atendimentos = null;
    return ListView.builder(
        itemCount: _atendimentos.length,
        itemBuilder: (context, index) {
          final Atendimento p = _atendimentos[index];
          p.codatendimento = index;
          return ItemAtendimento(
            p,
            onClick: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => AtendimentoScrean(
                            atendimento: p,
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

class ItemAtendimento extends StatelessWidget {
  final Atendimento _atendimento;
  final Function onClick;

  ItemAtendimento(this._atendimento, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          leading: circleAvatar(),
          title:  Text(
            this._atendimento.dataatendimento.toString(),
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                iconRemoveButton(context, (){
                  AtendimentoDAO dao =  new AtendimentoDAO();
                  dao.remove(_atendimento.codatendimento);
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
      CircleAvatar(child: Icon(Icons.calendar_today));
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
