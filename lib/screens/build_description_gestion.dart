import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:provider/provider.dart';

import 'package:easyeconomy/controllers/easy_Controller.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';
import 'package:easyeconomy/screens/play_commentaires.dart';
import 'package:easyeconomy/screens/play_images.dart';

class BuildDescriptionGestion extends StatefulWidget {
  final String idGestionMontantUniverselle;
  final int indexGestionMensuel;
  final int indexGestionMensuelMontantUniv;

  BuildDescriptionGestion({
    required this.idGestionMontantUniverselle,
    required this.indexGestionMensuel,
    required this.indexGestionMensuelMontantUniv,
  });

  @override
  _BuildDescriptionGestionState createState() => _BuildDescriptionGestionState();
}

class _BuildDescriptionGestionState extends State<BuildDescriptionGestion> with SingleTickerProviderStateMixin {
  FocusNode myFocusNode = FocusNode();
  TextEditingController textEditingControllerAnimated = TextEditingController();
  final picker = ImagePicker();
  bool formation = false;
  late String chapitre;
  var modifDecription1;
  var colors;
  var documentJoint;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    textEditingControllerAnimated.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  String modifDescription(String description) {
    switch (description) {
      case "achat":
        return "Achat";
      case "commentaire":
        return "Commentaire";
      case "image":
        return "Image";
      case "information":
        return "Information";
      case "echeancier":
        return "Échéancier";
      case "tache":
        return "Tâche";
      default:
        return "Tâche";
    }
  }

  Color colorsDescription(String description) {
    switch (description) {
      case "achat":
        return Colors.cyan;
      case "commentaire":
        return Colors.blueGrey;
      case "image":
        return Colors.pink;
      case "paiement":
        return Colors.yellow;
      case "echeancier":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Widget echeancierWidget(String description, List<DesciprtionUniverselle> listdescript, int index) {
    if (description == "echeancier") {
      return Container(
        width: MediaQuery.of(context).size.width / 1.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Row(
                children: [
                  Text("Nombre d'échéances ", style: TextStyle(color: Colors.blue)),
                  Text(listdescript[index].nombreEcheance.toStringAsFixed(0)),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Row(
                children: [
                  Text("Montant échéance ", style: TextStyle(color: Colors.blue)),
                  SizedBox(width: 15.0),
                  Text(listdescript[index].echeance.toStringAsFixed(2) + "\$"),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Row(
                children: [
                  Text("Echéance en cours ", style: TextStyle(color: Colors.blue)),
                  SizedBox(width: 15.0),
                  Text((listdescript[index].echeance * listdescript[index].nombreEcheance).toStringAsFixed(2) + "\$"),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (description == "achat") {
      return Container(
        width: MediaQuery.of(context).size.width / 1.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Text("Prix " + listdescript[index].previsions.toStringAsFixed(2) + "\$"),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(width: 5.0);
    }
  }

  Widget maxLetter(String word, String comment) {
    if (word.length > 29 && comment.length <= 5) {
      return Container(
        width: MediaQuery.of(context).size.width / 2.55,
        color: Colors.transparent,
        child: MarqueeText(
          text: TextSpan(text: word),
          style: TextStyle(color: Colors.black),
          speed: 30,
        ),
      );
    } else if (word.length > 20 && comment.length > 5) {
      return Container(
        width: MediaQuery.of(context).size.width / 2.55,
        color: Colors.transparent,
        child: MarqueeText(
          text: TextSpan(text: word),
          style: TextStyle(color: Colors.black),
          speed: 30,
        ),
      );
    } else {
      return Text(word);
    }
  }

  Widget formationEdit(EasyController provider, String description) {
    if (description == "echeancier") {
      return IconButton(
        alignment: Alignment.topRight,
        icon: Icon(Icons.edit, color: Colors.black),
        onPressed: () {
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.bottomToTop,
          //         child: ChangeNotifierProvider.value(
          //             value: provider,
          //             child: PaiementEdit(
          //                 item: item, indexChallenge: widget.indexChallenge))));
        },
      );
    } else if (description == "achat") {
      return IconButton(
        alignment: Alignment.topRight,
        icon: Icon(Icons.edit, color: Colors.black),
        onPressed: () {
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.bottomToTop,
          //         child: ChangeNotifierProvider.value(
          //             value: provider,
          //             child: AchatEdit(
          //                 item: item, indexChallenge: widget.indexChallenge))));
        },
      );
    } else {
      return SizedBox(width: 5.0);
    }
  }

  Widget prixCout(double prix, double cout) {
    if (prix > 0) {
      return Text("Prix : " + prix.toString() + "\$");
    } else if (cout > 0) {
      return Text("Montant : " + cout.toString() + "\$");
    } else {
      return SizedBox(width: 5.0);
    }
  }

  Widget activeGlow(DesciprtionUniverselle description, int index, List<DesciprtionUniverselle> listDescription) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 15.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.65,
                      height: 25.0,
                      child: Row(
                        children: [
                          Text(
                            modifDescription(description.description.toString().replaceAll(unityPattern, "")),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorsDescription(description.description.toString().replaceAll(unityPattern, ""))
                            ),
                          ),
                          SizedBox(width: 5.0),
                          maxLetter(description.name.toString(), description.description.toString().replaceAll(unityPattern, "")),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    echeancierWidget(description.description.toString().replaceAll(unityPattern, ""), listDescription, index),
                  ],
                ),
                iconDataJoin(description.description.toString().replaceAll(unityPattern, "")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconDataJoin(String resultat) {
    switch (resultat) {
      case "image":
        return Icon(Icons.photo_size_select_large, size: 30.0, color: Colors.pink);
      case "commentaire":
        return Icon(Icons.comment, size: 30.0, color: Colors.blueGrey);
      case "achat":
        return Icon(Icons.shopping_cart, size: 30.0, color: Colors.cyan);
      case "information":
        return Icon(Icons.info, size: 30.0, color: Colors.yellow);
      case "tache":
        return Icon(Icons.task, size: 30.0, color: Colors.blue);
      case "echeancier":
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
          elevation: 15.0,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Lottie.asset('assets/bankOut.json', height: 50)
            )
          ),
        );
      default:
        return Icon(Icons.block, size: 30.0);
    }
  }

  String unityPattern = "unity_description.";

  @override
  Widget build(BuildContext context) {
    EasyController providerType = Provider.of<EasyController>(context);
    List<DesciprtionUniverselle> ListDesription = providerType.getGestionMensuelDescription(
      widget.indexGestionMensuel, widget.indexGestionMensuelMontantUniv
    );

    if (ListDesription.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Pas de description en cours.",
          style: TextStyle(color: Colors.orange[600], fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: ListDesription.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
          child: Dismissible(
            key: Key(UniqueKey().toString()),  // Utilisation de Key unique
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
                  content: "La tâche a bien été validée",
                  lotties: 'assets/challenge.json'
                ));
                providerType.achatTotals(
                  widget.idGestionMontantUniverselle,
                  widget.indexGestionMensuel,
                  widget.indexGestionMensuelMontantUniv,
                  index
                );
                providerType.removeGestionDescriptionGestion(
                  idGestionMensMontanUniv: widget.idGestionMontantUniverselle,
                  index: index,
                  indexGestionMensMontanUniv: widget.indexGestionMensuelMontantUniv,
                  indexGestionMensuel: widget.indexGestionMensuel
                );
              }

              if (direction == DismissDirection.startToEnd) {
                ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
                  content: "La description a bien été supprimée",
                  lotties: 'assets/trash.json'
                ));
                providerType.removeGestionDescriptionGestion(
                  idGestionMensMontanUniv: widget.idGestionMontantUniverselle,
                  index: index,
                  indexGestionMensMontanUniv: widget.indexGestionMensuelMontantUniv,
                  indexGestionMensuel: widget.indexGestionMensuel
                );
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                final bool? resultat = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirmation", style: TextStyle(color: Colors.blue)),
                      content: Text("Voulez-vous supprimer la description ?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text("Oui"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Non"),
                        )
                      ],
                    );
                  }
                );
                return resultat;
              }
              return true;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete, size: 35.0, color: Colors.white),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerRight,
              color: Colors.green,
              child: Icon(Icons.check, size: 30.0, color: Colors.white),
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 45.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.0, 3.0),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                elevation: 20.0,
                child: ListTile(
                  onTap: () async {
                    if (ListDesription[index].description.toString().replaceAll(unityPattern, "") == "commentaire") {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: providerType,
                          child: PlayCommentaire(commentaire: ListDesription[index].commentaire),
                        )
                      ));
                    } else if (ListDesription[index].description.toString().replaceAll(unityPattern, "") == "image") {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: providerType,
                          child: PlayPicture(patchPicture: ListDesription[index].adresseImage),
                        )
                      ));
                    }
                  },
                  title: Container(
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 15.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text(
                                  "Document".toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                                ),
                                SizedBox(width: 5.0),
                                Text(ListDesription[index].name),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),
                  subtitle: activeGlow(ListDesription[index], index, ListDesription),
                  isThreeLine: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SnackBar _buildSnackBar({required String? content, required String lotties}) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Container(
        height: 80,
        child: Row(
          children: [
            Lottie.asset(lotties, width: 60),
            Text(
              content!,
              style: TextStyle(color: Colors.purple),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
