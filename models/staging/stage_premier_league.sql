with
    lnd_data as (
        select
            {{ dbt_utils.generate_surrogate_key(["date", "hometeam", "awayteam"]) }}
            as match_id,
            division as league_code,
            to_date(date, 'DD/MM/YY') as match_date,
            case
                when upper(hometeam) = upper('Tottenham')
                then upper('Tottenham Hotspur')
                when upper(hometeam) = upper('Wolves')
                then upper('Wolverhampton Wanderers')
                when upper(hometeam) = upper('Bolton')
                then upper('Bolton Wanderers')
                when upper(hometeam) = upper('Blackburn')
                then upper('Blackburn Rovers')
                when upper(hometeam) = upper('Man United')
                then upper('Manchester United')
                when upper(hometeam) = upper('Leicester')
                then upper('Leicester City')
                when upper(hometeam) = upper('Newcastle')
                then upper('Newcastle United')
                when upper(hometeam) = upper('Birmingham')
                then upper('Birmingham City')
                when upper(hometeam) = upper('West Brom')
                then upper('West Bromwich Albion')
                when upper(hometeam) = upper('Norwich')
                then upper('Norwich City')
                when upper(hometeam) = upper('Man City')
                then upper('Manchester City')
                when upper(hometeam) = upper('Charlton')
                then upper('Charlton Athletic')
                else upper(hometeam)
            end as home_team_name,
            case
                when upper(awayteam) = upper('Tottenham')
                then upper('Tottenham Hotspur')
                when upper(awayteam) = upper('Wolves')
                then upper('Wolverhampton Wanderers')
                when upper(awayteam) = upper('Bolton')
                then upper('Bolton Wanderers')
                when upper(awayteam) = upper('Blackburn')
                then upper('Blackburn Rovers')
                when upper(awayteam) = upper('Man United')
                then upper('Manchester United')
                when upper(awayteam) = upper('Leicester')
                then upper('Leicester City')
                when upper(awayteam) = upper('Newcastle')
                then upper('Newcastle United')
                when upper(awayteam) = upper('Birmingham')
                then upper('Birmingham City')
                when upper(awayteam) = upper('West Brom')
                then upper('West Bromwich Albion')
                when upper(awayteam) = upper('Norwich')
                then upper('Norwich City')
                when upper(awayteam) = upper('Man City')
                then upper('Manchester City')
                when upper(awayteam) = upper('Charlton')
                then upper('Charlton Athletic')
                else upper(awayteam)
            end as away_team_name,
            full_time_result,
            full_time_home_team_goals,
            full_time_away_team_goals,
            home_team_shots,
            away_team_shots,
            b365a as bet365_home_odds,
            b365ah as bet365_away_odds,
            b365d as bet365_draw_odds,
            null as pinnacle_home_odds,
            null as pinnacle_away_odds,
            null as pinnacle_draw_odds
        from {{ ref("lnd_premier_league_history") }}
    )
select *, current_timestamp as create_timestamp, null as update_timestamp
from lnd_data