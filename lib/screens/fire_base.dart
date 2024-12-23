
import 'package:cloud_firestore/cloud_firestore.dart';

void addMovieToFirestore(String name, String price) {
  FirebaseFirestore.instance.collection('makeup').add({
    'name': name,
    'price': price,
    'timestamp': FieldValue.serverTimestamp(), 
  });
}
