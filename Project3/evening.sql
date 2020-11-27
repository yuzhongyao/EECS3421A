/*List the quests by theme, day, and realm that were not completed before 8pm (on the day of the quest) with their succeeded time (which is null if it did not succeed).

schema: theme, day, realm, succeeded
order by theme, day, realm

*/

select theme, day, realm, succeeded
from quest 
where succeeded is null 
or succeeded >= '20:00:00'
order by theme, day, realm;