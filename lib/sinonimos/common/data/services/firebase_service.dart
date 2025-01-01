import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getSinonimos();
}

class FirebaseServiceImpl extends FirebaseService {
  @override
  Future<List<Map<String, dynamic>>> getSinonimos() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("palavraPrincipal").get();

    List<Map<String, dynamic>> sinonimos = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String palavra = data['nome'];

      QuerySnapshot sinonimosSnapshot = await _firestore
          .collection("palavraPrincipal")
          .doc(doc.id)
          .collection("sinonimos")
          .get();

      List<Map<String, dynamic>> sinonimosList =
          sinonimosSnapshot.docs.map((sinonimoDoc) {
        Map<String, dynamic> sinonimoData =
            sinonimoDoc.data() as Map<String, dynamic>;
        sinonimoData['id'] = sinonimoDoc.id;
        return sinonimoData;
      }).toList();

      sinonimos.add({
        'id': doc.id,
        'nome': palavra,
        'sinonimos': sinonimosList,
      });
    }

    return sinonimos;
  }
}
