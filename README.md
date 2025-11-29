📘 Cycling Tour Operator — XML / XSD / XSLT / JSON / Python Data Pipeline

This project implements a complete XML-based data pipeline for a Cycling Tour Operator.
It covers data modeling, schema design, XML dataset creation, visualization scenarios using XSLT, XML-to-JSON transformations, and Python processing (XSD validation, XSL application, and DOM-based extraction).

🚴 1. Data Model Overview

The model represents the operations of a cycling tour operator, including:

Clients (identity, contact info, experience level)

Guides (certification, contact information)

Trip Groups (assigned guide, tour, participants)

Tour Packages (titles, descriptions, difficulty, stages)

Stages (day number, activities, destinations, cycling paths)

Destinations (country, region, category, GPS coordinates)

Activities (type, cost, duration)

Cycling Paths (distance, elevation gain, difficulty)

Bike Fleet (model, frame size, type, rental price, availability)

Maintenance Logs (date, cost, description)

Bookings (status, price, linked client and trip group)

Core Relationships

A Tour Package is composed of multiple Stages.

A Stage links to multiple Activities, Cycling Paths, and two Destinations.

A Trip Group is led by a Guide and linked to a Tour Package.

A Client can make several Bookings.

Bikes have multiple Maintenance Logs and can appear in rental listings.

Cycling Paths always connect two Destinations.

🧩 2. Modular XML Schema (XSD)

The schema is split across multiple namespaces:

✔ common.xsd

Enumerations and simple types (ExperienceLevel, DifficultyLevel, BookingStatus, BikeType, GPS coordinates, Price, Email, etc.)

✔ clients_and_guides.xsd

Defines: client, guide, tripGroup

✔ tour_packages.xsd

Defines: tourPackage, stage, activity, cyclingPath, destination

✔ bike_fleet_and_maintenance.xsd

Defines: bike, rentalBikeListing, maintenanceLog

✔ bookings.xsd

Defines: booking

✔ main.xsd

Imports all modules and defines the root element:

<main:cyclingTourDatabase>

📄 3. XML Database

The file example_1.xml contains a populated version of the model:

12 clients

3 guides

3 trip groups

5 tour packages

12 stages

destinations, activities, cycling paths

full bike fleet + maintenance logs

bookings

The XML validates fully against main.xsd.

🎨 4. XSLT Visualization Scenarios

Located in xsl_files/scenario-visualize/.

✔ Activities per Stage

Lists all activities grouped by stage.

✔ Clients by Experience Level

Groups clients by BEGINNER / OCCASIONAL / REGULAR / EXPERT.

✔ Available Bikes

Displays available rental bikes with model, frame size, type, price/day.

✔ Destinations by Type

Groups destinations by CITY / HISTORICAL / COASTAL / MOUNTAINOUS, etc.

✔ Bookings by Status

Lists confirmed, cancelled, completed bookings.

✔ Tours and Their Stages

Displays each tour package with its day-by-day stages.

🔀 5. XSLT Structure Modification Scenarios

Two XSL files perform structural reorganization of the XML data, including grouping, reordering, and restructuring.

🔄 6. XML to JSON Transformations

Two XSLT transformations produce JSON-like structures representing selected sections of the data.
These JSON outputs are then processed in Python (summary stats, grouping, validation-style checks).

🐍 7. Python Programs
✔ xml_pipeline.py — Generic XML → XSD → XSL Pipeline

This script:

loads an XML file

validates it against an XSD schema

applies an XSL stylesheet

generates an HTML output inside the output/ directory

Usage
./xml_pipeline.py <xml_file> <xsd_file> <xsl_file>


Example:

./xml_pipeline.py xml_database/example_1.xml xsd_files/main.xsd "xsl_files/scenario-visualize/S1 - activites_par_stage.xsl"

✔ scenario2_dom.py — DOM-Based Scenario Implementation

Implements Scenario 2 using Python’s XML DOM API (xml.dom.minidom):

parses the XML

extracts clients

groups them by experience level

writes the output to:

output/scenario2_python_dom.html


This file satisfies the requirement for a second implementation using DOM or SAX.

✔ run_full_pipeline.py — Complete Pipeline Runner

Located at the root of the repository.

This script:

Validates the XML and applies all XSL stylesheets automatically

Executes the Python DOM scenario

Generates all HTML files in the output/ folder

Run the full pipeline
./run_full_pipeline.py

Output examples
output/
 ├── S1 - activites_par_stage.html
 ├── S2-clients_par_niveau_experience.html
 ├── S3-bikes_disponibles.html
 ├── S4-destinations_par_type.html
 ├── S5-reservations_par_statut.html
 ├── S6-tours_et_stages.html
 ├── s1bis_.html
 └── scenario2_python_dom.html

📑 8. Documentation

The accompanying report describes:

data modeling approach

schema modularization

rationale behind XSD/XSLT design

scenario explanations

Python pipeline choices

testing and validation

🎯 Summary

This project delivers a complete and functional data processing pipeline for a cycling tour operator, integrating:

a rich XML dataset

a fully modularized XSD schema

multiple XSLT visualization scenarios

XML → JSON conversions

a generic Python XML/XSD/XSL pipeline

a DOM-based Python scenario

a full automatic execution pipeline

Everything is designed to be modular, extensible, and strictly valid according to the schema.