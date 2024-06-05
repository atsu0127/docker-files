import 'dart:async';
import 'package:macros/macros.dart';

final _dartCore = Uri.parse('dart:core');

macro class Greetable implements ClassDeclarationsMacro, ClassDefinitionMacro {
  const Greetable();

  @override
  Future<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    await _declareHello(clazz, builder);
  }

  @override
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    await _buildHello(clazz, builder);
  }

  Future<void> _declareHello(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    // resolveIdentifierが非推奨になってるけど代用見当たらない
    final stringIdentifier =
        await builder.resolveIdentifier(_dartCore, 'String');
    builder.declareInType(DeclarationCode.fromParts([
      '  external ',
      stringIdentifier,
      ' hello();',
    ]));
  }

  Future<void> _buildHello(
      ClassDeclaration clazz, TypeDefinitionBuilder typeBuilder) async {
    final methods = await typeBuilder.methodsOf(clazz);
    final hello = methods.firstWhereOrNull((c) => c.identifier.name == 'hello');
    if (hello == null) return;
    final builder = await typeBuilder.buildMethod(hello.identifier);
    final className = clazz.identifier.name;
    final code = <Object>[
      '{\n'.indent(2),
      'return "Hello from $className";\n'.indent(4),
      '}'.indent(2),
    ];

    builder.augment(FunctionBodyCode.fromParts(code));
  }
}

extension on String {
  String indent(int length) {
    final space = StringBuffer();
    for (var i = 0; i < length; i++) {
      space.write(' ');
    }
    return '$space$this';
  }
}

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) compare) {
    for (final item in this) {
      if (compare(item)) return item;
    }
    return null;
  }
}
