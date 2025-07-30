import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter(
            fromFirestore: (doCsnapshot, _) =>
                EventModel.fromJeson(doCsnapshot.data()!),
            toFirestore: (event, _) => event.toJeson(),
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
}
