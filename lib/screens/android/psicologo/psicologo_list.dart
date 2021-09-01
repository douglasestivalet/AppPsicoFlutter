import 'dart:io';
import 'package:codaula/database/psicologo_dao.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:codaula/screens/android/psicologo/psicologo_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class PsicologoList extends StatefulWidget {
  @override
  _PsicologoListState createState() => _PsicologoListState();
}

class _PsicologoListState extends State<PsicologoList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('PSICOLOGOS'),
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
              child: _futureBuilderPsicologo(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PsicologoScrean()))
                .then((value) {
              setState(() {
                debugPrint(' retornou do add psicologos ');
              });
            });
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _futureBuilderPsicologo() {
    return FutureBuilder<List<Psicologo>>(
      initialData: List(),
      future: PsicologoDAO().getPsicologos(),
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
            final List<Psicologo> psicologos = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Psicologo p = psicologos[index];
                return ItemPsicologo(
                  p,
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context) => PsicologoScrean(
                          psicologo: p,
                        )))
                        .then((value) {
                      setState(() {
                        debugPrint('...voltou do editar');
                      });
                    });
                  },
                );
              },
              itemCount: psicologos.length,
            );
            break;
        }
        return Text('Problemas em gerar a lista');
      },
    );
  }

  Widget _oldListPsicologo() {
    List<Psicologo> _psicologos = null;
    return ListView.builder(
        itemCount: _psicologos.length,
        itemBuilder: (context, index) {
          final Psicologo p = _psicologos[index];
          p.codpsicologo = index;
          return ItemPsicologo(
            p,
            onClick: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                  builder: (context) => PsicologoScrean(
                    psicologo: p,
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

class ItemPsicologo extends StatelessWidget {
  final Psicologo _psicologo;
  final Function onClick;

  ItemPsicologo(this._psicologo, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          leading: circleAvatar(),
          title:  Text(
            this._psicologo.nomepsicologo,
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                iconRemoveButton(context, (){
                  PsicologoDAO dao =  new PsicologoDAO();
                  dao.remove(_psicologo.codpsicologo);
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


