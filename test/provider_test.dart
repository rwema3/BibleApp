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
      var providers = bible.getProviders();
      providers.forEach((pro) async {
        var passage = await bible.queryPassage('Genesis 1:1-5', provider: pro)!;
        expect(passage, isNot(null));
        expect(passage.passage!.length, greaterThan(5));
        if (passage.verses != null) {
          expect(passage.verses!.length, equals(5));
        }
      });
    }, skip: true);

    test('BibleAPI', () async {
      var passage = await bible.queryPassage('Genesis 1:1-4',
          parameters: {'verse_numbers': 'true'}, providerName: 'bibleapi')!;
      expect(passage.passage, startsWith('(1)'));
    });
    test('Getbible', () async {
      var passage = await bible.queryPassage('Genesis 1-2',
          version: 'asv', providerName: 'getbible')!;
      expect(passage.verses!.length, equals(56));
      passage = await bible.queryPassage('Genesis 1:1-4',
          version: 'asv', providerName: 'getbible')!;
      expect(passage.verses!.length, equals(4));
      expect(passage.extra, isNot(null));
      expect(passage.version, equals('ASV'));

      passage = await bible.queryPassage('Genesis 1:1 - 2:3',
          version: 'akjv', providerName: 'getbible')!;
      expect(passage.verses!.length, equals(56));
      expect(passage.extra, isNot(null));
      expect(passage.reference, equals('Genesis 1-2'));
      expect(passage.version, equals('AKJV'));
    });

    test('ESV API', () async {
      if (bible.getKey('esvapi') == null) {
        return;
      }
      var passage = await bible.queryPassage('Genesis 1:1',
          providerName: 'esvapi',
          parameters: {'include-verse-numbers': 'true'})!;
      expect(
          passage.passage,
          equals(
              '[1] In the beginning, God created the heavens and the earth.'));
      expect(passage.version, equals('ESV'));
      passage = await bible.queryPassage(
    