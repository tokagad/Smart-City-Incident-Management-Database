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
