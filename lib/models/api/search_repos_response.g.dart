// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchReposResponse _$$_SearchReposResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SearchReposResponse(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String? ?? '',
      totalCount: json['total_count'] as int? ?? 0,
      incompleteResults: json['incomplete_results'] as bool? ?? false,
      repos: (json['items'] as List<dynamic>?)
              ?.map((e) => Repo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Repo>[],
    );

Map<String, dynamic> _$$_SearchReposResponseToJson(
        _$_SearchReposResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.repos,
    };
