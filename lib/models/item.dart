import 'package:cloud_firestore/cloud_firestore.dart';
class Item {
  String title;
  bool done;

  DocumentReference reference;

  Item({this.title,this.done,this.reference});

  factory Item.fromSnapshot(DocumentSnapshot snapshot){
    Item item = Item.fromJson(snapshot.data);
    item.reference = snapshot.reference;
    return item;
  }

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }

}