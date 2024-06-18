import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

import 'save_gestion_mensuelle_montant_univ_usecase.dart';

@injectable
class RemoveGestionMensuelleMontantUnivUseCase {
  final SaveGestionMensuelleMontantUnivUseCase saveGestionMensuelleMontantUnivUseCase;

  RemoveGestionMensuelleMontantUnivUseCase(this.saveGestionMensuelleMontantUnivUseCase);

  Future<void> execute({
    required bool validation,
    required int indexGestionMensuel,
    required int indexGestionMensMontanUniv,
    required String idGestionMensMontanUniv,
    required List<GestionMensuel> listGestionMensuel,
  }) async {
    if (validation) {
      listGestionMensuel[indexGestionMensuel].montantUniverselleLive.add(
            MontantUniverselle(
                unity: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .unity,
                id: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .id,
                montant: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .montant,
                nom: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .nom,
                descriptionUniverselle: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .descriptionUniverselle,
                achat: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .achat,
                previsionsTotal: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .previsionsTotal,
                icones: listGestionMensuel[indexGestionMensuel]
                    .montantUniverselle[indexGestionMensMontanUniv]
                    .icones),
          );
    }

    listGestionMensuel[indexGestionMensuel]
        .montantUniverselle
        .removeAt(indexGestionMensMontanUniv);

    await saveGestionMensuelleMontantUnivUseCase.execute(
      remove: true,
      idGestionMensMontanUniv: idGestionMensMontanUniv,
      listGestionMensuel: listGestionMensuel,
    );
  }
}
