package game.resources
{
	import flash.display.Bitmap;
	
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
		
		public static function getTextureAtlas():TextureAtlas
		{
			if (atlas == null)
			{
				spriteBitmap = Bitmap(new SpriteBitmap());
				spriteFormat = XML(new SpriteFormat());
				
				atlas = new TextureAtlas(Texture.fromBitmap(spriteBitmap), spriteFormat);
			}
			
			return atlas;
		}
		
		public static function getImage(name:String):Image
		{
			return new Image(getTextureAtlas().getTexture(name));
		}
	}
}