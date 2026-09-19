# Smart City Incident Management Database

## Overview

This project presents the design and implementation of a relational database for a Smart City Incident Management System.

The system is designed to manage incidents reported within a city, including incident categories, types, severity, priorities, locations, citizens, employees, response teams, resources, incident status, assignments, evidence, and feedback.

The project covers the database development process from requirements analysis and conceptual design to relational schema design, SQL Server implementation, querying, and documentation.

> **Project Type:** Academic Database Project

---

## Objectives

The main objectives of this project are to:

- Design a structured relational database for Smart City incident management.
- Analyze and document the system requirements.
- Design an Entity Relationship Diagram (ERD).
- Convert the ERD into a relational database schema.
- Implement the database using Microsoft SQL Server.
- Write SQL queries for retrieving and analyzing information.
- Create database views for commonly required information.
- Apply normalization principles to improve database structure.
- Use relational algebra to represent database queries.
- Document the database structure and implementation.

---

## Technologies and Concepts

- Microsoft SQL Server
- SQL
- Relational Database Design
- Entity Relationship Diagrams (ERD)
- Relational Schema
- Database Normalization
- Relational Algebra
- SQL Views
- Data Dictionary
- Requirements Analysis

---

## Main System Components

The database contains several entities that support the management of city incidents, including:

- User Accounts
- Citizens
- Employees
- Operators
- City Administrators
- Departments
- Response Teams
- Team Members
- Incident Categories
- Incident Types
- Incident Status
- Severity
- Priority
- Incident Locations
- Service Areas
- Resources
- Equipment
- Vehicles
- Incident Assignments
- Incident Evidence
- Incident Status History
- Citizen Feedback
- Notifications
- Performance Records

These entities are connected through relationships that represent how incidents are reported, classified, assigned, handled, and resolved.

---

## Project Development

### 1. Requirements Analysis

The project started with identifying the business and system requirements of the Smart City Incident Management System.

The requirements were used to determine the main entities, attributes, relationships, and system operations needed in the database.

### 2. Entity Relationship Diagram

An ERD was designed to represent the entities and relationships within the system.

The ERD was then used as the foundation for creating the relational database schema.

### 3. Relational Schema

The ERD was converted into a relational schema containing tables, primary keys, foreign keys, and relationships between the different entities.

### 4. Database Implementation

The relational schema was implemented using Microsoft SQL Server.

SQL scripts were used to create the database tables, relationships, constraints, and sample data.

### 5. SQL Queries

SQL queries were developed to retrieve and analyze information from the database.

The queries include operations such as:

- Filtering data
- Joining multiple tables
- Aggregating information
- Grouping data
- Sorting results
- Counting records
- Retrieving related information

### 6. Database Views

Views were created to simplify commonly required queries and provide useful representations of the stored data.

### 7. Relational Algebra

Relational algebra expressions were developed for selected database operations to demonstrate the theoretical representation of queries.

### 8. Documentation

The project includes requirements documentation, database design documentation, relational algebra solutions, SQL implementation, and a final project report.

---

## Database Design

The database follows relational database principles and uses:

- Primary Keys to uniquely identify records.
- Foreign Keys to maintain relationships between tables.
- Constraints to maintain data integrity.
- Normalization principles to reduce redundancy and improve consistency.

---

## Project Files

The repository contains the project documentation and implementation materials, including:

```text
Requirements/
    Business and System Requirements

ERD/
    Entity Relationship Diagram

Database/
    SQL Server database scripts
    Table definitions
    Sample data
    Views and queries

Relational-Algebra/
    Relational algebra solutions

Documentation/
    Database documentation
    Project report

Screenshots/
    ERD
    SQL Server
    Database views
