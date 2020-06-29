import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/item.dart';

class database{
  final CollectionReference itemCollection = Firestore.instance.collection('todo');

  Stream<QuerySnapshot> getStream(){
    return itemCollection.snapshots();
  }

  Future<DocumentReference> addItem(Item item){
    return itemCollection.add(item.toJson());
  }

  updateItem(Item item) async{
    await itemCollection.document(item.reference.documentID).updateData(item.toJson());
  }
  Future deleteItem(Item item){
    return itemCollection.document(item.reference.documentID).delete();
  }
}