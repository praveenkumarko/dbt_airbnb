select distinct
    {{ dbt_utils.generate_surrogate_key(["league_code"]) }} AS league_key,
    league_code,
    case
        league_code when 'E0' then 'English Premier League' else null
    end as league_name,
    case league_code when 'E0' then 'England' else null end as country
from {{ ref("stage_premier_league") }}
