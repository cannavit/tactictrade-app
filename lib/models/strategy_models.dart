// To parse this JSON data, do
//
//     final strategyModel = strategyModelFromMap(jsonString);

import 'dart:convert';

class StrategyModel {
    StrategyModel({
        this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory StrategyModel.fromJson(String str) => StrategyModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StrategyModel.fromMap(Map<String, dynamic> json) => StrategyModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Result {
    Result({
        required this.id,
        required this.strategyNews,
        required this.pusher,
        required this.isPublic,
        required this.isActive,
        required this.createAt,
        required this.modifiedAt,
        required this.netProfit,
        required this.percentageProfitable,
        required this.maxDrawdown,
        required this.profitFactor,
        required this.isVerified,
        required this.netProfitVerified,
        required this.percentageProfitableVerified,
        required this.ranking,
        required this.strategyLink,
        required this.strategyToken,
        required this.period,
        required this.timer,
        required this.description,
        required this.postImage,
        required this.urlImage,
        required this.emailBot,
        required this.owner,
        required this.symbol,
        required this.likes,
        required this.favorite,
        required this.follower,
        required this.isOwner,
        required this.timeTrade,
        required this.symbolName,
        required this.symbolUrl,
        required this.numbersLikes,
        required this.numbersFavorite,
        required this.isLiked,
        required this.isFavorite,
        required this.likesNumber,
        required this.isFollower,
    });

    int id;
    String strategyNews;
    String pusher;
    bool isPublic;
    bool isActive;
    DateTime createAt;
    DateTime modifiedAt;
    double netProfit;
    double percentageProfitable;
    double maxDrawdown;
    double profitFactor;
    bool isVerified;
    double netProfitVerified;
    double percentageProfitableVerified;
    int ranking;
    String strategyLink;
    String strategyToken;
    String period;
    int timer;
    String description;
    String postImage;
    String urlImage;
    String emailBot;
    Owner owner;
    int symbol;
    List<dynamic> likes;
    List<dynamic> favorite;
    List<int> follower;
    bool isOwner;
    String timeTrade;
    String symbolName;
    String symbolUrl;
    int numbersLikes;
    int numbersFavorite;
    bool isLiked;
    bool isFavorite;
    int likesNumber;
    bool isFollower;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        strategyNews: json["strategyNews"],
        pusher: json["pusher"],
        isPublic: json["is_public"],
        isActive: json["is_active"],
        createAt: DateTime.parse(json["create_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        netProfit: json["net_profit"],
        percentageProfitable: json["percentage_profitable"],
        maxDrawdown: json["max_drawdown"],
        profitFactor: json["profit_factor"],
        isVerified: json["is_verified"],
        netProfitVerified: json["net_profit_verified"],
        percentageProfitableVerified: json["percentage_profitable_verified"],
        ranking: json["ranking"],
        strategyLink: json["strategy_link"],
        strategyToken: json["strategy_token"],
        period: json["period"],
        timer: json["timer"],
        description: json["description"],
        postImage: json["post_image"],
        urlImage: json["url_image"],
        emailBot: json["email_bot"],
        owner: Owner.fromMap(json["owner"]),
        symbol: json["symbol"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        favorite: List<dynamic>.from(json["favorite"].map((x) => x)),
        follower: List<int>.from(json["follower"].map((x) => x)),
        isOwner: json["is_owner"],
        timeTrade: json["timeTrade"],
        symbolName: json["symbolName"],
        symbolUrl: json["symbolUrl"],
        numbersLikes: json["numbers_likes"],
        numbersFavorite: json["numbers_favorite"],
        isLiked: json["is_liked"],
        isFavorite: json["is_favorite"],
        likesNumber: json["likes_number"],
        isFollower: json["is_follower"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "strategyNews": strategyNews,
        "pusher": pusher,
        "is_public": isPublic,
        "is_active": isActive,
        "create_at": createAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "net_profit": netProfit,
        "percentage_profitable": percentageProfitable,
        "max_drawdown": maxDrawdown,
        "profit_factor": profitFactor,
        "is_verified": isVerified,
        "net_profit_verified": netProfitVerified,
        "percentage_profitable_verified": percentageProfitableVerified,
        "ranking": ranking,
        "strategy_link": strategyLink,
        "strategy_token": strategyToken,
        "period": period,
        "timer": timer,
        "description": description,
        "post_image": postImage,
        "url_image": urlImage,
        "email_bot": emailBot,
        "owner": owner.toMap(),
        "symbol": symbol,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "favorite": List<dynamic>.from(favorite.map((x) => x)),
        "follower": List<dynamic>.from(follower.map((x) => x)),
        "is_owner": isOwner,
        "timeTrade": timeTrade,
        "symbolName": symbolName,
        "symbolUrl": symbolUrl,
        "numbers_likes": numbersLikes,
        "numbers_favorite": numbersFavorite,
        "is_liked": isLiked,
        "is_favorite": isFavorite,
        "likes_number": likesNumber,
        "is_follower": isFollower,
    };
}

class Owner {
    Owner({
        required this.profileImage,
        required this.urlPicture,
        required this.username,
        required this.followers,
        required this.mantainerId,
    });

    String profileImage;
    String urlPicture;
    String username;
    int followers;
    int mantainerId;

    factory Owner.fromJson(String str) => Owner.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Owner.fromMap(Map<String, dynamic> json) => Owner(
        profileImage: json["profile_image"],
        urlPicture: json["url_picture"],
        username: json["username"],
        followers: json["followers"],
        mantainerId: json["mantainer_id"],
    );

    Map<String, dynamic> toMap() => {
        "profile_image": profileImage,
        "url_picture": urlPicture,
        "username": username,
        "followers": followers,
        "mantainer_id": mantainerId,
    };
}
