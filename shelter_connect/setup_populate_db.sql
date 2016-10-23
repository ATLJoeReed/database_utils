CREATE TABLE shelter
(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    address2 VARCHAR(100),
    address1 VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    latitude NUMERIC(12,7) NOT NULL,
    longitude NUMERIC(12,7) NOT NULL,
    phone1 VARCHAR(20),
    phone2 VARCHAR(20),
    beds_total INTEGER DEFAULT 0 NOT NULL,
    beds_available INTEGER DEFAULT 0 NOT NULL,
    beds_taken INTEGER DEFAULT 0 NOT NULL,
    beds_reserved INTEGER DEFAULT 0 NOT NULL,
    beds_maintenance INTEGER DEFAULT 0 NOT NULL,
    modified_dt TIMESTAMP WITH TIME ZONE
);

CREATE TABLE user_info
(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL,
    is_approved BOOLEAN DEFAULT false NOT NULL,
    max_reservations INTEGER DEFAULT 0 NOT NULL,
    user_type CHAR NOT NULL,
    shelter_id INTEGER NOT NULL,
    CONSTRAINT user_info_shelter_id_fkey FOREIGN KEY (shelter_id) REFERENCES shelter (id)
);

CREATE TABLE reservation
(
    id SERIAL PRIMARY KEY NOT NULL,
    expire_dt TIMESTAMP WITH TIME ZONE NOT NULL,
    shelter_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    reserved_for CHAR(100),
    CONSTRAINT reservation_shelter_id_fkey FOREIGN KEY (shelter_id) REFERENCES shelter (id),
    CONSTRAINT reservation_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info (id)
);

CREATE EXTENSION cube;
CREATE EXTENSION earthdistance;

INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Springdale Place/Solomon''s Temple', null, '2836 Springdale Rd SW', 'Atlanta', 'GA', '30315', 33.6778259, -84.4154183, '404-762-4872', null, 140, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Central Presbyterian Church Central Night Shelter', null, '201 Washington St SW', 'Atlanta', 'GA', '30303', 33.7496197, -84.3887903, '404-659-0274', null, 82, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('HOPE Atlanta', null, '34 Peachtree St NW', 'Atlanta', 'GA', '30303', 33.7548272, -84.3893939, '404-817-7070', null, 357, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Atlanta Mission', null, '156 Mills St NW', 'Atlanta', 'GA', '30313', 33.7756205, -84.4245722, '404-367-2493', null, 335, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Atlanta Mission - The Sheperd''s Inn', null, '165 Ivan Allen Jr Blvd NW', 'Atlanta', 'GA', '30318', 33.7195230, -84.3453310, '404-367-2493', null, 215, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Atlanta Recovery Center Inc', null, '790 Marietta St', 'Atlanta', 'GA', '30318', 33.7735950, -84.4050080, '678-275-8454', null, 165, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Atlanta Mission - My Sister''s House', null, '921 Howell Mill Rd NW', 'Atlanta', 'GA', '30318', 33.7802030, -84.4102100, '404-367-2465', null, 154, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Urban Residential Development Corp - Sante Fe Villas SRO', null, '2370 Metropolitan Parkway SW ', 'Atlanta', 'GA', '30315', 33.6903030, -84.4077710, '', null, 100, 1, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Jefferson Place', null, '1135 Jefferson St NW', 'Atlanta', 'GA', '30318', 33.7756205, -84.4245722, '404-613-0412', null, 140, 3, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('City of Refuge/Eden Village', null, '1300 Joseph E. Boone Blvd NW', 'Atlanta', 'GA', '30314', 33.7635229, -84.4301065, '404-874-2241', null, 104, 3, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Gateway Center', null, '275 Pryor St SW', 'Atlanta', 'GA', '30303', 33.7473496, -84.3941651, '404-215-6600', null, 172, 3, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Families First  Shelter-A-Family', null, '1105 West Peachtree St NW', 'Atlanta', 'GA', '30309', 33.7847990, -84.3875230, '404-853-2800', null, 117, 3, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Project Interconnections, Inc.  SPC - Welcome House', null, '234 Memorial Dr', 'Atlanta', 'GA', '30303', 33.7465420, -84.3952990, '404-525-7300', null, 200, 5, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Nicholas House Inc', null, '1790 LaVista Rd NE', 'Atlanta', 'GA', '30329', 33.8175540, -84.3287110, '404-622-0793', null, 109, 5, 0, 0, 0, current_timestamp);
INSERT INTO public.shelter (name, address2, address1, city, state, zip_code, latitude, longitude, phone1, phone2, beds_total, beds_available, beds_taken, beds_reserved, beds_maintenance, modified_dt) VALUES ('Community Concerns Inc - Odyssey Villas', '', '276 Decatur St SE', 'Atlanta', 'GA', '30312', 33.7499700, -84.3898990, '404-659-3390', '', 116, 3, 100, 0, 3, current_timestamp);
