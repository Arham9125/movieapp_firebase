
import 'package:cloud_firestore/cloud_firestore.dart';

void addMovieToFirestore(String title) {
  FirebaseFirestore.instance.collection('movies').add({
    'title': title,
    'timestamp': FieldValue.serverTimestamp(), 
  });
}
