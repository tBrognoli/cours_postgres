CREATE FUNCTION generate_uuid()
RETURNS TRIGGER AS $result$
    BEGIN
        return uuid_generate_v4();
    END;
$result$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_uuid BEFORE INSERT ON ouvrage
    FOR EACH ROW EXECUTE PROCEDURE generate_uuid();
