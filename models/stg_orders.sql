select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from `utility-replica-441110-u8`.dbt_tutorial_jaffle_shop.orders