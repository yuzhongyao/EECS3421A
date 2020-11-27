/*
Select the themes (theme) for which the quests were always successful, and report the number of successful quests (quests) for each such.

schema: theme, quests
order by theme


*/
with num_of_quests as
    (select theme, count(*) as quests
    from quest
    where quest.succeeded is not null
    group by theme
    order by theme
    )

select distinct q.theme,  q.quests
from num_of_quests q, quest a, quest b
where q.theme =a.theme
and q.theme = b.theme
and b.theme = a.theme
and q.theme not in( 
                    select distinct a.theme 
                    from quest a
                    where a.succeeded is null
                    )
order by theme;