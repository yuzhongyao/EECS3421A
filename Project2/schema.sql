/*Yu Zhong Yao
*215472616
*EECS3421 A
*Parke, Godfrey
*November 6, 2020
*Project 2
*/
create table person(
    name varchar(50),
    sin numeric(9,0),
    person_address varchar(50),
    phone numeric(18,0) not null,
    constraint person_pk
        primary key(sin)
);

create table bubble(
    p1 numeric(9,0),
    p2 numeric(9,0),
    constraint bubble_pk
        primary key (p1, p2),
    constraint p1_fk
        foreign key (p1) references person(sin),
    constraint p2_fk
        foreign key (p2) references person(sin)
);

create table action_entity (
    action_performed varchar (50) primary key
);

create table method_entity(
    method_used varchar(50) primary key
);

create table place (
    place_name varchar(50),
    gps varchar(50),
    place_description varchar(60),
    place_address varchar(50) not null,
    constraint place_pk
        primary key (place_name)
);

create table time_slot(
    time_slot_time timestamp,
    constraint time_slot_pk 
        primary key (time_slot_time)
);

create table test_type(
    testtype varchar(50),
    constraint test_type_pk
        primary key (testtype)
);

create table test_centre(
    test_centre_name varchar(50) references place(place_name),
    constraint test_centre_pk 
        primary key (test_centre_name)
);

create table offer(
    testcentre varchar(50),
    testtype varchar(50),
    constraint offer_pk
        primary key (testcentre, testtype),
    constraint tc_fk 
        foreign key (testcentre) references test_centre (test_centre_name),
    constraint tt_fk 
        foreign key (testtype) references test_type (testtype)
);

create table test(
    sin numeric(9,0),
    time timestamp,
    test_result varchar(50) not null,
    testtype varchar(50),
    testcentre varchar(50),
    constraint test_pk 
        primary key(sin, time),
    constraint sin_fk
        foreign key (sin) references person(sin),
    constraint test_time_fk
        foreign key (time) references time_slot (time_slot_time),
    constraint test_result_fk 
        foreign key (test_result) references action_entity (action_performed),
    constraint testtype_fk 
        foreign key (testtype) references test_type(testtype),
    constraint testcentre_fk
        foreign key (testcentre) references test_centre(test_centre_name)
);

create table recon(
    method varchar(50),
    sin numeric(9,0),
    placename varchar(50),
    time timestamp,
    constraint recon_pk 
        primary key(method, placename, time, sin),
    constraint method_fk 
        foreign key (method) references method_entity(method_used),
    constraint placename_fk 
        foreign key (placename) references place(place_name),
    constraint time_fk 
        foreign key (time) references time_slot(time_slot_time),
    constraint sin_fk 
        foreign key (sin) references person(sin)
);
