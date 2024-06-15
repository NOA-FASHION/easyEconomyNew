import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:easyeconomy/useCases/montantUniverselleUsecase/save_montant_universelle_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class AddDescriptionMontantUniverselleUseCase {
  final ChoixDesciptionEnumUseCase choixDesciptionEnumUseCase;
  final SaveMontantUniverselleUseCase saveUniverselleUseCase;

  AddDescriptionMontantUniverselleUseCase(
    this.choixDesciptionEnumUseCase,
    this.saveUniverselleUseCase,
  );

  Future<void> execute({
    required List<MontantUniverselle> listMontantUniverselle,
    required List<double> achat,
    required double previsions,
    required double echeance,
    required double nombreEcheance,
    required String id,
    required String adresseImage,
    required String name,
    required String commentaire,
    required int indexChargeFixe,
    required String description,
  }) async {
    listMontantUniverselle[indexChargeFixe].descriptionUniverselle.add(
      DesciprtionUniverselle(
        adresseImage: adresseImage,
        commentaire: commentaire,
        description: choixDesciptionEnumUseCase.execute(description),
        echeance: echeance,
        id: id,
        name: name,
        previsions: previsions,
        nombreEcheance: nombreEcheance,
      ),
    );

    await saveUniverselleUseCase.execute(listMontantUniverselle,false);
  }
}
