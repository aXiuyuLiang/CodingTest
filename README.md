# README
- ローカルで定時rakeタスクの実行

`rake update_customers:update`

- crontabの設定

`59 23 31 12 * /bin/bash -l -c 'cd /path/to/your/rails/app && rake update_customers:update RAILS_ENV=production'`