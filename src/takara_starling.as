package
{
	import flash.display.Sprite;
	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Rectangle;
	
	import game.core.MasterViewport;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="#000000"]
	public class takara_starling extends Sprite
	{
		private const STAGE_WIDTH:int = 1080;
		private const STAGE_MIN_HEIGHT:int = 1440;
		private const STAGE_MAX_HEIGHT:int = 1920;
		
		private var star:Starling;
		
		public function takara_starling()
		{
			// ブレンドに減算半透明を追加
			BlendMode.register("subtract", Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
			
			if(stage.fullScreenWidth / stage.fullScreenHeight > 3 / 4)
			{
				// 4:3より横に長い場合、黒帯付きの4:3表示でビューポート作成
				star = new Starling(MasterViewport, stage, RectangleUtil.fit(
					new Rectangle(0, 0, STAGE_WIDTH, STAGE_MIN_HEIGHT),
					new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
					ScaleMode.SHOW_ALL
				));
				star.stage.stageWidth = STAGE_MIN_HEIGHT;
				star.stage.stageHeight = STAGE_MIN_HEIGHT;
				
				MasterViewport.scale = 1;
				MasterViewport.maxHeight = STAGE_MIN_HEIGHT;
			}
			else if(stage.fullScreenWidth / stage.fullScreenHeight < 9 / 16)
			{
				// 16:9より縦に長い場合、黒帯付きの16:9表示でビューポート作成
				star = new Starling(MasterViewport, stage, RectangleUtil.fit(
					new Rectangle(0, 0, STAGE_WIDTH, STAGE_MAX_HEIGHT),
					new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
					ScaleMode.SHOW_ALL
				));
				star.stage.stageWidth = STAGE_WIDTH;
				star.stage.stageHeight = STAGE_MAX_HEIGHT;
				
				MasterViewport.scale = 1;
				MasterViewport.maxHeight = STAGE_MAX_HEIGHT;
			}
			else	
			{
				// 画面比率が4:3から16:9に収まる場合はビューポートを普通に生成
				MasterViewport.scale = (stage.fullScreenWidth / STAGE_WIDTH);
				MasterViewport.maxHeight = stage.fullScreenHeight / MasterViewport.scale;
				
				star = new Starling(MasterViewport, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			}
			
			star.showStats = true;
			star.showStatsAt("left", "top", 2);
			
			star.start();
		}
	}
}
