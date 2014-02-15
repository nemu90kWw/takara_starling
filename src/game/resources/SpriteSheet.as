package game.resources
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SpriteSheet
	{
		[Embed(source = "font.png")]
		private static var FontBitmap:Class;
		
		[Embed(source = "font.fnt", mimeType = "application/octet-stream")]
		private static var FontFormat:Class;
		
		[Embed(source = "sprites.png")]
		private static var SpriteBitmap:Class;
		
		[Embed(source = "sprites.xml", mimeType = "application/octet-stream")]
		private static var SpriteFormat:Class;
		
		private static var atlas:TextureAtlas;
		private static var textureList:Object;
		private static var pivotList:Object;
		
		private static function registerTextureAtlas():void
		{
			if (atlas == null)
			{
				var spriteBitmap:Bitmap = Bitmap(new SpriteBitmap());
				var spriteFormat:XML = XML(new SpriteFormat());
				
				atlas = new TextureAtlas(Texture.fromBitmap(spriteBitmap), spriteFormat);
				
				textureList = new Object();
				pivotList = {};
				for each(var subTexture:XML in spriteFormat.children())
				{
					var name:String = subTexture.@name;
					var label:String = name.slice(0, -4);
					var frame:String = name.slice(-4);
					
					// Textureの事前キャッシュ
					if(textureList[label] == null) {
						textureList[label] = new Vector.<Texture>();
					}
					
					textureList[label].push(new Image(atlas.getTexture(name)).texture);
					
					// TextureAtlasはXMLから中心点を読み込まないため、別個に保存
					if(frame != "0000") {
						continue;	// 中心点がない先頭フレーム以外は除外
					}
					
					// フレーム番号を外して保存
					pivotList[label] = new Point(subTexture.@pivotX, subTexture.@pivotY);
				}
			}
		}
		
		public static function getTextureAtlas():TextureAtlas
		{
			if (atlas == null) {
				registerTextureAtlas();
			}
			
			return atlas;
		}
		
		public static function registerBitmapFont():void
		{
			var spriteBitmap:Texture = Texture.fromBitmap(new FontBitmap());
			var spriteFormat:XML = XML(new FontFormat());
			var font:BitmapFont = new BitmapFont(spriteBitmap, spriteFormat);
			
			TextField.registerBitmapFont(font, "Caslon");
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
		
		public static function getTextureList(name:String):Vector.<Texture>
		{
			if (atlas == null) {
				registerTextureAtlas();
			}
			
			return textureList[name];
		}
	}
}