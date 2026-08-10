// test/core/network/api_result_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/errors/failures.dart';
import 'package:ligerito/core/network/api_result.dart';

void main() {
  group('ApiSuccess', () {
    test('contiene data', () {
      final result = ApiSuccess('hola');
      expect(result.data, 'hola');
      expect(result, isA<ApiResult<String>>());
    });
  });

  group('ApiError', () {
    test('contiene failure', () {
      final failure = ServerFailure('boom');
      final result = ApiError<int>(failure);
      expect(result.failure.message, 'boom');
      expect(result, isA<ApiResult<int>>());
    });
  });

  group('ApiResult sealed pattern matching', () {
    test('ApiSuccess matchea case ApiSuccess', () {
      final result = ApiSuccess(42);
      expect(result, isA<ApiSuccess<int>>());
      if (result case ApiSuccess(:final data)) {
        expect(data, 42);
      }
    });

    test('ApiError matchea case ApiError', () {
      final result = ApiError<String>(NetworkFailure());
      expect(result, isA<ApiError<String>>());
      if (result case ApiError(:final failure)) {
        expect(failure, isA<NetworkFailure>());
      }
    });
  });
}
