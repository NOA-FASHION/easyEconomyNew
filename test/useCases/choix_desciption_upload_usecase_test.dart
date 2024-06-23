import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/choix_desciption_upload_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

void main() {
  late ChoixDesciptionUploadUseCase useCase;

  setUp(() {
    useCase = ChoixDesciptionUploadUseCase();
  });

  test('Should return "ChargeFixe" for unity_Montant_universelle.ChargeFixe', () {
    // Act
    final result = useCase.execute(unity_Montant_universelle.ChargeFixe);

    // Assert
    expect(result, "ChargeFixe");
  });

  test('Should return "RevenuFixe" for unity_Montant_universelle.RevenuFixe', () {
    // Act
    final result = useCase.execute(unity_Montant_universelle.RevenuFixe);

    // Assert
    expect(result, "RevenuFixe");
  });

  test('Should return "depensePonctuelle" for unity_Montant_universelle.depensePonctuelle', () {
    // Act
    final result = useCase.execute(unity_Montant_universelle.depensePonctuelle);

    // Assert
    expect(result, "depensePonctuelle");
  });

  test('Should return "RevenuPonctuel" for unity_Montant_universelle.RevenuPonctuel', () {
    // Act
    final result = useCase.execute(unity_Montant_universelle.RevenuPonctuel);

    // Assert
    expect(result, "RevenuPonctuel");
  });

  test('Should return "ChargeFixe" for any other value', () {
    // Act
    final result = useCase.execute(unity_Montant_universelle.ChargeFixe);

    // Assert
    expect(result, "ChargeFixe");
  });
}
