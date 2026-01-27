with
    away_team as (
        select distinct away_team_name as team_name, league_code
        from {{ ref("stage_premier_league") }}
    ),
    home_team as (
        select distinct home_team_name as team_name, league_code
        from {{ ref("stage_premier_league") }}
    ),
    teams as (
        select team_name, league_code
        from away_team
        union
        select team_name, league_code
        from home_team
    )
select
    {{ dbt_utils.generate_surrogate_key(["team_name", "league_code"]) }} as team_key,
    team_name,
    league_code
from teams
