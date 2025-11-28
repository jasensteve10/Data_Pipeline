this is the xml/json data pipeline projet 

This is the data pipeline

log:
step 1 :  data model of cycling tour operator
          the entities and relations   done

step 2 :  the schema of this model -- modularizing with namespaces and defining the models   done

step 3 :  the xml of this database corresponding to the schema  done

step 4 : 6 scenari  for xsl visualisation 

step 5 : 2 scenari  for xsl structure modification 

step 6 : 2 scenari for xsl to json format 

step 7 : python program for json

step 8 : python scenario with api ( we will not do it, lack of time )  with the json schema

step 9: report and others 


---

This model describes a complete information system for a **cycling tour operator**, covering the management of clients, guides, tour packages, trip groups, bikes, reservations, maintenance, and cycling paths.

---

## 🔹 **Clients and Guides and Trip Groups**

* A **Client** has personal information (name, email, phone, country), as well as an **experience level** (beginner, occasional, regular, or expert).
* A **Guide** is a certified professional who leads cycling groups and has contact details stored in the system.
* A **TripGroup** represents a a group of clients  where one client books a specific tour package and is led by a guide.

  * It references the TourPackage it corresponds to.
  * It is led by a **head guide**.
  * It defines the maximum number of participants and tracks the clients currently booked into the group.

---

## 🔹 **Tour Packages**

* A **TourPackage** represents a **tour offer**, made up of multiple daily **Stages**.

  * It includes a title, description, total duration in days, difficulty level, currency, and whether luggage transportation is provided.
  * Each tour package is always composed of **at least one stage**.

---

## 🔹 **Stages, Destinations, Activities, and Cycling Paths**

Each **Stage** describes a specific day of a tour:

* It is linked to a tour, assigned to a day number, and includes a title, description, and daily distance.
* Every stage is associated with:

  * a set of **Activities** (cultural visits, events, experiences)
  * one or more **CyclingPaths** used that day
  * exactly two **Destinations**: the starting point and the ending point.

**Destinations** include their name, country, region, type (city, historical, mountain, etc.), and GPS coordinates.

**CyclingPaths** specify the difficulty, distance, elevation gain, and surface type. Each path always connects one starting destination to one ending destination.

---

## 🔹 **Bike Fleet and Maintenance Management**

* A **Bike** has a model, frame size, bike type (trekking or electric), availability, and rental price per day.
* A **RentalBikeListing** groups one or several bikes available for rental.
* Each bike has a **maintenance history**, stored in MaintenanceLog entries containing date, cost, and description.

---

## 🔹 **Bookings**

A **Booking** links together:

* a Client,
* a TripGroup,
* a RentalBikeListing,
* the booking date,
* the booking status (pending, confirmed, cancelled, completed),
* and the total price.

---

## 🔹 **Key Relationships**

* A **TourPackage** is composed of multiple **Stages** (composition).
* A **TripGroup** is led by one **Guide**.
* A **Client** can make several **Bookings** and participate in multiple trip groups.
* A **Stage** offers **Activities** and uses **CyclingPaths**.
* A **Bike** has multiple maintenance logs.
* A **CyclingPath** always connects a start and an end **Destination**.

---

# 🎯 **One-Sentence Summary**

This model represents a full cycling tour operator system where clients can book guided multi-stage cycling tours, travel across defined cycling paths and destinations, rent bikes, participate in scheduled trip groups, and where the operator manages tours, activities, bikes, maintenance, and reservations.

---

##  **Modules**
the model is modularized as follows:

* common.xsd - contains common simple types and enumerations used across the model 
   ( ExperienceLevel, DifficultyLevel, BikeType, BookingStatus , DestinationType, EmailType, PriceType, LatitudeType, LongitudeType).
* clients_and_guides.xsd - defines the Client, Guide, and TripGroup entities along with their relationships of complex type.
   (client , guide , tripGroup ).
* tour_packages.xsd - defines the TourPackage, Stage, Activity, CyclingPath, and Destination entities along with their relationships of complex type.
   (tourPackage , stage , activity , cyclingPath , destination ).
* bike_fleet_and_maintenance.xsd - defines the Bike, RentalBikeListing, and MaintenanceLog entities along with their relationships of complex type.
   (bike , rentalBikeListing , maintenanceLog ).
* bookings.xsd - defines the Booking entity along with its relationships of complex type.
   (booking ).
* main.xsd - imports all the modularized schemas and serves as the root schema for the entire model.
   (imports all other .xsd files ).

## **Scenarios and xsl transformation**

* Mes Scénarios :
1- Cette feuille XSLT affiche pour chaque étape (Stage) la liste des activités proposées.
   Pour chaque étape, elle affiche le titre puis les activités associées avec leur nom, type et durée.


