SELECT 
    *
FROM
    customer
WHERE
    EXISTS( SELECT 
            *
        FROM
            `order`
        WHERE
            customer.c_id = `order`.Customer_c_id
                AND o_num IN (SELECT 
                    order_o_num
                FROM
                    order_has_item
                WHERE
                    order_has_item.Item_i_id IN (SELECT 
                            i_id
                        FROM
                            item
                        WHERE
                            i_id IN (SELECT 
                                    i_id
                                FROM
                                    kitchen)
                                AND Brand_b_name IN ('Apple' , 'Acer'))
                        AND quantity > 2)
                AND EXISTS( SELECT 
                    *
                FROM
                    bill
                WHERE
                    amount > 3000
                        AND bill.Order_o_num = `order`.o_num));


