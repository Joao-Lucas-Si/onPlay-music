import 'package:onPlay/constants/endpoints/color_extension_endpoints.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/http/http_request.dart';

class EditorColorService {
  late HttpRequest<MusicColor> request;

  EditorColorService(Settings settings) {
    request = HttpRequest(
        settings.share.editorUrl, (json) => MusicColor.fromJson(json));
  }

  sendColors(MusicColor colors) async {
    request.postRequestWithoutResponse(
        ColorExtensionEndpoints.changeTheme, colors);
  }
}
