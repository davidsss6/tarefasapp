import 'package:flutter/material.dart';
import 'package:listatarefasapp/pages/lista_de_tarefas_mobx.dart';
import 'package:listatarefasapp/service/dark_mode_service.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(create: (_) => DarkModeService()), 

      ],
      child: Consumer<DarkModeService>(builder: (_, darkModeService, widget){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lista de Tarefas',
            theme: darkModeService.isDarkMode  ? ThemeData.dark() : ThemeData.light(),
            home: const ListaTarefasMobxPageState()
            // home: const ListaTarefasPAgeState(),
          );
        },
      )
      //home: const ImcPagState(),
    );
  }
}