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

