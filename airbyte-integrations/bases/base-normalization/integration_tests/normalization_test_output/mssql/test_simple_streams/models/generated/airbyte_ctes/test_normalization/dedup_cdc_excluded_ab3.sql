{{ config(schema="_airbyte_test_normalization", tags=["top-level-intermediate"]) }}
-- SQL model to build a hash column based on the values of this record
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        adapter.quote('column`_\'with""_quotes'),
        '_ab_cdc_lsn',
        '_ab_cdc_updated_at',
        '_ab_cdc_deleted_at',
    ]) }} as _airbyte_dedup_cdc_excluded_hashid,
    tmp.*
from {{ ref('dedup_cdc_excluded_ab2') }} tmp
-- dedup_cdc_excluded

