// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:wisata/ui/SplassScreen.dart';

class Routes {
  static const String Splass = '/';
  static const all = <String>{
    Splass,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.Splass, page: SplassScreen),
  ];

  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplassScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplassScreen(),
        settings: data,
      );
    },
  };
}