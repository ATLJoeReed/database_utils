CREATE OR REPLACE FUNCTION sc_return_closest_shelters(
    IN user_latitude numeric,
    IN user_longitude numeric,
    IN num_results integer)
  RETURNS TABLE(
    shelter_id integer,
    name character varying,
    address2 character varying,
    address1 character varying,
    city character varying,
    state character,
    zip_code character varying,
    phone1 character varying,
    beds_available integer,
    latitude numeric,
    longitude numeric,
    distance numeric,
    modified_dt timestamp with time zone) AS
$BODY$
DECLARE
    ref refcursor;
  BEGIN

  RETURN QUERY

    select shelters.*
  from (
      select
      a.id as shelter_id,
      a.name,
      a.address2,
      a.address1,
      a.city,
      a.state,
      a.zip_code,
      a.phone1,
      a.beds_available,
      a.latitude,
      a.longitude,
          cast(earth_distance(ll_to_earth(user_latitude , user_longitude),
                 ll_to_earth(a.latitude, a.longitude)) * .0006213712 as numeric(10,2))as "distance",
      a.modified_dt
      from shelter as a
      where a.beds_available > 0
  ) as shelters
    order by shelters.distance asc
    limit num_results;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

 -- NOTE: You need to change the owner to your database login...   
ALTER FUNCTION sc_return_closest_shelters(numeric, numeric, integer)
  OWNER TO shelterconnect;