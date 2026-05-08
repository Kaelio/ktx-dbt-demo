select
    cast(plan_segment_mapping_id as text) as plan_segment_mapping_id,
    cast(canonical_plan_code as text) as canonical_plan_code,
    cast(size_band as text) as size_band,
    cast(segment as text) as segment,
    cast(effective_start_date as date) as effective_start_date,
    cast(effective_end_date as date) as effective_end_date
from {{ source('orbit_raw', 'plan_segment_mapping') }}
