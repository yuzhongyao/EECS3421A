/*
Report for each player by login and name who managed to 
participate in more than one quest on the same day,
 along with those quests by day, realm, and theme.

schema: login, name, day, realm, theme
order by login, name, day, realm, theme


*/

with d as (
    select b.login, p.name, b.day, b.realm
    from player p, actor b
    where p.login = b.login
    group by b.login, p.name, b.day, b.realm
    having count(*) > 1
)

select a.login, q.name, a.day, a.realm, a.theme
from player q, actor a, d
where d.day = a.day
and
      d.login = a.login
      and
      d.realm = a.realm
      and
      d.name = q.name
      

order by login, name, day, realm, theme;


