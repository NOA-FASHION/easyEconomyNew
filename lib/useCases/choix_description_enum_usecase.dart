import 'package:injectable/injectable.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

@injectable
class ChoixDesciptionEnumUseCase {
  unity_description execute(dynamic json) {
    unity_description unity = unity_description.tache;

    if (json == "tache") {
      unity = unity_description.tache;
    } else if (json == "commentaire") {
      unity = unity_description.commentaire;
    } else if (json == "image") {
      unity = unity_description.image;
    } else if (json == "achat") {
      unity = unity_description.achat;
    } else if (json == "echeancier") {
      unity = unity_description.echeancier;
    } else if (json == "information") {
      unity = unity_description.information;
    }

    return unity;
  }
}
