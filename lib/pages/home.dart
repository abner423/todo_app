import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo/models/item.dart';
import 'package:todo/pages/settings_form.dart';


class HomePage extends StatefulWidget {
  List items = new List<Item>();

  HomePage(){
    items.add(Item(title: "Fazer dever de casa",done:true));
    items.add(Item(title: "Efetuar limpeza do carro",done:true));
    items.add(Item(title: "limpar os copos",done:false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void remove(int index){
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsForm form = SettingsForm(this,widget.items);
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
        child: form
      );
    });
  }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Todo app")
        )
      ),
      body: ListView.builder(
        itemCount:widget.items.length,
        itemBuilder: (BuildContext context, int index){
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
            title:Text(item.title,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor:1.5)
            ),
            value:item.done,
            onChanged: (value){
              setState(() {
                item.done = value;
              });
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
            remove(index);
          },
          );
        }
      ), 
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child:Icon(Icons.add),
            label:"Adicionar Item",
            onTap: ()=> {
              _showSettingsPanel()
            }),
          SpeedDialChild(
            child:Icon(Icons.lightbulb_outline),
            label:"Ativar modo escuro",
            onTap: ()=>print("Ativar dark Mode")),
          SpeedDialChild(
            child:Icon(Icons.edit),
            label:"Alterar Item",
            onTap: ()=>print("Alterar Item")),
        ],
      ),
    );
  }
  
}