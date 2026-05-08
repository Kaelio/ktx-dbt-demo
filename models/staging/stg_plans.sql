select
    cast(plan_id as text) as plan_id,
    cast(plan_code as text) as plan_code,
    cast(plan_name as text) as plan_name,
    cast(canonical_plan_code as text) as canonical_plan_code,
    cast(is_retired as boolean) as is_retired,
    cast(retired_at as timestamptz) as retired_at
from {{ source('orbit_raw', 'plans') }}
