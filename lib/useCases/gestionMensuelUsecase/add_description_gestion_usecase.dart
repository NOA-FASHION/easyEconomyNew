import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuel_usecase.dart';


@injectable
class AddDescriptionGestionUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;
  final ChoixDesciptionEnumUseCase choixDesciptionEnumUseCase;

  AddDescriptionGestionUseCase(
    this.saveGestionMensuelUseCase,
    this.choixDesciptionEnumUseCase,
  );

  Future<void> execute({
    required List<double> achat,
    required double previsions,
    required double echeance,
    required double nombreEcheance,
    required String id,
    required String adresseImage,
    required String name,
    required String commentaire,
    required int indexGestionMensuel,
    required int indexGestionMensuelMontantUniv,
    required String description,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle[indexGestionMensuelMontantUniv]
        .descriptionUniverselle
        .add(DesciprtionUniverselle(
            adresseImage: adresseImage,
            commentaire: commentaire,
            description: choixDesciptionEnumUseCase.execute(description),
            echeance: echeance,
            id: id,
            name: name,
            previsions: previsions,
            nombreEcheance: nombreEcheance));
    await saveGestionMensuelUseCase.execute(listGestionMensuel);
  }
}
