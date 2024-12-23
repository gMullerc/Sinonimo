import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinonimo/sinonimo/utils/typedef.dart';

abstract class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FutureListMapStringDynamic getSinonimos();
}

class FirebaseServiceImpl extends FirebaseService {
  @override
  FutureListMapStringDynamic getSinonimos() async {
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
        'id': doc.id, // ID da palavra principal
        'nome': palavra,
        'sinonimos': sinonimosList
      });
    }

    return sinonimos;
  }
}
