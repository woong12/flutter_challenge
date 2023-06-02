typedef void DictionaryCallback(String term, String definition);

class Dictionary {
  late Map<String, String> _entries;

  Dictionary() {
    _entries = {};
  }

  void add(String term, String definition) {
    _entries[term] = definition;
  }

  String? get(String term) {
    return _entries[term];
  }

  void delete(String term) {
    _entries.remove(term);
  }

  void update(String term, String definition) {
    if (_entries.containsKey(term)) {
      _entries[term] = definition;
    } else {
      print("단어가 사전에 존재하지 않습니다.");
    }
  }

  void showAll() {
    _entries.forEach((term, definition) {
      print('$term: $definition');
    });
  }

  int count() {
    return _entries.length;
  }

  void upsert(String term, String definition) {
    _entries[term] = definition;
  }

  bool exists(String term) {
    return _entries.containsKey(term);
  }

  void bulkAdd(List<Map<String, String>> words) {
    words.forEach((word) {
      final term = word['term'];
      final definition = word['definition'];
      if (term != null && definition != null) {
        _entries[term] = definition;
      }
    });
  }

  void bulkDelete(List<String> terms) {
    terms.forEach((term) {
      _entries.remove(term);
    });
  }
}

void main() {
  var dictionary = Dictionary();

  dictionary.add('apple', '사과');
  dictionary.add('banana', '바나나');
  dictionary.add('cherry', '체리');

  print(dictionary.get('apple'));

  dictionary.delete('banana');

  dictionary.update('apple', '신선한 사과');
  dictionary.update('orange', '오렌지');

  dictionary.showAll();

  print(dictionary.count());

  dictionary.upsert('kiwi', '키위');
  dictionary.upsert('apple', '맛있는 사과');

  print(dictionary.exists('kiwi'));
  print(dictionary.exists('grape'));

  var wordsToAdd = [
    {"term": "pear", "definition": "배"},
    {"term": "melon", "definition": "멜론"}
  ];
  dictionary.bulkAdd(wordsToAdd);

  dictionary.bulkDelete(['cherry', 'kiwi']);

  dictionary.showAll();
}
