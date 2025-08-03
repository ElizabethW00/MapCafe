Original App Design Project - README Template
===

# Map Cafe

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Map Cafe is a social food discovery app where users can log, rate, and map the cafes, restaurants, or food spots they love. Each food entry is geotagged and displayed on a map, allowing users to visually explore their own food journey and also view recommendations from friends. Think of it as a personal Google Maps meets Instagram food diary—with community flavor.

### App Evaluation

[Evaluation of your app across the following attributes]

* **Category:** Travel / Lifestyle / Entertainment
* **Mobile:** Ideal for on-the-go use while café hopping; integrates with maps and camera for sharing photos.
* **Story:** Helps users document their café adventures and build a personalized café map and review log.
* **Market:** Coffee lovers, digital nomads, travelers, students exploring new places.
* **Habit:** Used whenever visiting a new café, browsing for recommendations, or reflecting on past visits.
* **Scope:** V1 allows rating, reviews, and location pinning; V2 supports map view and filters; V3 adds sharing with friends or exporting lists.


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up and log in
* User can search for restaurants or cafes using map or name
* User can add a food location, upload a photo, and rate it
* User can view their added food spots on a map
* User can see their list of saved food entries with name, rating, and notes
* User can view friends’ food maps (static or simplified in MVP)
* User can log out

**Optional Nice-to-have Stories**

* Users can filter food spots by rating, tags, or type (e.g., dessert, brunch)
* Users can like or comment on friends’ entries
* Users can follow friends and view a food feed
* Add map clustering for densely marked areas
* Integration with Yelp or Google Places API for auto-suggested names/locations
* Push notifications for “Try this spot!” from friends

---

### 2. Screen Archetypes

* [ ] **Login / Sign Up Screen**

  * User can log in or register an account

* [ ] **Food Log List Screen**

  * View all added food entries in a scrollable list
  
* [ ] **Map Screen**

  * View user's food pins on a map
  * Tap on pins to see details

* [ ] **Add Food Entry Screen**

  * Add a new place, rating, photo, and description

* [ ] **Friend Map Screen**

  * View friend’s food pins (read-only)

* [ ] **Profile Screen**

  * View user info, log out, total entries

---

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Map
* Food Log
* Add Entry
* Friends
* Profile

**Flow Navigation** (Screen to Screen)

* [ ] **Login/Sign Up Screen**

  * → Tab Bar Screen after authentication

* [ ] **Map Tab**

  * Tap on pin → Entry Detail Modal

* [ ] **Add Entry Tab**

  * Select location → Input → Save → Map/Food Log

* [ ] **Friends Tab**

  * Tap on friend → View friend’s map

* [ ] **Profile Tab**

  * Tap logout → Login screen

---

## Wireframes

<img width="1190" height="558" alt="drawingPrototype" src="https://github.com/user-attachments/assets/ec5431f8-76d2-46bb-82de-36b4434c454d" />

## Schema 

[This section will be completed in Unit 9]

### Models

| Property     | Type   | Description            |
| ------------ | ------ | ---------------------- |
| username     | String | Unique username        |
| password     | String | User password (hashed) |
| email        | String | User email             |
| profileImage | File   | Profile picture        |

| Property    | Type            | Description                |
| ----------- | --------------- | -------------------------- |
| user        | Pointer to User | Creator of the entry       |
| title       | String          | Name of restaurant or cafe |
| description | String          | Optional notes or review   |
| image       | File            | Photo of the food/spot     |
| location    | GeoPoint        | Lat/lng of the entry       |
| rating      | Number          | User rating (e.g., 1–5)    |
| createdAt   | DateTime        | Time of creation           |


### Networking

-  Firebase (Firestore)
