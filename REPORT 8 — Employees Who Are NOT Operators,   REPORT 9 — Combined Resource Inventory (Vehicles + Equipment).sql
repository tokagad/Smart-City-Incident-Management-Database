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

