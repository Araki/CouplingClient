//
//  PFCommands.h
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright 2013年 tsuchimoto. All rights reserved.
//

// [Session]
#define kPFCommandSessionsCreate			@"/sessions/create"
#define kPFCommandSessionsVerify			@"/sessions/verify"


// {Users}
#define kPFCommendUsersList                 @"/users/list"
#define kPFCommendUsersShow                 @"/users/%@/show"

// {Friends}
#define kPFCommendFriendsShow               @"/friends/show"

// {Favorites}
#define kPFCommendFavoritesShow             @"/favorites/show"
#define kPFCommendFavoritesCreate           @"/favorites/create"
#define kPFCommendFavoritesDelete           @"/favorites/delete"
#define kPFCommendFavoritesList             @"/favorites/list"

// {Likes}
#define kPFCommendLikesShow                 @"/likes/show"
#define kPFCommendLikesCreate               @"/likes/create"
#define kPFCommendLikesDelete               @"/likes/delete"
#define kPFCommendLikesList                 @"/likes/list"

// {Points}
#define kPFCommendPointsAdd                 @"/points/add"
#define kPFCommendPointsConsume             @"/points/consume"

// {Matches}
#define kPFCommendMatchesList               @"/matches/list"

// {LikePoints}
#define kPFCommendLikePointsAdd             @"/like_points/add"
