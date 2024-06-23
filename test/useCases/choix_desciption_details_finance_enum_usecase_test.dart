import 'package:flutter_test/flutter_test.dart';
import 'package:easyeconomy/useCases/choix_desciption_details_finance_enum_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

void main() {
  late ChoixDesciptionDetailsFinanceEnumUseCase useCase;

  setUp(() {
    useCase = ChoixDesciptionDetailsFinanceEnumUseCase();
  });

  test('Should return ChargeFixe for "ChargeFixe"', () {
    // Act
    final result = useCase.execute("ChargeFixe");

    // Assert
    expect(result, unity_Montant_universelle.ChargeFixe);
  });

  test('Should return RevenuFixe for "RevenuFixe"', () {
    // Act
    final result = useCase.execute("RevenuFixe");

    // Assert
    expect(result, unity_Montant_universelle.RevenuFixe);
  });

  test('Should return depensePonctuelle for "depensePonctuelle"', () {
    // Act
    final result = useCase.execute("depensePonctuelle");

    // Assert
    expect(result, unity_Montant_universelle.depensePonctuelle);
  });

  test('Should return RevenuPonctuel for "RevenuPonctuel"', () {
    // Act
    final result = useCase.execute("RevenuPonctuel");

    // Assert
    expect(result, unity_Montant_universelle.RevenuPonctuel);
  });

  test('Should return ChargeFixe for any other value', () {
    // Act
    final result = useCase.execute("Unknown");

    // Assert
    expect(result, unity_Montant_universelle.ChargeFixe);
  });
}
