class ShareSettings {
  late final Function() _notify;
  var _editorUrl = "";

  String get editorUrl => _editorUrl;

  ShareSettings(Function() notify) {
    _notify = notify;
  }

  set editorUrl(String url) {
    _editorUrl = url;
    _notify();
  }
}
