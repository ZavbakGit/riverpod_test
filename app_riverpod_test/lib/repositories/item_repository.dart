import 'package:app_riverpod_test/general_providers.dart';
import 'package:app_riverpod_test/models/item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_riverpod_test/extention/firebase_firestore_extension.dart';

import 'custom_exeption.dart';

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({required String userId});
  Future<String> createItem({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  const ItemRepository(this._read);

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).usersListRef(userId).get();
      //return snap.docs.map((doc) => Item.fromDocument(doc.data())).toList();
      return snap.docs.map((doc) => Item.fromJson(doc.data()!));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createItem({
    required String userId,
    required Item item,
  }) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({
    required String userId,
    required String itemId,
  }) async {
    try {
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(itemId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
