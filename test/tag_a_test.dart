import 'package:flutter_test/flutter_test.dart';

import '_.dart';

const kColor = '#FF0000FF';
const kHref = 'http://domain.com/href';
const kImgSrc = 'http://domain.com/image.png';
const kTextPadding = 'Padding:(0,10,0,10)';

void main() {
  testWidgets('renders underline', (WidgetTester tester) async {
    final html = '<a href="$kHref">Foo</a>';
    final explained = await explain(tester, html);
    expect(
      explained,
      equals('[$kTextPadding,child=[RichText:($kColor+u+onTap:Foo)]]'),
    );
  });

  testWidgets('renders inline stylings', (WidgetTester tester) async {
    final html = '<a href="$kHref" style="color: #f00">Foo</a>';
    final explained = await explain(tester, html);
    expect(
      explained,
      equals('[$kTextPadding,child=[RichText:(#FFFF0000+u+onTap:Foo)]]'),
    );
  });

  testWidgets('renders inner stylings', (WidgetTester tester) async {
    final html = '<a href="$kHref"><b><i>Foo</i></b></a>';
    final explained = await explain(tester, html);
    expect(
      explained,
      equals('[$kTextPadding,child=[RichText:($kColor+u+i+b+onTap:Foo)]]'),
    );
  });

  testWidgets('renders DIV tag inside', (WidgetTester tester) async {
    final html = '<a href="$kHref"><div>Foo</div></a>';
    final explained = await explain(tester, html);
    expect(
        explained,
        equals('[$kTextPadding,child=[GestureDetector:child='
            '[RichText:($kColor+u:Foo)]]]'));
  });

  testWidgets('renders DIV tags inside', (WidgetTester tester) async {
    final html = '<a href="$kHref"><div>Foo</div><div>Bar</div></a>';
    final explained = await explain(tester, html);
    expect(
      explained,
      equals(
        '[Column:children='
        '[$kTextPadding,child=[GestureDetector:child=[RichText:($kColor+u:Foo)]]],'
        '[$kTextPadding,child=[GestureDetector:child=[RichText:($kColor+u:Bar)]]]]',
      ),
    );
  });

  testWidgets('renders IMG tag inside', (WidgetTester tester) async {
    final html = '<a href="$kHref"><img src="$kImgSrc" /></a>';
    final explained = await explain(tester, html);
    expect(
        explained,
        equals('[GestureDetector:child='
            '[CachedNetworkImage:http://domain.com/image.png]]'));
  });
}
