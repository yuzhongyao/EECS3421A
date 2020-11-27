/*
Show each realm and race (of avatar) with the gender whose avatars of that race earned the most scrip (sql) collectively from loot rewarded in quests in that realm, along with the what that race and gender collectively earned in quests in the realm (total).

In case of ties for most in a region, list all that tied.

schema: realm, race, gender, total
order by realm, race, gender
*/

with sum_of_treasures as (
    select l.realm, a.race, a.gender, sum(t.sql) as total 
    from avatar a, visit v, loot l , treasure t
    where a.login = v.login 
    and v.name = a.name 
    and l.realm = v.realm 
    and l.day = v.day 
    and a.login = l.login 
    and t.treasure = l.treasure 
    group by l.realm, a.race, a.gender
    ), 


temp as (
    select s.realm, s.race, s.gender, max(total) total 
    from sum_of_treasures s
    group by s.race, s.gender, s.realm 
    ), 


t as (
    select realm ,race ,max(total) as total 
    from temp 
    group by race, realm 
    )



select t.realm, t.race, temp.gender, t.total 
from temp, t
where temp.realm = t.realm 
and temp.race = t.race
and temp.total = t.total
order by realm, race, gender;

