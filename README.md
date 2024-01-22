# README

- データベース
  - sqllite


- サーバー起動

`rails db:migrate`

`rails s`

- ローカルで定時rakeタスクの実行

`rake update_customers:update`

- crontabの設定

`59 23 31 12 * /bin/bash -l -c 'cd /path/to/your/rails/app && rake update_customers:update RAILS_ENV=production'`

- 必須要件1に注文関連のパラメーターをもらった時、apiのテスト

`curl -X POST -H "Content-Type: application/json" -d '{"customerId": "124", "customerName": "bbb", "orderId": "T124", "totalInCents": 3150, "date": "2023-03-04T05:29:59.850Z"}' http://localhost:3000/orders`

- コンソール側からDBにテスト情報の挿入

コンソール開く

`rails c`

顧客情報の挿入
```
customer = Customer.new
customer.customer_id = "100"
customer.name = "user1"
customer.current_rank = 2
customer.rank_start_date = Date.parse("2023-01-01")
customer.amount_this_term = 180
customer.save
```

注文情報の挿入
```
order = Order.new
customer = Customer.find("100")
order.order_id = "T100"
order.total = 100
order.ordered_at = 100.day.ago 
order.external_customer_id = customer.customer_id
order.save
```

顧客情報のurl:

http://127.0.0.1:3000/customers/100/rank_info

確認画像：
https://github.com/aXiuyuLiang/CodingTest/blob/master/customer_info.png

注文情報のurl:

http://127.0.0.1:3000/orders/customer_orders/100

確認画像：
https://github.com/aXiuyuLiang/CodingTest/blob/master/orders_list.png)



