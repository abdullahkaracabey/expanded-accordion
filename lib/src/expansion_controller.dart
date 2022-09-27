import 'package:flutter/foundation.dart';

class ExpansionController extends ChangeNotifier {
  double _containerHeight = 0.0;
  double _marginBetweenItems = 16.0;

  final Map<Key, double> _itemWidgets = <Key, double>{};

  set marginBetweenItems(double margin) {
    _marginBetweenItems = margin;
  }

  Key? _expandedKey;
  double get expandSize {
    var panelSize = 0.0;
    _itemWidgets.forEach((key, value) {
      if (_expandedKey != key) panelSize += value;

      debugPrint("size ${key}, ${value}");
    });
    return _containerHeight -
        panelSize -
        (_itemWidgets.length - 1) * _marginBetweenItems;
  }

  Key? get expandedKey => _expandedKey;

  set containerHeight(double height) {
    _containerHeight = height;
    notifyListeners();
  }

  double get containerHeight => _containerHeight;

  void addItemWidget(Key key, double height) {
    _itemWidgets[key] = height;
    if (_expandedKey == null) _expandedKey = key;
    // notifyListeners();
  }

  set expandedKey(Key? key) {
    _expandedKey = key;
    notifyListeners();
  }

  double heightForKey(Key key) {
    return _itemWidgets[key]!;
  }
}
