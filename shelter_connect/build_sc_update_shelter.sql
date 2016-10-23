
CREATE OR REPLACE FUNCTION sc_update_shelter(
    shelter_name character varying,
    shelter_address2 character varying,
    shelter_address1 character varying,
    shelter_city character varying,
    shelter_state character,
    shelter_zip_code character varying,
    shelter_latitude numeric,
    shelter_longitude numeric,
    shelter_phone1 character varying,
    shelter_phone2 character varying,
    shelter_beds_total integer,
    shelter_beds_available integer,
    shelter_beds_taken integer,
    shelter_beds_maintenance integer,
    shelter_id integer)
  RETURNS void AS
$BODY$
    BEGIN
    UPDATE shelter
        SET name = shelter_name,
      address2 = shelter_address2,
            address1 = shelter_address1,
            city = shelter_city,
            state = shelter_state,
            zip_code = shelter_zip_code,
            latitude = shelter_latitude,
            longitude = shelter_longitude,
            beds_total = shelter_beds_total,
            beds_available = shelter_beds_available,
            beds_taken = shelter_beds_taken,
            beds_maintenance = shelter_beds_maintenance,
            phone1 = shelter_phone1,
            phone2 = shelter_phone2,
            modified_dt = current_timestamp
    WHERE id = shelter_id;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

 -- NOTE: You need to change the owner to your database login... 
ALTER FUNCTION sc_update_shelter(character varying, character varying, character varying, character varying, character, character varying, numeric, numeric, character varying, character varying, integer, integer, integer, integer, integer)
  OWNER TO shelterconnect;
