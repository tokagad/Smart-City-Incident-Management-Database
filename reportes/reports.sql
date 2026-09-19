/* ================================================================
   SmartCity Incident Management System — R#4
   DQL Reports (SELECT queries)

   Workflow:
   1) Run each query in SSMS, screenshot the result grid
   2) Send this file to your teammate for the matching
      Relational Algebra expression per report
   3) Combine: SQL + screenshot + algebra into the R#4 document

   Each report is labeled with its number, title, and the DQL
   concept(s) it demonstrates, matching the assignment's required
   coverage: Aggregate, Set Operators, Conditions, Joins.
   ================================================================ */

USE SmartCityIncidentDB;
GO


/* ---------------------------------------------------------------
   REPORT 1 — Full Incident Report
   Concept: Multi-table JOIN
   Shows every incident with citizen, category, status, severity,
   and priority names instead of raw IDs.
   --------------------------------------------------------------- */
SELECT
    I.IncidentID,
    I.Title,
    C.FirstName + ' ' + C.LastName AS ReportedBy,
    IC.CategoryName,
    IS2.StatusName,
    SV.SeverityName,
    PR.PriorityName,
    I.ReportedDateTime
FROM INCIDENT I
JOIN CITIZEN C          ON I.CitizenID = C.CitizenID
JOIN INCIDENT_CATEGORY IC ON I.CategoryID = IC.CategoryID
JOIN INCIDENT_STATUS IS2  ON I.StatusID = IS2.StatusID
JOIN SEVERITY SV         ON I.SeverityID = SV.SeverityID
JOIN PRIORITY PR         ON I.PriorityID = PR.PriorityID
ORDER BY I.ReportedDateTime DESC;
GO


/* ---------------------------------------------------------------
   REPORT 2 — Incident Count per Category
   Concept: Aggregate (COUNT) + GROUP BY
   --------------------------------------------------------------- */
SELECT
    IC.CategoryName,
    COUNT(I.IncidentID) AS TotalIncidents
FROM INCIDENT_CATEGORY IC
LEFT JOIN INCIDENT I ON IC.CategoryID = I.CategoryID
GROUP BY IC.CategoryName
ORDER BY TotalIncidents DESC;
GO


/* ---------------------------------------------------------------
   REPORT 3 — Average Resolution Time per Department
   Concept: Aggregate (AVG) + JOIN + GROUP BY
   --------------------------------------------------------------- */
SELECT
    D.DepartmentName,
    AVG(PRc.ResolutionTime) AS AvgResolutionTime
FROM PERFORMANCE_RECORD PRc
JOIN DEPARTMENT D ON PRc.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
ORDER BY AvgResolutionTime;
GO


/* ---------------------------------------------------------------
   REPORT 4 — Departments Handling More Than 2 Incidents
   Concept: Aggregate + GROUP BY + HAVING (condition on aggregate)
   --------------------------------------------------------------- */
SELECT
    D.DepartmentName,
    COUNT(IA.AssignmentID) AS IncidentsHandled
FROM DEPARTMENT D
JOIN INCIDENT_ASSIGNMENT IA ON D.DepartmentID = IA.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(IA.AssignmentID) > 2
ORDER BY IncidentsHandled DESC;
GO


/* ---------------------------------------------------------------
   REPORT 5 — Top 5 Response Teams by Incidents Handled
   Concept: JOIN + Aggregate (COUNT) + ORDER BY + TOP
   --------------------------------------------------------------- */
SELECT TOP 5
    RT.TeamName,
    COUNT(IA.AssignmentID) AS IncidentsHandled
FROM RESPONSE_TEAM RT
JOIN INCIDENT_ASSIGNMENT IA ON RT.TeamID = IA.TeamID
GROUP BY RT.TeamName
ORDER BY IncidentsHandled DESC;
GO


/* ---------------------------------------------------------------
   REPORT 6 — Citizens Who Submitted More Than 1 Incident
   Concept: Aggregate + GROUP BY + HAVING
   --------------------------------------------------------------- */
SELECT
    C.CitizenID,
    C.FirstName + ' ' + C.LastName AS CitizenName,
    COUNT(I.IncidentID) AS IncidentsReported
FROM CITIZEN C
JOIN INCIDENT I ON C.CitizenID = I.CitizenID
GROUP BY C.CitizenID, C.FirstName, C.LastName
HAVING COUNT(I.IncidentID) > 1
ORDER BY IncidentsReported DESC;
GO


/* ---------------------------------------------------------------
   REPORT 7 — Critical, Unresolved Incidents
   Concept: Conditions (WHERE with AND, comparison operators)
   --------------------------------------------------------------- */
SELECT
    I.IncidentID,
    I.Title,
    SV.SeverityName,
    IS2.StatusName,
    I.ReportedDateTime
FROM INCIDENT I
JOIN SEVERITY SV ON I.SeverityID = SV.SeverityID
JOIN INCIDENT_STATUS IS2 ON I.StatusID = IS2.StatusID
WHERE SV.SeverityName = 'Critical'
  AND IS2.StatusName <> 'Resolved'
ORDER BY I.ReportedDateTime;
GO


/* ---------------------------------------------------------------
   REPORT 8 — Employees Who Are NOT Operators
   Concept: LEFT JOIN + condition (IS NULL)
   --------------------------------------------------------------- */
SELECT
    E.EmployeeID,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    D.DepartmentName
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DepartmentID = D.DepartmentID
LEFT JOIN OPERATOR O ON E.EmployeeID = O.EmployeeID
WHERE O.OperatorID IS NULL;
GO


/* ---------------------------------------------------------------
   REPORT 9 — Combined Resource Inventory (Vehicles + Equipment)
   Concept: Set Operator (UNION)
   --------------------------------------------------------------- */
SELECT
    'Vehicle' AS ResourceKind,
    V.PlateNumber AS Identifier,
    V.Status
FROM VEHICLE V

UNION

SELECT
    'Equipment' AS ResourceKind,
    EQ.EquipmentName AS Identifier,
    EQ.Status
FROM EQUIPMENT EQ

ORDER BY ResourceKind;
GO


/* ---------------------------------------------------------------
   REPORT 10 — Departments With BOTH Assigned Incidents AND
   Registered Vehicles
   Concept: Set Operator (INTERSECT)
   --------------------------------------------------------------- */
SELECT D.DepartmentID, D.DepartmentName
FROM DEPARTMENT D
JOIN INCIDENT_ASSIGNMENT IA ON D.DepartmentID = IA.DepartmentID

INTERSECT

SELECT D.DepartmentID, D.DepartmentName
FROM DEPARTMENT D
JOIN RESPONSE_TEAM RT ON D.DepartmentID = RT.DepartmentID
JOIN VEHICLE V ON RT.TeamID = V.TeamID;
GO


/* ---------------------------------------------------------------
   REPORT 11 — Citizens Who Have NOT Submitted Any Feedback
   Concept: Set Operator (EXCEPT)
   --------------------------------------------------------------- */
SELECT CitizenID, FirstName, LastName
FROM CITIZEN

EXCEPT

SELECT C.CitizenID, C.FirstName, C.LastName
FROM CITIZEN C
JOIN CITIZEN_FEEDBACK CF ON C.CitizenID = CF.CitizenID;
GO


/* ---------------------------------------------------------------
   REPORT 12 — Incidents Rated Below the Overall Average
   Concept: Subquery (nested SELECT with aggregate)
   --------------------------------------------------------------- */
SELECT
    I.IncidentID,
    I.Title,
    CF.Rating
FROM INCIDENT I
JOIN CITIZEN_FEEDBACK CF ON I.IncidentID = CF.IncidentID
WHERE CF.Rating < (SELECT AVG(Rating) FROM CITIZEN_FEEDBACK)
ORDER BY CF.Rating;
GO


/* ---------------------------------------------------------------
   REPORT 13 — Response Teams With No Vehicles Assigned
   Concept: Correlated subquery (NOT EXISTS)
   --------------------------------------------------------------- */
SELECT RT.TeamID, RT.TeamName
FROM RESPONSE_TEAM RT
WHERE NOT EXISTS (
    SELECT 1
    FROM VEHICLE V
    WHERE V.TeamID = RT.TeamID
);
GO


/* ---------------------------------------------------------------
   REPORT 14 — Monthly Incident Volume
   Concept: Aggregate + GROUP BY on a derived/date expression
   --------------------------------------------------------------- */
SELECT
    YEAR(I.ReportedDateTime) AS ReportYear,
    MONTH(I.ReportedDateTime) AS ReportMonth,
    COUNT(*) AS TotalIncidents
FROM INCIDENT I
GROUP BY YEAR(I.ReportedDateTime), MONTH(I.ReportedDateTime)
ORDER BY ReportYear, ReportMonth;
GO


/* ---------------------------------------------------------------
   REPORT 15 — Incident Search by Keyword in Title
   Concept: Condition (LIKE, pattern matching)
   --------------------------------------------------------------- */
SELECT
    IncidentID,
    Title,
    ReportedDateTime
FROM INCIDENT
WHERE Title LIKE '%water%'
ORDER BY ReportedDateTime DESC;
GO