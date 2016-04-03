SELECT 
    *
FROM
    Item
WHERE
    i_id IN (SELECT 
            i_id
        FROM
            Kitchen)
        AND Warehouse_w_num IN (SELECT 
            w_num
        FROM
            warehouse
        WHERE
            number_of_employees > 10 AND w_size > 70);