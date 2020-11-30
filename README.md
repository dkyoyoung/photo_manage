# README

## 環境

Ubuntu 18.04.5 LTS

## install

### 以下を実行

```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash
echo "source /etc/profile.d/rvm.sh" >> ~/.bash_profile
rvm install 2.6
sudo apt-get install libmariadb-dev
sudo apt install mysql-client-core-5.7
sudo apt install mysql-server mysql-client
````

### /etc/mysql/mysql.conf.d/mysqld.cnf に以下を追加

```
[mysqld]
.
.
skip-grant-tables
```
### 以下を実行

```
sudo service mysql restart

bundle install --path vendor/bundle
bundle update

bundle exec rails db:create db:migrate RAILS_ENV=development
bundle exec rake db:seed
```

### ログインユーザー
```
user_id: test
password: testtest
```

### client_id とclient_secretに関して
時間上の都合で別管理はやってない、以下のところに書き込む

```
app/controllers/photo_manage_controller.rb#L16
app/controllers/photo_manage_controller.rb#L30
app/controllers/photo_manage_controller.rb#L31
```

### 時間上の都合でTODO
* i18n整理
* spec
* client_id とclient_secretの別管理
* 画面整理いろいろ

### かかった時間
* 8時間ほど
