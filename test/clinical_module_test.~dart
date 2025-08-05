import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clinical_module/clinical_module.dart';
import 'dart:convert';

class MockIap extends Mock implements InAppPurchasePlatform {}
class MockClient extends Mock implements http.Client {}
class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockIap mockIap;
  late MockClient mockHttp;
  late MockStorage mockStorage;
  late ClinicalModule module;

  setUp(() {
    mockIap = MockIap();
    mockHttp = MockClient();
    mockStorage = MockStorage();
    when(mockIap.isAvailable()).thenAnswer((_) async => true);
    when(mockIap.queryProductDetails({'clinical_module_pro'}))
        .thenAnswer((_) async => ProductDetailsResponse(productDetails: [ProductDetails(id: 'clinical_module_pro', title: '', description: '', price: '', rawPrice: 0.0, currencyCode: '')], notFoundIDs: {}));
    when(mockIap.queryPastPurchases())
        .thenAnswer((_) async => QueryPurchaseDetailsResponse(pastPurchases: [PurchaseDetails(productID: 'clinical_module_pro', status: PurchaseStatus.purchased)]));
    module = ClinicalModule(
      iap: mockIap,
      httpClient: mockHttp,
      storage: mockStorage,
      fhirServerUrl: 'https://fhir.test',
      apiKey: 'key',
    );
  });

  test('init succeeds', () async {
    await module.init();
  });
}
