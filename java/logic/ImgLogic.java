package logic;

import java.util.Random;

public class ImgLogic {
	//画像名をランダムな文字列に変換を共通化
		public String generateRandomFileName(String originalFileName) {
	        // 拡張子の取得（例: .jpg）
	        String extension = "";
	        int i = originalFileName.lastIndexOf('.');
	        if (i > 0) {
	            extension = originalFileName.substring(i);
	        }

	        // 16文字のランダムな英小文字を生成
	        String alphabet = "abcdefghijklmnopqrstuvwxyz";
	        StringBuilder sb = new StringBuilder();
	        Random random = new Random();
	        for (int j = 0; j < 16; j++) {
	            int index = random.nextInt(alphabet.length());
	            sb.append(alphabet.charAt(index));
	        }

	        // 3. ランダム名 + 拡張子を返す
	        return sb.toString() + extension;
	    }
}
