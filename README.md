

#  Cycling Tour Operator — XML / XSD / XSLT / JSON / Python Data Pipeline

---

This project describes a complete information system for a **cycling tour operator**, covering the management of clients, guides, tour packages, trip groups, bikes, reservations, maintenance operations, and cycling paths.
It includes data modeling, schema design, XML dataset creation, visualization scenarios using XSLT, XML-to-JSON transformations, and Python-based processing (XSD validation, XSL transformations, and DOM extraction).

---

# 1. DATA MODEL OVERVIEW

##  **Clients, Guides, and Trip Groups**

* A **Client** contains personal information (name, email, phone, country of residence), along with an **experience level** (beginner, occasional, regular, or expert).
* A **Guide** is a certified professional who leads cycling groups and whose contact information is stored in the system.
* A **TripGroup** represents a group of clients participating in a specific tour package and supervised by a guide.

  * It references the **TourPackage** it belongs to.
  * It is led by a **head guide**.
  * It defines the maximum number of participants and tracks all clients currently booked into the group.
  * It is represented by a client who books a tourpackage

---

##  **Tour Packages**

A **TourPackage** represents a **tour offer**, composed of multiple daily **Stages**.

* It includes a title, description, duration in days, difficulty level, currency, and whether luggage transport is provided.
* Each tour package contains **at least one stage**.

---

##  **Stages, Destinations, Activities, and Cycling Paths**

Each **Stage** represents a specific day of a tour:

* It belongs to one tour, has a day number, title, description, and total daily distance.
* A stage is associated with:

  * multiple **Activities** (visits, cultural events, experiences)
  * one or more **CyclingPaths**
  * exactly two **Destinations**: the starting point and the ending point.

**Destinations** contain a name, country, region, type (city, historical, coastal, mountainous), and GPS coordinates.

**CyclingPaths** define difficulty, distance, elevation gain, and surface type, and always link one start destination to one end destination.

---

##  **Bike Fleet and Maintenance Management**

* A **Bike** has a model, frame size, type (trekking or electric), availability, and rental price per day.
* A **RentalBikeListing** groups one or several bikes available for rental.
* Each bike has a **maintenance history** stored in **MaintenanceLog** entries (date, cost, description).

---

##  **Bookings**

A **Booking** links together:

* a Client
* a TripGroup
* an optional RentalBikeListing
* a booking date
* a booking status (pending, confirmed, cancelled, completed)
* a total price
* and the associated TourPackage

---

##  **Key Relationships**

* A **TourPackage** is composed of several **Stages**.
* A **TripGroup** is led by one **Guide**.
* A **Client** can make multiple **Bookings** and participate in multiple trip groups.
* A **Stage** offers several **Activities** and uses one or more **CyclingPaths**.
* A **Bike** has multiple **MaintenanceLog** entries.
* A **CyclingPath** always connects a starting and an ending **Destination**.

---

# 1.5 Advantages and Disadvantages of the Modeling Approach

We first designed the model in a **relational/UML style** to clearly represent the entities, attributes, and cardinalities.
Then we adapted it to an **XML modeling approach**, using:

* `xs:key` / `xs:keyref` to enforce referential integrity
* `xs:ID` / `xs:IDREF` / `xs:IDREFS` for cross-references
* `xs:simpleType` restrictions for enums
* nested XML structures for compositions (e.g., TourPackage → Stages)
* For the JSON version, ID references are represented using arrays.


### ✔ Advantages

* It easy to **query all stages of a tour** or retrieve related entities.
* The definition of **TripGroup** is simple: each group is led by one guide and represents clients who booked a tour package.
* The use of enumerations enforces consistent values for difficulty, bike type, etc.
* The modularization into multiple XSD files improves readability and maintainability.

### ✖ Disadvantages

* Some information may be duplicated (e.g., TourPackage contains stage IDs, but Stage also contains a tour ID).
  This may lead to inconsistencies if not validated properly.
* number of participants could directly be quary with attribute currentparticipants.

---

# 2. MODULES

The model is split into modular XSD schemas:

* **common.xsd** — contains commonly used simple types and enumerations
  (ExperienceLevel, DifficultyLevel, BikeType, BookingStatus, DestinationType, EmailType, PriceType, LatitudeType, LongitudeType).

* **clients_and_guides.xsd** — defines Client, Guide, and TripGroup complex types and their relationships.

* **tour_packages.xsd** — defines TourPackage, Stage, Activity, CyclingPath, and Destination complex types.

* **bike_fleet_and_maintenance.xsd** — defines Bike, RentalBikeListing, and MaintenanceLog.

* **bookings.xsd** — defines the Booking entity and related constraints.

* **main.xsd** — imports all other modules and defines the root element
  → `<main:cyclingTourDatabase>`.

---

# 3. XML DATABASE

The file `example_1.xml` contains a complete populated version of the model, including:

* 12 clients , 3 guides , 3 trip groups , 5 tour packages ,12 stages , destinations, activities, cycling paths, full bike fleet + maintenance logs , bookings

The XML fully validates against **main.xsd** and the diffenrent modules.

---

# 4. Scenarios and XSL Transformations

(Located in `xsl_files/scenario-visualize/`)

1. **Activities per Stage** — lists all activities grouped by stage
2. **Clients by Experience Level** — groups clients by BEGINNER / OCCASIONAL / REGULAR / EXPERT
3. **Available Bikes** — lists all rental bikes with their properties
4. **Destinations by Type** — groups destinations by CITY / HISTORICAL / COASTAL / MOUNTAINOUS
5. **Bookings by Status** — displays bookings by CONFIRMED / CANCELLED / COMPLETED
6. **Tours and Their Stages** — shows each tour package with its day-by-day stages

XSL transformer test tool:
🔗 [https://xslttest.appspot.com/](https://xslttest.appspot.com/)

---

# 5. XSLT Structure Modification Scenarios

Two XSL files perform structural reorganizations of the XML data
(grouping, reordering, restructuring).

* **Additional scenario 1:**
  — description to be added
* **Additional scenario 2:**
  — description to be added

---

# 6. XML → JSON TRANSFORMATIONS

Two XSLT stylesheets generate **JSON-like output structures**, representing selected sections of the dataset.
These JSON outputs are later processed by Python for summarization, grouping, or validation-style checks.

* **JSON Scenario 1:** (to be documented)
* **JSON Scenario 2:** (to be documented)

---

# 7. PYTHON PROGRAMS

### ✔ `xml_pipeline.py` — Generic XML → XSD → XSL Pipeline

This script:

* loads an XML file
* validates it against an XSD schema
* applies an XSL stylesheet
* generates the HTML output inside the `output/` directory

**Usage:**

```bash
./xml_pipeline.py <xml_file> <xsd_file> <xsl_file>
```

**Example:**

```bash
./xml_pipeline.py xml_database/example_1.xml xsd_files/main.xsd "xsl_files/scenario-visualize/S1 - activites_par_stage.xsl"
```

---

### ✔ `scenario2_dom.py` — DOM-Based Scenario Implementation

Implements Scenario 2 using `xml.dom.minidom`:

* parses the XML
* extracts clients
* groups them by experience level
* writes the output into:

`output/scenario2_python_dom.html`

This satisfies the requirement of providing a second implementation using DOM or SAX.

---

### ✔ `run_full_pipeline.py` — Complete Pipeline Runner

At the root of the repository.
This script:

* validates the XML
* applies **all** XSL visualizations
* executes the Python DOM scenario
* generates all HTML files in the `output/` folder

**Run:**

```bash
./run_full_pipeline.py
```

**Generated Output:**

```bash
output/
 ├── S1 - activites_par_stage.html
 ├── S2-clients_par_niveau_experience.html
 ├── S3-bikes_disponibles.html
 ├── S4-destinations_par_type.html
 ├── S5-reservations_par_statut.html
 ├── S6-tours_et_stages.html
 ├── s1bis_.html
 └── scenario2_python_dom.html
```

---

# 8. Summary

This project delivers a complete and functional data-processing pipeline for a cycling tour operator, integrating:

* a rich XML dataset
* a fully modularized XSD schema
* multiple XSLT visualization scenarios
* XML → JSON transformations
* a reusable Python XML/XSD/XSL pipeline
* a DOM-based Python processing scenario
* a full automated execution workflow

Everything is designed to be **modular**, **extensible**, and strictly **valid** according to the XML Schema.

---

