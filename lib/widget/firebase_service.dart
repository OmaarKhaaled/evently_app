import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter<EventModel>(
            fromFirestore: (doCsnapshot, _) =>
                EventModel.fromJson(doCsnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (docsnapshot, _) =>
            UserModel.fromJson(docsnapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    QuerySnapshot<EventModel> quarySnapShot = await eventCollection
        .orderBy('timeStamp')
        .get();
    return quarySnapShot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      favoriteEventsIds: [],
      id: credential.user!.uid,
      name: name,
      email: email,
    );
    CollectionReference<UserModel> usersCollections = getUserCollection();
    await usersCollections.doc(credential.user!.uid).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> documentSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return documentSnapshot.data()!;
  }

  static Future<void> logOut() => FirebaseAuth.instance.signOut();

  static Future<void> addEventToFavorites(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventsIds': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeEventToFavorites(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventsIds': FieldValue.arrayRemove([eventId]),
    });
  }

  static Future<void> updateEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();

    if (event.id.isEmpty) {
      return Future.error("Event id is null or empty, cannot update event");
    }

    return eventCollection.doc(event.id).set(event, SetOptions(merge: true));
  }

  static Future<void> deleteEvent(String eventId) async {
  CollectionReference<EventModel> eventCollection = getEventCollection();
  await eventCollection.doc(eventId).delete();
}

}
