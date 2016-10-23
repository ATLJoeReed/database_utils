-------------
-- TEAR DOWN
-------------

ALTER TABLE public.reservation DROP CONSTRAINT reservation_shelter_id_fkey;
ALTER TABLE public.reservation DROP CONSTRAINT reservation_user_id_fkey;
ALTER TABLE public.user_info DROP CONSTRAINT user_info_shelter_id_fkey;

DROP TABLE public.reservation;
DROP TABLE public.user_info;
DROP TABLE public.shelter;

DROP EXTENSION earthdistance;
DROP EXTENSION cube;

DROP FUNCTION public.sc_return_closest_shelters(NUMERIC, NUMERIC, INTEGER);
DROP FUNCTION public.sc_update_shelter(VARCHAR, VARCHAR, VARCHAR, VARCHAR, CHAR, VARCHAR, NUMERIC, NUMERIC, VARCHAR, VARCHAR, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER);
