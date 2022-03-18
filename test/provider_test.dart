import 'package:bible/bible.dart' as bible;
import 'package:test/test.dart';
import 'secrets.dart' as secrets;

void main() {
  group('Test bible', () {
    test('Keys can be queried', () {
      bible.addKeys({'testapi': 'esvKey'});
      expect(bible.getKey('testapi'), equals('esvKey'));
      bible.removeKey('testapi');
      expect(bible.getKey('testapi'), equals(null));
    });
  });

  // TODO: Make a general API test
  group('Test API Providers', () {
    setUp(() {
      var keys = getKeys();
      bible.addKeys(keys);
    });

    test('All Providers', () async {
