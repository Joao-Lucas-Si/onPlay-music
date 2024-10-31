import 'package:onPlay/models/settings/share.dart';

class ShareSettings {
  late final Function() _notify;
  List<String> _editorUrls = [];

  List<String> get editorUrls => _editorUrls;

  set editorUrls(List<String> urls) {
    _editorUrls = urls;
    _notify();
  }

  ShareSettings(
      {required Function(ShareSettings data) notify, DatabaseShareSettings? database}) {
    _notify = () {
      notify(this);
    };
    if (database != null) {
      editorUrls = database.editorUrls;
    }
  }

  addEditorUrl(String url) {
    _editorUrls.add(url);
    _notify();
  }
}
