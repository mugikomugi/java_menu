package model;

import java.io.Serializable;

public class Model implements Serializable {
	// シリアルバージョンID（推奨）
	private static final long serialVersionUID = 1L;
	//フィールド
	private int id;
	private String title;
	private String setOption;
	private String category;
	private String subCat;
	private float price;
	private String imgUrl;
	private String pickUp;
	
	//コンストラクタ
	public Model() {}
	// 新規登録用（IDがまだ決まっていない時用）
	public Model(
			String title,
			String setOption,
			String category,
			String subCat,
			float price,
			String imgUrl,
			String pickUp ) {
		this.title = title;
		this.setOption = setOption;
		this.category = category;
		this.subCat = subCat; 
		this.price = price;
		this.imgUrl = imgUrl;
		this.pickUp = pickUp;
	}
	// 表示・更新用（すでにDBにIDが存在する時用）
	public Model(int id,
			String title,
			String setOption,
			String category,
			String subCat,
			float price,
			String imgUrl,
			String pickUp ) {
		this(title, setOption, category, subCat, price, imgUrl, pickUp);
		this.id = id;	
	}
	
	// Getter 生成
	public int getId() { return id; }
	public String getTitle() { return title; }
	public String getSetOption() {return setOption; }
	public String getCategory() { return category; }
	public String getSubCat() { return subCat; }
	public float getPrice() { return price; }
	public String getImgUrl() { return imgUrl; }
	public String getPickUp() { return pickUp; }
}
