import 'package:flutter/material.dart';
import 'package:onPlay/constants/endpoints/color_extension_endpoints.dart';
import 'package:onPlay/dtos/json/editor_colors_dto.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/services/http/http_request.dart';

// 6900-idx-icons-v-1729204082859.cluster-qhrn7lb3szcfcud6uanedbkjnm.cloudworkstations.dev

class EditorColorService {
  late HttpRequest<EditorColorsDto> request;
  Settings settings;

  EditorColorService(this.settings);

  sendColors(EditorColorsDto colors) async {
    for (var url in settings.share.editorUrls) {
      request = HttpRequest(url, EditorColorsDto.fromJson);
      debugPrint(colors.toJson().toString());
      request.postRequestWithoutResponse(
          ColorExtensionEndpoints.changeTheme, colors);
    }
  }
}
