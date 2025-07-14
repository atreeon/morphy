import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex20_inheritance_generics_test.morphy.dart';
part 'ex20_inheritance_generics_test.morphy2.dart';

///A GENERATED FILE SPECIFYING A GENERATED TYPE
//class $BS_BI implements $BS<BI> (BI is generated)

main() {
  test("1", () {
    var batch = BS_BI(batchItems: [BI(orderId: 456)]);

    var blah = BQR(batch: batch);
    expect(blah.batch.batchItems.length, 1);

    var result = batch.batchItems.map((e) => getOrderId(e)).toList();
    expect(result[0], 456);
  });
}

int getOrderId(BI bi) {
  return bi.orderId;
}

@morphy2
abstract class $BI {
  int get orderId;
}

@morphy
abstract class $BQR {
  $BS<BI> get batch;
}

@morphy
abstract class $BS<Tbi extends BI> {
  List<Tbi> get batchItems;
}

@morphy
abstract class $BS_BI implements $BS<BI> {
  List<BI> get batchItems;
}
