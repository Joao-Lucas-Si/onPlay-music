import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onPlay/constants/endpoints/invidious_endpoints.dart';
import 'package:onPlay/dtos/json/channel_dto.dart';
import 'package:onPlay/dtos/json/search_dto.dart';
import 'package:onPlay/dtos/json/youtube_video_dto.dart';
import 'package:onPlay/services/http/http_request.dart';
import 'package:onPlay/store/settings.dart';
import 'package:provider/provider.dart';

class YoutubeService {
  late HttpRequest<SearchDto> _searchRequest;
  late HttpRequest<YoutubeVideoDto> _videoRequest;
  late HttpRequest<ChannelDto> _channelRequest;
  late Settings _settings;
  BuildContext context;
  YoutubeService(this.context) {
    _settings = Provider.of<Settings>(context, listen: false);
  }

  Future<YoutubeVideoDto?> getVideo(String id) async {
    for (final instance in _settings.source.invidiousInstances) {
      _videoRequest =
            HttpRequest(instance, (json) => YoutubeVideoDto.fromJson(json));
      return await _videoRequest.getRequestUnique(
          InvidiousEndpoints.video(id));
    }
    return null;
  }

  Future<List<SearchDto>?> search(String query) async {
    // debugPrint(_settings.source.invidiousInstances.toString());
    for (final instance in _settings.source.invidiousInstances) {
      try {
        
        _searchRequest =
            HttpRequest(instance, (json) => SearchDto.fromJson(json));
        final results = (await _searchRequest.getRequestMany(
          "${InvidiousEndpoints.search}?q=$query",
        ))
            .where((result) => result.type == "video")
            .toList();
       
        return results;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return null;
  }
}
