SELECT id AS payment_id
    , orderid AS order_id
    , paymentmethod
    , status AS payment_status
    , {{ mc_cents_to_dolars('amount', 100.0) }} AS payment_amount
    , created AS payment_created_at
    , _batched_at AS payment_batched_at
FROM {{ source('stripe', 'payment') }}
