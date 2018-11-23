CREATE FUNCTION insert_uuid()
RETURNS TRIGGER AS $result$
    BEGIN
        INSERT INTO ouvrage (id_book) VALUES (dbo.uuid_generate_v4());
    END;
$result$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_uuid BEFORE INSERT ON ouvrage
    FOR EACH ROW EXECUTE PROCEDURE insert_uuid();
