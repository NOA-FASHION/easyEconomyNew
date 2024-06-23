import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easyeconomy/useCases/choix_description_enum_usecase.dart';
import 'package:easyeconomy/models/easy_economy_models.dart';

class MockChoixDesciptionEnumUseCase extends Mock
    implements ChoixDesciptionEnumUseCase {}

void main() {
  late ChoixDesciptionEnumUseCase choixDesciptionEnumUseCase;

  setUp(() {
    choixDesciptionEnumUseCase = ChoixDesciptionEnumUseCase();
  });

  test('Should return unity_description.tache when json is "tache"', () {
    // Arrange
    final json = "tache";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.tache);
  });

  test('Should return unity_description.commentaire when json is "commentaire"', () {
    // Arrange
    final json = "commentaire";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.commentaire);
  });

  test('Should return unity_description.image when json is "image"', () {
    // Arrange
    final json = "image";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.image);
  });

  test('Should return unity_description.achat when json is "achat"', () {
    // Arrange
    final json = "achat";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.achat);
  });

  test('Should return unity_description.echeancier when json is "echeancier"', () {
    // Arrange
    final json = "echeancier";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.echeancier);
  });

  test('Should return unity_description.information when json is "information"', () {
    // Arrange
    final json = "information";

    // Act
    final result = choixDesciptionEnumUseCase.execute(json);

    // Assert
    expect(result, unity_description.information);
  });
}