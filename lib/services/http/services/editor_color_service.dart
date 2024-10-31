import 'package:onPlay/constants/endpoints/color_extension_endpoints.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/http/http_request.dart';

class EditorColorService {
  late HttpRequest<MusicColor> request;
  Settings settings;

  EditorColorService(this.settings);

  sendColors(MusicColor colors) async {
    for (var url in settings.share.editorUrls) {
      request = HttpRequest(url, (json) => MusicColor.fromJson(json));
      request.postRequestWithoutResponse(
          ColorExtensionEndpoints.changeTheme, colors);
    }
  }
}