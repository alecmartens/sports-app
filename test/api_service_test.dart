import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'package:sports_app/controller/api_service.dart';
import 'package:sports_app/enums/sports_league_enum.dart';
import './mocks.mocks.dart'; // <-- Make sure to adjust the path

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService(client: mockClient);
    });

    test('fetchMatches returns http.Response when called with SportsLeague.MLB',
        () async {
      final mockResponse = http.Response(jsonEncode({}), 200);

      when(mockClient.get(any, // will accept any URI
              headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final response = await apiService.fetchMatches(SportsLeague.MLB);

      expect(response, isNotNull);
      expect(response.statusCode, 200); // Verify if the status code is 200

      // Capture the arguments passed to the mocked method
      final capturedArguments =
          verify(mockClient.get(captureAny, headers: anyNamed('headers')))
              .captured;

      // Make assertions on the captured arguments
      final uriArg = capturedArguments[0] as Uri;
      expect(uriArg, isNotNull);
      expect(uriArg.toString(), contains('api-baseball.p.rapidapi.com'));
    });

    // Add similar tests for other leagues and edge cases if needed
  });
}
