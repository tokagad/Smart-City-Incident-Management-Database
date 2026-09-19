
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