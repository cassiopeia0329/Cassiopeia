# Cassiopeia

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
What is art? What entitles a piece to be displayed in a museum? If a new painting is introduced in a museum, do we all take it as art for granted? We want to take this message further, right into our buying and selling. 

Whether you're currently enrolled in the Art Institute of No Man's Land, or Cooper Union, you're on our ship to hunt for treasure. 
<!--You name a desirable sell price. Our algorithm creates a range of price levels based on fibonacci retracement ratios (61.8, or 76.4). Anytime a buyer bids a price into that range, you get an alert. -->

Cassiopeia empowers art students to convert portfolio works into monetary value. As a global city, New York is home to some of the top art schools in the country. It's dispiriting that art students endure financial hardships when art is power. As a platform, we encourage artists to fire up their imagination and create pieces that are true to their heart.

### App Evaluation
- **Category:** Art / E-commerce
- **Mobile:** iOS
- **Story:** Allow users to upload their art works in which buyers can access it to make an offer if they like the arts
- **Market:** Students, Buyers like homeowners
- **Habit:** Users have unlimited upload during a day but their posts have to be an art works. Artists will upload works when they complete them, we cannot give a time constraint on art, but are hoping that users will use the app on at least a weekly basis
- **Scope:** The app will start off with artists being able to upload their artwork that buyers can express interest in purchasing. The app may then be expanded to include bidding options and the creation of a community of artists and buyers where artists can be followed and artwork can be commented on.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a login/profile
* User can login
* User can view profile
* User can edit their profile
* User can upload artwork pictures
* User can add artwork information
* User can edit their artwork information
* User can delete artwork
* User can search for artwork
* User can view artwork that is available for purchase
* User can view the details for an artwork
* User can express interest in buying artwork
* User can view list of interested buyers for their artwork
* User can make their account private
* User can set notifications for interest in their artwork
* User can set whether they are a buyer or artist

**Optional Nice-to-have Stories**

* User can bid on artwork
* User can view art by category
* User can upload videos of artwork
* User can purchase artwork directly from app

### 2. Screen Archetypes

* **Login Screen**
* User can create a login/profile
* User can login
* On sign up, user can indicate whether he/she is a buyer/artist
* **Stream**
* User can view artwork that is available for purchase
* User can view list of interested buyers for their artwork
* **Detail**
* User can view the details for an artwork
* User can express interest in buying artwork when looking at the details for it
<!-- Details for implementation:
* Buyer can initiate a dialogue with the artist* communicating only in numbers
* they will reply back and forth in a thread-like manner such as in Slack
* Buyer has two chances to finalize their offers, indicated by color red
* artist can accept by sending the handshake emoji, which automatically closes the deal and enables payment transfer -->
* **Creation**
* User can upload artwork pictures
* User can add description on artwork
* User can edit their artwork information
* **Profile**
* User can view profile
* User can edit their profile
* **Settings**
* User can set notifications for interest in their artwork
* User can make their account private

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* Search
* Add artwork
* Buyer Interest
* Profile

**Flow Navigation** (Screen to Screen)

* Login/Sign Up -> home
* Home -> details of selected artwork
* Profile -> settings

## Wireframes
<img src="https://i.imgur.com/YYmZNj4.jpg" width=300 alt="wireframe">

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/7WQC9ph.jpg" width=600 alt="wireframe">

<a href="https://www.figma.com/file/BuGoy26XU9wLiNFTC8teFR/Cassiopeia-iPhone-X?node-id=0%3A1">Figma Wireframes and Mockups</a>

### [BONUS] Interactive Prototype
<!-- <iframe style="border: none;" width="300" height="450" src="https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2FBuGoy26XU9wLiNFTC8teFR%2FCassiopeia-iPhone-X%3Fnode-id%3D0%253A1%26scaling%3Dscale-down" allowfullscreen></iframe> -->
<img src="https://i.imgur.com/PGyJy0A.gif" width=300 alt="wireframe">

<a href="https://www.figma.com/proto/BuGoy26XU9wLiNFTC8teFR/Cassiopeia-iPhone-X?node-id=0%3A1&scaling=scale-down" target="_blank">Figma Interactive Prototype</a>

## Schema 

### Models
**User**

| Property | Type | Description |
|  ---   | --- | --- |
| userID   | string | unique id for the user (default field)|
| username | string | unique display name for the user |
| password | string | a string of characters users use to login to their account, form of security |
| firstName | string | the first name of the user |
| lastName | string | the last name of the user |
| email | string | the email address of the user |
| userType | string | the type of user this is, a buyer or a student |
| school | string | the school that the user attends|
| occupation | string | the user's current job title |

**Artwork**

| Property | Type | Description |
|  ---   | --- | --- |
| artID   | string | unique id for the artwork (default field)|
| medium | string | the medium used to create the art piece |
| description | string | a brief description by the artist of the work |
| dateCreated | string | the date that the artist completed the work |
| dateUpdated | string | the date that the work was posted (default field) |
| user | Pointer to user | the artwork's artist/user that uploaded it |
| availability   | string | whether or not the art available for purchase or if it has been sold already |

**Chat**

| Property  |   Type    | Description |
|  ---   | --- | --- |
| chatID    |   string  | unique id for the chat (default field)|
| artworkID | Pointer to artwork | the artwork that this chat is for |
| buyerID   | Pointer to user | the buyer's id, person who initiates the chat |
| userID    | Pointer to user | the artist's id |

**Message**

| Property | Type | Description |
|  ---   | --- | --- |
| messageID   | string | unique id for the message (default field)|
| timeSent | string | the timestamp of when the message was sent (default field) |
| chatID | string | the unique id for the chat that this message is for |
| senderID | Pointer to user | unique id of the current user that is sending the message |
| receiverID | Pointer to user | unique id of the receiver for the message |

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
<!-- - [OPTIONAL: List endpoints if using existing API such as Yelp] -->
- Home
- (Read/GET) Query posts where art is available for purchase
- Search
- (Read/GET) Query all posts where that is available for purchase and fits user criteria
- Details
- (Read/GET) Get all information associated with an artwork
- Add Artwork
- (Create/POST) Create a new post object
- Details screen
- (Read/GET) Query additional information on a specific post
- Edit Artwork
- (Update/PUT) Update the information for the artwork
- Buyers interested
- (Read/GET) Query all chats where user is a participant
- (Create/POST) Create a new message
- Profile
- (Read/GET) Query logged in user object
- (Update/PUT) Update user profile image
- (Update/PUT) Update user information
- (Delete) Delete existing artwork
- (Update/PUT) Update artwork information
- Settings
- (Update/PUT) Change the privacy settings for the user

