SELECT 
    employee.e_id, employee.first_name, employee.last_name, employee.Manager_e_id
FROM
    employee
        INNER JOIN
    assistant ON (employee.e_id = assistant.Employee_e_id)
        INNER JOIN
    (SELECT 
        *
    FROM
        payroll
    WHERE
        net_pay > (SELECT 
                AVG(net_pay)
            FROM
                payroll)) AS A ON (e_id = A.Employee_e_id)
WHERE
    e_id NOT IN (SELECT 
            manager_e_id
        FROM
            employee)