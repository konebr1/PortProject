--Dataset includes all players in NBA and ABA history, Some Data below is only showing players who played post-NBA/ABA merger.
--Some Players are Combo players meaning they play either (guard and foward) or (foward and center),so they are included in both data
--NBA 75 has players who played in ABA
--Data involving MVP Trophies on include players who started their career post NBA/ABA merger(ABA MVP Trophies only counted in NBA_75 set)


--Sort by guards top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%G%' and "NBA_75" > 0
order by 1

--Sort by fowards top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%F%' and "NBA_75" > 0
order by 1

--Sort by center top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%C%' and "NBA_75" > 0
order by 1

--Count of players by position top 75 
select "Pos", count("Player")
from playerbio
where "NBA_75" > 0
group by "Pos" 
order by 1

--Average (PPG,Rebounds, and Assist by Position) and total MVPS in "NBA_75" NBA  
select playerbio."Pos" , avg(playerbio."PTS") as "avg_pts", avg(playerbio."TRB") as "avg_trb", avg(playerbio."AST") as "avg_ats",
sum(playerinfo."MVP") as "MVP_Count" 
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where playerbio."NBA_75" > 0 
group by playerbio."Pos"
order by 5 desc

--Players who recieved a MVP Award in "NBA_75" 
select playerbio."Player", playerinfo."MVP" 
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))
where playerbio."NBA_75" > 0 and playerinfo."MVP" > 0
order by 1

--Players who didn't recieve a MVP Award Stats(PPG,TRB,AST) in "NBA_75" 
select playerbio."Player", playerbio."PTS", playerbio."TRB", playerbio."AST", playerinfo."MVP" 
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))
where playerbio."NBA_75" > 0 and playerinfo."MVP" = 0
order by 1

--Players in NBA 75 by Name,Win share, and position.
select "Player", "Pos","PTS", "WS" 
from playerbio
where "NBA_75" > 0
order by 4 desc

--Players Primary Accolades(Champions,MVP, All Star ) table join NBA_75
select  playerbio."Player",playerbio."Pos",playerbio."PTS",playerbio."WS", playerinfo."Championships",
playerinfo."MVP", playerinfo."All Star"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where "NBA_75" > 0
order by 1

--Championships vs years played
select playerbio."Player",playerbio."Pos", playerbio."Years", playerinfo."Championships",
round(playerinfo."Championships"/playerbio."Years"::numeric, 3)*100 as "Championship Rate%"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where "NBA_75" > 0
order by 5 desc 

--All Star Rate
select playerbio."Player",playerbio."Pos", playerbio."Years", playerinfo."All Star",
round(playerinfo."All Star"/playerbio."Years"::numeric, 3)*100 as "All-Star Rate%"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From")) 
where "NBA_75" > 0
order by 5 desc

--Average WS% in NBA 75
select round(avg("WS")::numeric)  
from playerbio
where "NBA_75" > 0

--------------------------------------------------------------------------------------------------------------------

--Sort by guards non top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%G%' and "NBA_75" < 1
order by 1

--Sort by fowards non top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%F%' and "NBA_75" < 1
order by 1

--Sort by center non top 75
select "Player", "Pos" 
from playerbio
where "Pos" like '%C%' and "NBA_75" < 1
order by 1

--Count of players by position non top 75 
select "Pos", count("Player")
from playerbio
where "NBA_75" < 1
group by "Pos" 
order by 1

--Players who recieved a MVP Award but no NBA_75 Selection Post ABA
select playerbio."Player" , playerinfo."MVP"  
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where playerbio."NBA_75" < 1 and playerinfo."MVP" > 0 and playerinfo."From" > 1976

--Average (PPG,Rebounds, and Assist by Position) and total MVPS Non "NBA_75" NBA not including ABA 
select playerbio."Pos" , avg(playerbio."PTS") as "avg_pts", avg(playerbio."TRB") as "avg_trb", avg(playerbio."AST") as "avg_ats",
sum(playerinfo."MVP") as "MVP_Count" 
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where playerbio."NBA_75" < 1 and playerinfo."From"  > 1976
group by playerbio."Pos"
order by 5 desc


--Players Primary Accolades(Champions,MVP, All Star ) table join (Non-Nba 75) Post ABA
select  playerbio."Player",playerbio."Pos",playerbio."PTS",playerbio."WS",playerinfo."Championships",
playerinfo."MVP", playerinfo."All Star"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))  
where "NBA_75" < 1 and playerinfo."From"  > 1976
order by 1

--Championships vs years played(Non Nba_75) Post ABA top 75
select playerbio."Player",playerbio."Pos", playerbio."Years", playerinfo."Championships",
round(playerinfo."Championships"/playerbio."Years"::numeric, 3)*100 as "Championship Rate%"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))
where "NBA_75" < 1 and "To" > 1976 
order by 5 desc 
limit 75

--All Star Rate(Non Nba) Post ABA top 75 
select playerbio."Player",playerbio."Pos", playerbio."Years", playerinfo."All Star",
round(playerinfo."All Star"/playerbio."Years"::numeric, 3)*100 as "All-Star Rate%"
from playerbio
inner join playerinfo on
((playerbio."Player"=playerinfo."Player") and (playerbio."From"=playerinfo."From"))
where "NBA_75" < 1  and "To" > 1976
order by 5 desc 
limit 75

--Players by Name,Win share, and position.(Non-Nba 75) Post ABA
select "Player", "Pos", "PTS", "WS" 
from playerbio
where "NBA_75" < 1 and "To" > 1976
order by 4 desc

--Average WS% (Non-NBA 75) Post ABA
select round(avg("WS")::numeric)  
from playerbio
where "NBA_75" < 1  and "To" > 1976 
