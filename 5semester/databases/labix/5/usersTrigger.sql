DELIMITER //

CREATE TRIGGER insertResult AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO results (laboratory, examination, u_id)
    VALUES (FALSE, 0, NEW.id);
END//

DELIMITER ;


DELIMITER //

CREATE TRIGGER updateUser AFTER UPDATE ON results
FOR EACH ROW
BEGIN
    UPDATE users
    SET isupdate = TRUE
    WHERE id = NEW.u_id;
END//

DELIMITER ;
