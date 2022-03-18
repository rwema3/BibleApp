import 'package:bible/bible.dart' as bible;
import 'package:test/test.dart';
import 'secrets.dart' as secrets;

void main() {
  group('Test bible', () {
    test('Keys can be queried', () {
      bible.addKeys({'testapi': 'esvKey'});
