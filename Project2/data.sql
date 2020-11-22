/*Yu Zhong Yao
*215472616
*EECS3421 A
*Parke, Godfrey
*November 6, 2020
*Project 2
*/
insert into person(name, sin, person_address, phone) values
    ('John Doe', 551234123, '100 Toronto st.', 6470000000),
    ('Godfrey Parke', 541230987, '31 Larkley ave.', 4162221324),
    ('Wenxiao Fu', 421321777, '1 Address rd.', 6479182731),
    ('Dan Joe', 123456789, '8764 Yonge st.', 4167562931),
    ('Jane Michelle', 987362617, '1999 This st.', 6471231231);

insert into bubble(p1, p2) values
    (541230987, 421321777),
    (551234123, 123456789),
    (551234123, 541230987),
    (551234123, 987362617),
    (551234123, 421321777),
    (123456789, 987362617);

insert into method_entity(method_used) values
    ('contact-tracing phone app'),
    ('surveillance camera'),
    ('registry sign in'),
    ('registry sign out');

insert into test_type(testtype) values
    ('PCR test'),
    ('Rapid Antigen test'),
    ('Blood test');

insert into action_entity(action_performed) values
    ('self-isolate'),
    ('hospitalize'),
    ('no action');

insert into place(place_name, gps, place_description, place_address) values
    ('CN Tower', '43.6426, 79.3871', 'Downtown Toronto attraction', '290 Bremner Blvd, Toronto, ON M5V 3L9'),
    ('Rogers Centre', '43.6418, 79.3891', 'Multi-purpose Sports stadium', '1 Blue Jays Way, Toronto, ON M5V 1J1'),
    ('Scarborough Town Centre', '43.7756, 79.2579', 'Shopping Mall', '300 Borough Dr, Scarborough, ON M1P 4P5'),
    ('York University', '43.7735, 79.5019', 'Major University in Toronto', '4700 Keele St, Toronto, ON M3J 1P3'),
    ('Kennedy Station', '43.7325, 79.2636', 'TTC station', '2455 Eglinton Ave E, Scarborough, ON'),
    ('Test centre Markham', '43.8566, 79.3369', 'Markham civic centre', '101 Town Centre Blvd, Markham, ON L3R 9W3'),
    ('Test centre Scarborough', '43.7764, 79.2583', 'Scarborough civic centre', '150 Borough Dr, Scarborough, ON M1P 4N7'),
    ('Test centre Downtown', '43.6534, 79.3841', 'Toronto city hall', '100 Queen St W, Toronto, ON M5H 2N2'),
    ('Test centre Etobicoke', '43.6438, 79.5653', 'Etobicoke civic centre', '399 The West Mall, Etobicoke, ON M9C 2Y2'),
    ('Test centre North York', '43.767315, 79.414641', 'North York civic centre', '5100 Yonge St, North York, ON M2N 5V7'),
    ('Test centre Vaughan', '43.7935, 79.52727', 'Vaughan civic centre', '2191 Major MacKenzie Dr W, Vaughan, ON L6A 4W2');

insert into test_centre(test_centre_name) values
    ('Test centre Markham'),
    ('Test centre Scarborough'),
    ('Test centre Downtown'),
    ('Test centre Etobicoke'),
    ('Test centre North York'),
    ('Test centre Vaughan');

insert into offer(testcentre, testtype) values
    ('Test centre Markham', 'PCR test'),
    ('Test centre Markham', 'Rapid Antigen test'),
    ('Test centre Markham', 'Blood test'),
    ('Test centre Scarborough', 'PCR test'),
    ('Test centre Scarborough', 'Rapid Antigen test'),
    ('Test centre Downtown', 'Blood test'),
    ('Test centre Downtown', 'PCR test'),
    ('Test centre Downtown', 'Rapid Antigen test'),
    ('Test centre Etobicoke', 'PCR test'),
    ('Test centre North York', 'Rapid Antigen test'),
    ('Test centre North York', 'Blood test'),
    ('Test centre Vaughan', 'Blood test');

insert into time_slot(time_slot_time) values
    ('2020-10-1 08:00:00'),
    ('2020-10-1 08:15:32'),
    ('2020-10-1 09:06:08'),
    ('2020-10-1 10:00:00'),
    ('2020-10-1 10:15:20'),
    ('2020-10-1 13:00:54'),
    ('2020-10-1 13:16:21'),
    ('2020-10-1 15:23:12'),
    ('2020-10-1 15:40:47'),
    ('2020-10-1 15:55:22'),
    ('2020-10-1 17:32:09'),
    ('2020-10-1 17:49:11'),
    ('2020-10-1 18:00:00'),
    ('2020-10-1 18:31:59'),
    ('2020-10-1 19:55:04'),
    ('2020-10-1 21:00:23'),
    ('2020-10-1 21:29:23');

insert into test(sin, time, test_result, testtype, testcentre) values
    (551234123, '2020-10-1 09:06:08', 'self-isolate', 'Blood test', 'Test centre Vaughan'),
    (541230987, '2020-10-1 15:23:12', 'no action', 'PCR test', 'Test centre Etobicoke'),
    (123456789, '2020-10-1 17:49:11', 'hospitalize', 'Blood test', 'Test centre Markham'),
    (421321777, '2020-10-1 18:31:59', 'self-isolate', 'Rapid Antigen test', 'Test centre Scarborough'),
    (551234123, '2020-10-1 21:00:23', 'self-isolate', 'Rapid Antigen test', 'Test centre Scarborough'),
    (987362617, '2020-10-1 21:00:23', 'hospitalize', 'Blood test', 'Test centre North York');


insert into recon(method, sin, placename, time) values
    ('surveillance camera', 551234123, 'York University', '2020-10-1 08:00:00'),
    ('surveillance camera', 541230987, 'York University', '2020-10-1 08:00:00'),
    ('contact-tracing phone app', 421321777, 'York University', '2020-10-1 08:00:00'),
    ('surveillance camera', 123456789, 'York University', '2020-10-1 08:00:00'),
    ('surveillance camera', 987362617, 'York University', '2020-10-1 08:00:00'),
    ('registry sign in', 551234123, 'Test centre Vaughan', '2020-10-1 09:06:08'),
    ('registry sign out', 551234123, 'Test centre Vaughan', '2020-10-1 10:15:20'),
    ('surveillance camera', 987362617, 'CN Tower', '2020-10-1 10:015:20'),
    ('contact-tracing phone app', 123456789, 'Rogers Centre', '2020-10-1 13:00:54'),
    ('contact-tracing phone app', 551234123, 'Scarborough Town Centre', '2020-10-1 15:23:12'),
    ('surveillance camera', 421321777, 'Rogers Centre', '2020-10-1 13:16:21'),
    ('registry sign in', 541230987, 'Test centre Etobicoke', '2020-10-1 15:23:12'),
    ('surveillance camera', 987362617, 'Kennedy Station', '2020-10-1 13:00:54'),
    ('registry sign out', 541230987, 'Test centre Etobicoke', '2020-10-1 15:55:22'),
    ('contact-tracing phone app', 421321777, 'Scarborough Town Centre', '2020-10-1 17:32:09'),
    ('surveillance camera', 551234123, 'Kennedy Station', '2020-10-1 15:40:47'),
    ('contact-tracing phone app', 123456789, 'Kennedy Station', '2020-10-1 15:55:22'),
    ('registry sign in', 123456789, 'Test centre Markham', '2020-10-1 17:49:11'),
    ('registry sign out', 123456789, 'Test centre Markham', '2020-10-1 18:31:59'),
    ('registry sign in', 421321777, 'Test centre Scarborough', '2020-10-1 18:31:59'),
    ('registry sign out', 421321777, 'Test centre Scarborough', '2020-10-1 19:55:04'),
    ('registry sign in', 551234123, 'Test centre Scarborough', '2020-10-1 21:00:23'),
    ('registry sign out', 551234123, 'Test centre Scarborough', '2020-10-1 21:29:23'),
    ('registry sign in', 987362617, 'Test centre North York', '2020-10-1 21:00:23'),
    ('registry sign out', 987362617, 'Test centre North York', '2020-10-1 21:29:23');
    
    
   


