import 'save_gestion_mensuel_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';


@injectable
class RemoveGestionMensuelleMontantUnivLiveUseCase {
  final SaveGestionMensuelUseCase saveGestionMensuelUseCase;

  RemoveGestionMensuelleMontantUnivLiveUseCase(this.saveGestionMensuelUseCase);

  Future<void> execute({
    required bool validation,
    required int indexGestionMensuel,
    required int indexGestionMensMontanUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    if (validation) {
      listGestionMensuel[indexGestionMensuel].montantUniverselle.add(
            MontantUniverselle(
                unity: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .unity,
                id: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .id,
                montant: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .montant,
                nom: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .nom,
                descriptionUniverselle: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .descriptionUniverselle,
                achat: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .achat,
                previsionsTotal: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .previsionsTotal,
                icones: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselleLive[indexGestionMensMontanUniv]
                    .icones),
          );
    }

    listGestionMensuel[indexGestionMensuel]
        .montantUniverselleLive
        .removeAt(indexGestionMensMontanUniv);

    await saveGestionMensuelUseCase.execute(listGestionMensuel, remove: false);
  }
}
