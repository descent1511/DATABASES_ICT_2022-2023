PGDMP         6                {            Lab_database    11.19    11.19 ?    u           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            v           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            w           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            x           1262    25367    Lab_database    DATABASE     �   CREATE DATABASE "Lab_database" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Lab_database";
             postgres    false            �            1259    28131    buses    TABLE     {   CREATE TABLE public.buses (
    bus_id integer NOT NULL,
    model_id integer NOT NULL,
    bus_number integer NOT NULL
);
    DROP TABLE public.buses;
       public         postgres    false            �            1259    28129    buses_bus_id_seq    SEQUENCE     �   ALTER TABLE public.buses ALTER COLUMN bus_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.buses_bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    203            �            1259    28217    drivers    TABLE     <  CREATE TABLE public.drivers (
    driver_id integer NOT NULL,
    full_name character varying(30) NOT NULL,
    telephone character varying(30) NOT NULL,
    email character varying(255) NOT NULL,
    passport character varying(30) NOT NULL,
    CONSTRAINT chk_email CHECK (((email)::text ~~ '%_@__%.__%'::text))
);
    DROP TABLE public.drivers;
       public         postgres    false            �            1259    28215    drivers_driver_id_seq    SEQUENCE     �   ALTER TABLE public.drivers ALTER COLUMN driver_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.drivers_driver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    212            �            1259    28227    drivers_trips    TABLE     d   CREATE TABLE public.drivers_trips (
    driver_id integer NOT NULL,
    trip_id integer NOT NULL
);
 !   DROP TABLE public.drivers_trips;
       public         postgres    false            �            1259    28124    models    TABLE     �   CREATE TABLE public.models (
    model_id integer NOT NULL,
    seating_capacity integer NOT NULL,
    manufacturer character varying(30) NOT NULL,
    model_name character varying(30) NOT NULL,
    weight integer NOT NULL
);
    DROP TABLE public.models;
       public         postgres    false            �            1259    28122    models_model_id_seq    SEQUENCE     �   ALTER TABLE public.models ALTER COLUMN model_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.models_model_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    201            �            1259    28092 
   passengers    TABLE     y  CREATE TABLE public.passengers (
    email character varying(255) NOT NULL,
    passport character varying(30) NOT NULL,
    full_name character varying(30) NOT NULL,
    telephone character varying(20) NOT NULL,
    CONSTRAINT chk_email CHECK (((email)::text ~~ '%_@__%.__%'::text)),
    CONSTRAINT passengers_telephone_check CHECK (((telephone)::text ~ '^\d{10}$'::text))
);
    DROP TABLE public.passengers;
       public         postgres    false            �            1259    28200    routes    TABLE     �   CREATE TABLE public.routes (
    route_id integer NOT NULL,
    stop_id integer NOT NULL,
    schedule_id integer NOT NULL,
    stop_duration_in_minutes integer NOT NULL
);
    DROP TABLE public.routes;
       public         postgres    false            �            1259    28198    routes_route_id_seq    SEQUENCE     �   ALTER TABLE public.routes ALTER COLUMN route_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.routes_route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    210            �            1259    28110 	   schedules    TABLE     �  CREATE TABLE public.schedules (
    schedule_id integer NOT NULL,
    departure_point character varying(255) NOT NULL,
    arrival_point character varying(255) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    type character varying(20) DEFAULT 'intercity'::character varying NOT NULL,
    CONSTRAINT schedules_check CHECK ((departure_time < arrival_time)),
    CONSTRAINT schedules_check1 CHECK ((arrival_time > departure_time)),
    CONSTRAINT schedules_type_check CHECK (((type)::text = ANY ((ARRAY['intercity'::character varying, 'international'::character varying])::text[])))
);
    DROP TABLE public.schedules;
       public         postgres    false            �            1259    28108    schedules_schedule_id_seq    SEQUENCE     �   ALTER TABLE public.schedules ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.schedules_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    199            �            1259    28101    seats    TABLE     �   CREATE TABLE public.seats (
    seat_number integer NOT NULL,
    is_booked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.seats;
       public         postgres    false            �            1259    28189    stops    TABLE     �   CREATE TABLE public.stops (
    stop_id integer NOT NULL,
    stop_name character varying(255) NOT NULL,
    stop_address character varying(255) NOT NULL,
    stop_type character varying(255) DEFAULT 'unknown'::character varying NOT NULL
);
    DROP TABLE public.stops;
       public         postgres    false            �            1259    28187    stops_stop_id_seq    SEQUENCE     �   ALTER TABLE public.stops ALTER COLUMN stop_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stops_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    208            �            1259    28164    tickets    TABLE     �  CREATE TABLE public.tickets (
    seat_number integer NOT NULL,
    passport character varying(30) NOT NULL,
    price integer NOT NULL,
    boarding_point character varying(255) NOT NULL,
    status character varying(20) NOT NULL,
    alighting_point character varying(255) NOT NULL,
    sales_type character varying(10) NOT NULL,
    trip_id integer NOT NULL,
    CONSTRAINT tickets_sales_type_check CHECK (((sales_type)::text = ANY ((ARRAY['online'::character varying, 'offline'::character varying])::text[]))),
    CONSTRAINT tickets_status_check CHECK (((status)::text = ANY ((ARRAY['paid'::character varying, 'unpaid'::character varying, 'cancelled'::character varying])::text[])))
);
    DROP TABLE public.tickets;
       public         postgres    false            �            1259    28143    trips    TABLE     �  CREATE TABLE public.trips (
    trip_id integer NOT NULL,
    departure_point character varying(255) NOT NULL,
    arrival_point character varying(255) NOT NULL,
    actual_departure_time timestamp without time zone NOT NULL,
    actual_arrival_time timestamp without time zone NOT NULL,
    schedule_id integer NOT NULL,
    bus_id integer NOT NULL,
    status character varying(20) NOT NULL,
    CONSTRAINT trips_check CHECK ((actual_arrival_time > actual_departure_time)),
    CONSTRAINT trips_check1 CHECK ((actual_arrival_time > actual_departure_time)),
    CONSTRAINT trips_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'In progress'::character varying, 'Completed'::character varying])::text[])))
);
    DROP TABLE public.trips;
       public         postgres    false            �            1259    28141    trips_trip_id_seq    SEQUENCE     �   ALTER TABLE public.trips ALTER COLUMN trip_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    205            h          0    28131    buses 
   TABLE DATA               =   COPY public.buses (bus_id, model_id, bus_number) FROM stdin;
    public       postgres    false    203   �P       q          0    28217    drivers 
   TABLE DATA               S   COPY public.drivers (driver_id, full_name, telephone, email, passport) FROM stdin;
    public       postgres    false    212   .Q       r          0    28227    drivers_trips 
   TABLE DATA               ;   COPY public.drivers_trips (driver_id, trip_id) FROM stdin;
    public       postgres    false    213   �Q       f          0    28124    models 
   TABLE DATA               ^   COPY public.models (model_id, seating_capacity, manufacturer, model_name, weight) FROM stdin;
    public       postgres    false    201   �Q       a          0    28092 
   passengers 
   TABLE DATA               K   COPY public.passengers (email, passport, full_name, telephone) FROM stdin;
    public       postgres    false    196   �Q       o          0    28200    routes 
   TABLE DATA               Z   COPY public.routes (route_id, stop_id, schedule_id, stop_duration_in_minutes) FROM stdin;
    public       postgres    false    210   fR       d          0    28110 	   schedules 
   TABLE DATA               t   COPY public.schedules (schedule_id, departure_point, arrival_point, departure_time, arrival_time, type) FROM stdin;
    public       postgres    false    199   �R       b          0    28101    seats 
   TABLE DATA               C   COPY public.seats (seat_number, is_booked, created_at) FROM stdin;
    public       postgres    false    197   S       m          0    28189    stops 
   TABLE DATA               L   COPY public.stops (stop_id, stop_name, stop_address, stop_type) FROM stdin;
    public       postgres    false    208   OS       k          0    28164    tickets 
   TABLE DATA               }   COPY public.tickets (seat_number, passport, price, boarding_point, status, alighting_point, sales_type, trip_id) FROM stdin;
    public       postgres    false    206   �S       j          0    28143    trips 
   TABLE DATA               �   COPY public.trips (trip_id, departure_point, arrival_point, actual_departure_time, actual_arrival_time, schedule_id, bus_id, status) FROM stdin;
    public       postgres    false    205   	T       y           0    0    buses_bus_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.buses_bus_id_seq', 4, true);
            public       postgres    false    202            z           0    0    drivers_driver_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.drivers_driver_id_seq', 2, true);
            public       postgres    false    211            {           0    0    models_model_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.models_model_id_seq', 2, true);
            public       postgres    false    200            |           0    0    routes_route_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.routes_route_id_seq', 4, true);
            public       postgres    false    209            }           0    0    schedules_schedule_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 2, true);
            public       postgres    false    198            ~           0    0    stops_stop_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.stops_stop_id_seq', 2, true);
            public       postgres    false    207                       0    0    trips_trip_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.trips_trip_id_seq', 2, true);
            public       postgres    false    204            �
           2606    28135    buses buses_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_pkey PRIMARY KEY (bus_id);
 :   ALTER TABLE ONLY public.buses DROP CONSTRAINT buses_pkey;
       public         postgres    false    203            �
           2606    28224    drivers drivers_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.drivers DROP CONSTRAINT drivers_email_key;
       public         postgres    false    212            �
           2606    28226    drivers drivers_passport_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_passport_key UNIQUE (passport);
 F   ALTER TABLE ONLY public.drivers DROP CONSTRAINT drivers_passport_key;
       public         postgres    false    212            �
           2606    28222    drivers drivers_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (driver_id);
 >   ALTER TABLE ONLY public.drivers DROP CONSTRAINT drivers_pkey;
       public         postgres    false    212            �
           2606    28231     drivers_trips drivers_trips_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_pkey PRIMARY KEY (driver_id, trip_id);
 J   ALTER TABLE ONLY public.drivers_trips DROP CONSTRAINT drivers_trips_pkey;
       public         postgres    false    213    213            �
           2606    28128    models models_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (model_id);
 <   ALTER TABLE ONLY public.models DROP CONSTRAINT models_pkey;
       public         postgres    false    201            �
           2606    28100    passengers passengers_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.passengers DROP CONSTRAINT passengers_email_key;
       public         postgres    false    196            �
           2606    28098    passengers passengers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_pkey PRIMARY KEY (passport);
 D   ALTER TABLE ONLY public.passengers DROP CONSTRAINT passengers_pkey;
       public         postgres    false    196            �
           2606    28204    routes routes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);
 <   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_pkey;
       public         postgres    false    210            �
           2606    28121    schedules schedules_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);
 B   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_pkey;
       public         postgres    false    199            �
           2606    28107    seats seats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_number);
 :   ALTER TABLE ONLY public.seats DROP CONSTRAINT seats_pkey;
       public         postgres    false    197            �
           2606    28197    stops stops_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (stop_id);
 :   ALTER TABLE ONLY public.stops DROP CONSTRAINT stops_pkey;
       public         postgres    false    208            �
           2606    28153    trips trips_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (trip_id);
 :   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_pkey;
       public         postgres    false    205            �
           2606    28136    buses buses_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.models(model_id) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.buses DROP CONSTRAINT buses_model_id_fkey;
       public       postgres    false    203    2765    201            �
           2606    28232 *   drivers_trips drivers_trips_driver_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(driver_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.drivers_trips DROP CONSTRAINT drivers_trips_driver_id_fkey;
       public       postgres    false    212    2779    213            �
           2606    28237 (   drivers_trips drivers_trips_trip_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(trip_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.drivers_trips DROP CONSTRAINT drivers_trips_trip_id_fkey;
       public       postgres    false    205    213    2769            �
           2606    28210    routes routes_schedule_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id);
 H   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_schedule_id_fkey;
       public       postgres    false    210    199    2763            �
           2606    28205    routes routes_stop_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_stop_id_fkey FOREIGN KEY (stop_id) REFERENCES public.stops(stop_id);
 D   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_stop_id_fkey;
       public       postgres    false    208    2771    210            �
           2606    28177    tickets tickets_passport_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_passport_fkey FOREIGN KEY (passport) REFERENCES public.passengers(passport);
 G   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_passport_fkey;
       public       postgres    false    2759    206    196            �
           2606    28182     tickets tickets_seat_number_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_number_fkey FOREIGN KEY (seat_number) REFERENCES public.seats(seat_number);
 J   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_seat_number_fkey;
       public       postgres    false    206    197    2761            �
           2606    28172    tickets tickets_trip_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(trip_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_trip_id_fkey;
       public       postgres    false    206    2769    205            �
           2606    28159    trips trips_bus_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_bus_id_fkey FOREIGN KEY (bus_id) REFERENCES public.buses(bus_id);
 A   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_bus_id_fkey;
       public       postgres    false    205    203    2767            �
           2606    28154    trips trips_schedule_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id);
 F   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_schedule_id_fkey;
       public       postgres    false    205    2763    199            h   &   x�3�4�4200�2�0���9�8�A"&�W� y��      q   J   x�3�L)�,K-2�4��0735162�	9�V$���%��r�$����F��F�&�f��0!-0�\1z\\\ i8S      r      x�3�4�2�4����� ��      f   <   x�3�46�ɯ�/I�t�O,.I-�4100�2�0�NN��Lʗe�s�db���� ��r      a   ]   x�U�M
� @�&�w�������G����s��|�\O��6���D����BA˒_�i:A��w�hB��	���e�R>��-7      o   (   x�3�4�4�46�2R����\�`S.�P*F��� l�(      d   ]   x�3��H����tI�K�K�4202�50�52S0��20 "d1C�Xf^IjQrfI%�� '����l�jsCt�b��&�%�d��%�p��qqq [�"E      b   4   x�3�L�4202�50�52T02�21�25�3�433��2�/m�Y�O:F��� ��<      m   <   x�3�.�/P0�4��T�O�V.)JM-�,����/��2�țp*�&f�+����� ���      k   ^   x�e̱
� F���zS�5z��1�-�	Eg�8��~P�V�0{���>���xّ刲A�E��^��Cx�A������S�3-�M+'^      j   [   x�3��H����tI�K�K�4202�50�52S0��20�20@34��rs��d�sA�p����Po�`h�nP�&�i7#F��� �~     