import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';
import 'package:todo/pages/home.dart';

class SettingsForm extends StatefulWidget {
String itemName = "";
State parent;
List items;
SettingsForm(this.parent,this.items);
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Text("Adicionar novo Item",
          style: TextStyle(fontSize:18.0)),
          SizedBox(height: 20.0),
          TextFormField(
            validator:(val) => val.isEmpty ? "Por favor, digite uma tarefa" : null,
            onChanged: (val) => setState(() => widget.itemName = val)
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.blue,
            child:Text(
              "Incluir Item",
              style:TextStyle(color: Colors.white)
            ),
            onPressed: (){
              if(widget.itemName.isNotEmpty && widget.itemName.trim() != ""){
                widget.parent.setState(() {
                  widget.items.add(Item(title: widget.itemName,done:false));
                });
              }
            },
          )
        ],),
    );
  }
}