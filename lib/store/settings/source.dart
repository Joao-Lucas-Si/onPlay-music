import 'package:onPlay/models/settings/source.dart';

class SourceSettings {
  late final Function() _notify;
  List<String> _invidiousInstances = ["https://inv.nadeko.net/"];

  List<String> get invidiousInstances => _invidiousInstances;

  set invidiousInstances(List<String> instances) {
    _invidiousInstances = instances;
    _notify();
  }

  SourceSettings(
      {required Function(SourceSettings data) notify,
      DatabaseSourceSettings? database}) {
    _notify = () {
      notify(this);
    };
    if (database != null) {
      //_invidiousInstances = database.invidiousInstances;
    }
  }

  addInvidiousInstance(String instance) {
    _invidiousInstances.add(instance);
    _notify();
  }
}
