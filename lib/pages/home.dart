
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo/models/item.dart';
import 'package:todo/pages/settings_form.dart';
import 'package:todo/repository/database.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final database repository = new database();

  @override
  Widget build(BuildContext context) {
    SettingsForm form = SettingsForm(this.repository);

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: form
        );
      });
    }

    void _showInfoPanel(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(8)),
            title: Text("Info sobre app"),
            content: Text("Aplicativo desenvolvido com propósito de demonstração de conhecimento trainee empresa Doarti"),
            actions: <Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Entendido")
              )
            ],
          );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Todo app")
        )
      ),
      body: StreamBuilder(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return const Text("Carregando ...");

          return ListView.builder(
            itemCount:  snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index){
              final itemDatabase = snapshot.data.documents[index];
              return Dismissible(
                child: CheckboxListTile(
                title:Text(itemDatabase['title'],
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor:1.5)
                ),
                value:itemDatabase['done'],
                onChanged: (value){
                 Item item = new Item.fromSnapshot(itemDatabase);
                 item.done = value;
                 repository.updateItem(item);
                },
              ),
              key: UniqueKey(),
              background: Container(
                color:Colors.red,
                child: Center(child:Text("Excluir",
                       style: TextStyle(color:Colors.white,fontSize: 20))
                       ),
              ),
              onDismissed: (direction) {
                repository.deleteItem(Item.fromSnapshot(itemDatabase));
              },
              );
            }
          );
        }
      ), 
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          
          SpeedDialChild(
            child:Icon(Icons.info_outline),
            label:"Info sobre app",
            onTap: ()=>{
              _showInfoPanel()
            }),
          SpeedDialChild(
            child:Icon(Icons.add),
            label:"Adicionar Item",
            onTap: ()=> {
              _showSettingsPanel()
            }),
        ],
      ),
    );
  }
  
}