import 'package:chatee/constants.dart';

class UserModel {
  String id;
  String name;
  String phoneNumber;
  String image;
  String token;
  String bio;
  String lastSeen;
  String createdAt;
  bool isOnline;
  List<String> friendsIDs;
  List<String> friendsRequestsIDs;
  List<String> sentFriendsRequestsIDs;

  UserModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.image,
      required this.token,
      required this.bio,
      required this.lastSeen,
      required this.createdAt,
      required this.isOnline,
      required this.friendsIDs,
      required this.friendsRequestsIDs,
      required this.sentFriendsRequestsIDs});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[Constants.id] ?? '',
      name: map[Constants.name] ?? '',
      phoneNumber: map[Constants.phoneNumber] ?? '',
      image: map[Constants.image] ?? '',
      token: map[Constants.token] ?? '',
      bio: map[Constants.bio] ?? '',
      lastSeen: map[Constants.lastSeen] ?? '',
      createdAt: map[Constants.createdAt] ?? '',
      isOnline: map[Constants.isOnline] ?? false,
      friendsIDs: List<String>.from(map[Constants.friendsIDs] ?? []),
      friendsRequestsIDs:
          List<String>.from(map[Constants.friendsRequestsIDs] ?? []),
      sentFriendsRequestsIDs:
          List<String>.from(map[Constants.sentFriendsRequestsIDs] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.id: id,
      Constants.name: name,
      Constants.phoneNumber: phoneNumber,
      Constants.image: image,
      Constants.token: token,
      Constants.bio: bio,
      Constants.lastSeen: lastSeen,
      Constants.createdAt: createdAt,
      Constants.isOnline: isOnline,
      Constants.friendsIDs: friendsIDs,
      Constants.friendsRequestsIDs: friendsRequestsIDs,
      Constants.sentFriendsRequestsIDs: sentFriendsRequestsIDs,
    };
  }
}
