import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item.dart';
import '../models/shop_model.dart';

/// Firestore CRUD for merchant shops and menu items.
class ShopService {
  ShopService._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _shops =>
      _db.collection('shops');

  static CollectionReference<Map<String, dynamic>> _menuRef(String shopId) =>
      _shops.doc(shopId).collection('menu');

  static Future<String> upsertMerchantShop({
    required String merchantId,
    required String name,
    required String category,
    required String description,
    required String priceRange,
    required String location,
    required String phone,
    required List<String> imageUrls,
    String googleMapsUrl = '',
  }) async {
    final existing = await _shops
        .where('merchantId', isEqualTo: merchantId)
        .limit(1)
        .get();

    final shopRef = existing.docs.isEmpty
        ? _shops.doc(merchantId)
        : _shops.doc(existing.docs.first.id);

    final payload = <String, dynamic>{
      'merchantId': merchantId,
      'name': name,
      'category': category,
      'description': description,
      'priceRange': priceRange,
      'location': location,
      'phone': phone,
      'googleMapsUrl': googleMapsUrl,
      'imageUrls': imageUrls,
      'rating': 0.0,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await shopRef.set(
      existing.docs.isEmpty
          ? {...payload, 'createdAt': FieldValue.serverTimestamp()}
          : payload,
      SetOptions(merge: true),
    );

    return shopRef.id;
  }

  static Future<Shop?> getMerchantShop(String merchantId) async {
    final directDoc = await _shops.doc(merchantId).get();
    if (directDoc.exists) {
      return _shopFromDoc(directDoc);
    }

    final result = await _shops
        .where('merchantId', isEqualTo: merchantId)
        .limit(1)
        .get();
    if (result.docs.isEmpty) return null;

    final doc = result.docs.first;
    return _shopFromDoc(doc);
  }

  static Stream<List<Shop>> streamShopsByCategory(String category) {
    return _shops
        .where('category', isEqualTo: category)
        .snapshots()
        .map((query) => query.docs.map(_shopFromDoc).toList());
  }

  static Stream<List<Shop>> streamAllShops() {
    return _shops.snapshots().map(
      (query) => query.docs.map(_shopFromDoc).toList(),
    );
  }

  static Stream<List<MenuItem>> streamMenuItems(String shopId) {
    return _menuRef(shopId)
        .orderBy('name')
        .snapshots()
        .map((query) => query.docs.map(_menuItemFromDoc).toList());
  }

  static Future<void> addMenuItem({
    required String shopId,
    required String name,
    required String description,
    required double price,
  }) {
    return _menuRef(shopId).add({
      'name': name,
      'description': description,
      'price': price,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deleteMenuItem({
    required String shopId,
    required String menuItemId,
  }) {
    return _menuRef(shopId).doc(menuItemId).delete();
  }

  static Future<void> deleteMerchantData(String merchantId) async {
    final ids = <String>{};

    final directDoc = await _shops.doc(merchantId).get();
    if (directDoc.exists) {
      ids.add(directDoc.id);
    }

    final byMerchant = await _shops
        .where('merchantId', isEqualTo: merchantId)
        .get();
    for (final doc in byMerchant.docs) {
      ids.add(doc.id);
    }

    for (final shopId in ids) {
      final menuSnapshot = await _menuRef(shopId).get();
      for (final menuDoc in menuSnapshot.docs) {
        await menuDoc.reference.delete();
      }
      await _shops.doc(shopId).delete();
    }
  }

  static Shop _shopFromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return Shop.fromJson({'id': doc.id, ...?data});
  }

  static MenuItem _menuItemFromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return MenuItem(
      id: doc.id,
      name: (data['name'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      price: ((data['price'] as num?) ?? 0).toDouble(),
    );
  }
}
