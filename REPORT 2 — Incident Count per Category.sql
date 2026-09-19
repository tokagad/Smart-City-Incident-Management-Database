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
