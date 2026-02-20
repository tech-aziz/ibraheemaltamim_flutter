import 'package:ibraheemaltamim_flutter/provider/auth_provider.dart';
import 'package:ibraheemaltamim_flutter/provider/get_all_farmers_provider.dart';
import 'package:ibraheemaltamim_flutter/provider/pond_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibraheemaltamim_flutter/provider/address.dart';
import 'package:ibraheemaltamim_flutter/provider/email.dart';
import 'package:ibraheemaltamim_flutter/provider/provides.dart';
import 'package:ibraheemaltamim_flutter/provider/opportunity_provider.dart';
import 'package:ibraheemaltamim_flutter/provider/wishlist_provider.dart';

var providers = [
  //New
  ChangeNotifierProvider<AuthProvider>(create: ((context) => AuthProvider())),
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
  ChangeNotifierProvider<GenericBool>(create: ((context) => GenericBool())),
  ChangeNotifierProvider<SelectedSubCat>(
    create: ((context) => SelectedSubCat()),
  ),
  ChangeNotifierProvider<GenericProvider>(
    create: ((context) => GenericProvider()),
  ),
  ChangeNotifierProvider<CartCounter>(create: ((context) => CartCounter())),
  ChangeNotifierProvider<PondProvider>(create: ((context) => PondProvider())),

  ChangeNotifierProvider<GetAllFarmersProvider>(
    create: ((context) => GetAllFarmersProvider()),
  ),
  ChangeNotifierProvider<PondObservationProvider>(
    create: ((context) => PondObservationProvider()),
  ),
  ChangeNotifierProvider<OpportunityProvider>(
    create: ((context) => OpportunityProvider()),
  ),
  ChangeNotifierProvider<WishlistProvider>(
    create: ((context) => WishlistProvider()),
  ),
];
