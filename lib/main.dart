import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/firebase_options.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/menu/presentation/di/menu_module.dart';
import 'package:sinonimo/sinonimos/menu/presentation/pages/menu.dart';
import 'package:sinonimo/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sinônimos',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: MenuModule(),
      home: const MenuPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SinonimosRepository _sinonimosRepository;

  // Future<void> uploadJsonToFirebase(BuildContext context) async {
  //   try {
  //     // Leia o arquivo JSON dos assets
  //     String jsonString = await rootBundle.loadString('assets/dados.json');
  //     List<dynamic> data = jsonDecode(jsonString);

  //     // Iterar sobre os itens do JSON e subir os dados ao Firestore
  //     for (var item in data) {
  //       // Nome da palavra principal
  //       String palavra = item['palavra'];

  //       // Transformar os sinônimos em uma lista
  //       List<String> sinonimosRaw = item['sinonimos'].split(',');
  //       List<Map<String, String>> sinonimosMap =
  //           sinonimosRaw.map((sinonimo) => {'nome': sinonimo.trim()}).toList();

  //       // Adicionar o documento principal
  //       DocumentReference docRef =
  //           await _firestore.collection('palavraPrincipal').add({
  //         'nome': palavra,
  //       });

  //       // Adicionar cada sinônimo como um documento na subcoleção
  //       for (var sinonimo in sinonimosMap) {
  //         await docRef.collection('sinonimos').add(sinonimo);
  //       }
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Dados importados com sucesso!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Erro ao importar os dados: $e')),
  //     );
  //   }
  // }

  @override
  void initState() {
    // FirebaseServiceImpl firebaseService = FirebaseServiceImpl();
    // _sinonimosRepository =
    //     SinonimosRepositoryImpl(sinonimosFirebaseService: firebaseService, sinonimosLocalDao: );
    super.initState();
  }

  final TextEditingController _palavraController = TextEditingController();
  List<String>? _sinonimos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sinônimos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextoEstilizado.h4("texto"),
            TextField(
              controller: _palavraController,
              decoration: const InputDecoration(labelText: "Palavra"),
            ),
            ElevatedButton(
              onPressed: () => {_sinonimosRepository.getSinonimos()},
              // onPressed: () => {uploadJsonToFirebase(context)},
              child: const Text("Salvar e Consultar"),
            ),
            if (_sinonimos != null)
              Text("Sinônimos: ${_sinonimos!.join(', ')}"),
          ],
        ),
      ),
    );
  }
}
