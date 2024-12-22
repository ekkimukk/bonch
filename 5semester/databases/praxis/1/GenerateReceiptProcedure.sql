delimiter @@@

create procedure generatereceipt(in visit_id int)
begin
    select 
        v.visit_date as visitdate,
        concat(m.name, ' ', m.surname) as technician,
        s.name as servicename,
        s.price as serviceprice
    from 
        visits v
    join 
        visit_details vd on v.id = vd.visit_id
    join 
        masters m on vd.master_id = m.id
    join 
        services s on vd.service_id = s.id
    where 
        v.id = visit_id;
end @@@

delimiter ;

