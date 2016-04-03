SELECT 
    *
FROM
    bill
WHERE
    Order_o_num IN (SELECT 
            order_o_num
        FROM
            order_has_item
        WHERE
            Item_i_id IN (SELECT 
                    i_id
                FROM
                    item
                WHERE
                    `i_price($)` >= 500)
        GROUP BY Order_o_num
        HAVING (COUNT(Order_o_num) > 1));

     