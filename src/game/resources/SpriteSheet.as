package game.resources
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteSheet
	{
		[Embed(source = "../../sprites.png")]
		private static var SpriteBitmap:Class;
		
		[Embed(source = "../../sprites.xml", mimeType = "application/octet-stream")]
		private static var SpriteFormat:Class;
		
		private static var spriteBitmap:Bitmap;
		private static var spriteFormat:XML;
		
		private static var atlas:TextureAtlas;
		private static var pivotList:Object;
		
		public static function getTextureAtlas():TextureAtlas
		{
			if (atlas == null)
			{
				spriteBitmap = Bitmap(new SpriteBitmap());
				spriteFormat = XML(new SpriteFormat());
				
				atlas = new TextureAtlas(Texture.fromBitmap(spriteBitmap), spriteFormat);
				
				// TextureAtlasはXMLから中心点を読み込まないため、別個に保存
				pivotList = {};
				for each(var subTexture:XML in spriteFormat.children())
				{
					var name:String = subTexture.@name;
					
					// 中心点がない先頭フレーム以外は除外
					if(name.slice(-4) != "0000") {continue;}
					
					// フレーム番号を外して保存
					pivotList[name.slice(0, -4)] = new Point(subTexture.@pivotX, subTexture.@pivotY);
				}
			}
			
			return atlas;
		}
		
		public static function getImage(name:String, frame:int=0):Image
		{
			// フレーム番号を4桁でゼロパディングして読み込む
			var image:Image = new Image(getTextureAtlas().getTexture(name+("000" + frame).slice(-4)));
			
			// 中心点を設定
			image.pivotX = pivotList[name].x;
			image.pivotY = pivotList[name].y;
			
			return image;
		}
	}
}