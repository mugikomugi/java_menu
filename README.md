# java_menu
javaで開発したメニューシステム

## ローカル開発ディレクトリ構成図
WEBプロジェクト / src / main / <br>
のmain以下の構成になります。<br>
docker-compose.ymlはローカル開発用でプロジェクト直下に配置。<br>
本環境は別途作成しました。
<pre>
main
├── java
│   ├── dao
│   │   └── Dao.java
│   ├── filter
│   │   └── LoginFilter.java
│   ├── logic
│   │   └── ImgLogic.java
│   ├── model
│   │   ├── Model.java
│   │   └── UserModel.java
│   └── servlet
│       ├── AddDB.java
│       ├── AddList.java
│       ├── Confirm.java
│       ├── Delete.java
│       ├── EditMenu.java
│       ├── ImgUP.java
│       ├── ListServlet.java
│       ├── Login.java
│       ├── LogOut.java
│       ├── MenuView.java
│       └── NotFound.java
└── webapp
    ├── css           ※フロントエンド側の作成ファイル
    ├── image         ※フロントエンド側表示用画像
    ├── js　          ※フロントエンド側の作成ファイル
    ├── META-INF      ※デフォルトで置いてあったもの
    ├── upload        ※DBに追加された画像を格納
    ├── WEB-INF
        ├── jsp
        │   ├── dashboard
        │   │   ├── addlist.jsp
        │   │   ├── confirm.jsp
        │   │   ├── delete.jsp
        │   │   ├── edit.jsp
        │   │   ├── footer.jsp
        │   │   ├── headmeta.jsp
        │   │   └── menulist.jsp
        │   ├── 404.jsp
        │   ├── index.jsp
        │   └── login.jsp
        ├── lib
        │   ├── jstl-api-1.2.jar          ※コアタグライブラリ、DLして格納
        │   ├── jstl-impl-1.2.jar         ※コアタグライブラリ、DLして格納
        │   └── mysql-connector-j-9.6.0.jar ※DB接続に必要、DLして格納
        └── tags
            ├── menuItem.tag
            └── menuview.tag
</pre>

## 開発環境
Java17<br>
Tomcat9<br>
Eclipse2023<br>
Docker4.89<br>
MySQL8<br>
XAMPP8 ※phpmyadminでMySQLとテーブルのカラム作成<br>
Visual Studio Code ※フロントエンドコーディング<br>
Figma ※デザイン作成<br>
Photo shop ※画像トリミング<br>

## サイトURL
https://okamechan.duckdns.org/
