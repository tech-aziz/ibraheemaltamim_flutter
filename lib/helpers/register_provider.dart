import 'package:ibraheemaltamim_flutter/provider/auth_provider.dart';
import 'package:ibraheemaltamim_flutter/provider/get_all_farmers_provider.dart';
import 'package:ibraheemaltamim_flutter/provider/pond_provider.dart';
import 'package:provider/provider.dart';
import '../provider/address.dart';
import '../provider/email.dart';
import '../provider/provides.dart';

var providers = [
  //New
  ChangeNotifierProvider<AuthProvider>(
    create: ((context) => AuthProvider()),
  ),
  // Old
  ChangeNotifierProvider<EmailProvider>(create: ((context) => EmailProvider())),
  ChangeNotifierProvider<AddressProvider>(
    create: ((context) => AddressProvider()),
  ),
  ChangeNotifierProvider<ItemOptionIndex>(
    create: ((context) => ItemOptionIndex()),
  ),
  // ChangeNotifierProvider<DateTimeProvider>(
  //   create: ((context) => DateTimeProvider()),
  // ),
  ChangeNotifierProvider<VoucherProvider>(
    create: ((context) => VoucherProvider()),
  ),
  ChangeNotifierProvider<PlcaeMarkAddress>(
    create: ((context) => PlcaeMarkAddress()),
  ),
  ChangeNotifierProvider<GenericBool>(
    create: ((context) => GenericBool()),
  ),
  ChangeNotifierProvider<SelectedSubCat>(
    create: ((context) => SelectedSubCat()),
  ),
  ChangeNotifierProvider<GenericProvider>(
    create: ((context) => GenericProvider()),
  ),
  ChangeNotifierProvider<CartCounter>(
    create: ((context) => CartCounter()),
  ),
  ChangeNotifierProvider<PondProvider>(
    create: ((context) => PondProvider()),
  ),

  ChangeNotifierProvider<GetAllFarmersProvider>(
    create: ((context) => GetAllFarmersProvider()),
  ),
  ChangeNotifierProvider<PondObservationProvider>(
    create: ((context) => PondObservationProvider()),
  ),
];
