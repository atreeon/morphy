import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:morphy/src/MorphyGenerator.dart';

Builder morphyBuilder(BuilderOptions options) => //
    PartBuilder([MorphyGenerator<Morphy>()], '.morphy.dart',
        header: '''
// ignore_for_file: UNNECESSARY_CAST
    ''');
