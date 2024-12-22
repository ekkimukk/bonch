SELECT 
    clients.name AS client_name,
    clients.surname AS client_surname,
    clients.phone_number,
    visits.visit_date,
    masters.name AS master_name,
    masters.surname AS master_surname,
    services.name AS service_name,
    services.price AS service_price
FROM 
    visits
JOIN 
    clients ON visits.client_id = clients.id
JOIN 
    visit_details ON visits.id = visit_details.visit_id
JOIN 
    masters ON visit_details.master_id = masters.id
JOIN 
    services ON visit_details.service_id = services.id
WHERE 
    clients.id = 9;

