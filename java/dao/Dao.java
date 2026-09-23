package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Model;

public class Dao {
	
	// 環境変数 DB_HOST が設定されていればそれを使い、なければ "localhost" を使う
	private static final String DB_HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
		
	// DB_HOST を組み込んだ接続URL
	private final String JDBC_URL = "jdbc:mysql://" + DB_HOST + ":3306/my_menu_db?useSSL=false&allowPublicKeyRetrieval=true";
	private final String DB_USER = "user name"; //任意のユーザーネーム
	private final String DB_PASS = "user password"; //任意のパスワード
	
	//空の配列を作っておく
	public List<Model> findAll() {
		List<Model> dbList = new ArrayList<>();
	
	try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            // カラム名を指定せず「*」で取得し、番号で取り出す（名前間違いを防ぐ）
            String sql = "SELECT * FROM menu_table"; 
            PreparedStatement pStmt = conn.prepareStatement(sql);
            ResultSet rs = pStmt.executeQuery();

            while (rs.next()) {
            	// DBのカラム名を変数に代入
                int id = rs.getInt("id"); 
                String title = rs.getString("title");
                String setOption = rs.getString("option_set");
                String category = rs.getString("category");
                String subCat = rs.getString("subcat");
                float price = rs.getFloat("price");
                String imgUrl = rs.getString("img_url");
                String pickUp = rs.getString("pickup");

                //ArrayListに要素をaddしている
                dbList.add(new Model(id, title, setOption, category, subCat, price, imgUrl, pickUp));
                // Model.javaのコンストラクタを使い、インスタンス化している
            	}
        	}
    	} catch (Exception e) {
    		e.printStackTrace();
    		return null;
    	}
    	return dbList;
	}
	
	//DBにデータを追加
	public boolean insert(
			String title,
			String setOption,
			String category,
			String subCat,
			float price,
			String imgUrl,
			String pickUp ) {
		String sql = "INSERT INTO menu_table (title, option_set, category, subcat, price, img_url, pickup) VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pStmt = conn.prepareStatement(sql)){
					pStmt.setString(1, title);
					pStmt.setString(2, setOption);
					pStmt.setString(3, category);
					pStmt.setString(4, subCat);
					pStmt.setFloat(5, price);
					pStmt.setString(6, imgUrl);
					pStmt.setString(7, pickUp);
				
					int result = pStmt.executeUpdate();
					return result > 0;
				}
			} catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	
	//特定のIDのデータを1件取得する
	public Model findById(int id) {
		Model oneItem = null;
		String sql = "SELECT * FROM menu_table WHERE id = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pStmt = conn.prepareStatement(sql)){
					pStmt.setInt(1, id);
					ResultSet rs = pStmt.executeQuery();
					if(rs.next()) {
						oneItem = new Model(rs.getInt("id"),
								rs.getString("title"),
								rs.getString("option_set"),
								rs.getString("category"),
								rs.getString("subcat"),
								rs.getFloat("price"),
								rs.getString("img_url"),
								rs.getString("pickup"));
						}
					}
				} catch (Exception e) { e.printStackTrace(); }
			return oneItem;
		}
	// DBの情報を更新する
	public boolean update(int id,
			String title,
			String setOption,
			String category,
			String subCat,
			float price,
			String imgUrl,
			String pickUp) {
		String sql = "UPDATE menu_table SET title = ?, option_set = ?, category = ?, subcat = ?, price = ?, img_url = ?, pickup = ? WHERE id = ?";
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pStmt = conn.prepareStatement(sql)){
				pStmt.setString(1, title);
				pStmt.setString(2, setOption);
				pStmt.setString(3, category);
				pStmt.setString(4, subCat);
				pStmt.setFloat(5, price);
				pStmt.setString(6, imgUrl);
				pStmt.setString(7, pickUp);
				pStmt.setInt(8, id); //WHERE句のidの指定を追加
				
				return pStmt.executeUpdate() > 0;
			}
		} catch (Exception e) { e.printStackTrace(); return false; }		
	}
	//レコード削除
	public void delete(int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String sql = "DELETE FROM menu_table WHERE id = ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			pStmt.setInt(1, id);
			pStmt.executeUpdate();
			System.out.println("DB削除完了: ID=" + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
