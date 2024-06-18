import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:easyeconomy/controllers/list_gestion_mensuel_controller.dart';
import 'package:easyeconomy/controllers/list_montant_prevision_controller.dart';
import 'package:easyeconomy/controllers/list_montant_universelle_controller.dart';
import 'package:easyeconomy/services/service_locator.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:easyeconomy/useCases/generate_gestion_mensuel_prevision_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/add_montant_gestion_usecase.dart';
import 'package:easyeconomy/useCases/gestionMensuelUsecase/remove_gestion_mensuel_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/add_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantPrevisionUsecase/save_montant_prevision_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/add_montant_universelle_usecase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easyeconomy/screens/guest_screen_start.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  configureDependencies(
      sharedPreferences); // Initialisez les dépendances avec SharedPreferences
  runApp(EasyEconomy());
}

class EasyEconomy extends StatefulWidget {
  @override
  _EasyEconomyState createState() => _EasyEconomyState();
}

class _EasyEconomyState extends State<EasyEconomy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'EasyEconomy',
      home: ChangeNotifierProvider<EasyController>(
        create: (context) => EasyController(
          getIt<ListGestionMensuelController>(),
          getIt<SharedPreferences>(),
          getIt<ListMontantUniverselleController>(),
          getIt<ChoixDesciptionDetailsFinanceEnumUseCase>(),
          getIt<ChoixDesciptionEnumUseCase>(),
          getIt<ListMontantPrevisionController>(),
          getIt<GenerateGestionMensuelPrevisionUseCase>(),
          
        ),
        child: GuestScreenStart1(),
      ),
    );
  }
}
