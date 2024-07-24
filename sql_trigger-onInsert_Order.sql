
DELIMITER $$
CREATE TRIGGER while_update_one_order_up_store BEFORE INSERT ON one_order
FOR EACH ROW 
BEGIN 
DECLARE current_one INT;
SELECT amount INTO current_one FROM store 
WHERE itemId = NEW.itemId;
	IF (current_one - NEW.amount > 0) THEN
	UPDATE store 
	SET amount = amount-NEW.amount
    WHERE itemId = NEW.itemId;
	ELSE 
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT  ='W MAGAZYNIE NIE MA TOWERU DO DODANIA !!!!';
	END IF ;
 END $$
 DELIMITER ;
 