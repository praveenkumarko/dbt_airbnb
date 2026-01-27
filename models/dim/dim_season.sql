with
    league_season as (
        select distinct
            case
                when month(match_date) >= 8
                then concat(year(match_date), '-', year(match_date) + 1)
                else concat(year(match_date) - 1, '-', year(match_date))
            end as season,
            case 
                when month(match_date) >= 8 then year(match_date)
                else year(match_date)-1
            end as season_year
        from {{ ref("stage_premier_league") }}
    )
select distinct {{ dbt_utils.generate_surrogate_key(["season"]) }} as season_key,season_year,season
from league_season