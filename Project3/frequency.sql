/*
7. frequency
Report the average number of days (as frequency) between visits to each given realm for each player. Also show the number of visits (visits) to that realm for the player. (Ignore a player in a realm if the player has never visited it or has only visited it once; the frequency is not defined in such cases.)

notes

Cast frequency with precision five and scale two.
schema: login, realm, visits, frequency
order by login, realm
*/

with players_more_than_one as (
    select login, realm, count(*) as visits
    from visit
    group by login, realm
    having count(*) > 1
    order by login, realm
),
 


freq as(
    select visit.login, visit.realm, p.visits, (round(cast((max(visit.day) - min(visit.day)) as numeric(8,2)),2) / round(cast((count(visit.day) - 1) as numeric(8,2)),2)) as f
    from visit, players_more_than_one p
    where visit.login = p.login
    and visit.realm = p.realm 
    group by visit.login, visit.realm, p.visits 
    order by login, realm
)


select distinct p.login, p.realm, p.visits, round(freq.f, 2) as frequency
from visit , players_more_than_one p,freq
where visit.login = p.login
and visit.realm = p.realm 
and freq.login = p.login 
and freq.realm = p.realm;