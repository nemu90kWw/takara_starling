package game.resources
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;

	public class BGMPlayer
	{
		private static const BUFFER_SIZE:int = 8192;
		private static const SAMPLING_RATE:int = 44100;
		
		[Embed(source = "AVC@.mp3")]
		private static var BGM:Class;
		
		private var stream:Sound;
		private var bgmBytes:ByteArray;
		private var looper:Array;
		private var pos:int = 0;
		private var volume:Number;
		
		public function BGMPlayer()
		{
			var bgmData:Sound = new BGM();
			bgmBytes = new ByteArray();
			bgmData.extract(bgmBytes, Infinity);
			
			stream = new Sound();
			
			play("BGM_MAIN",
				16.5, -8,
				14.5, 4,
				28.5, -20
			);
		}
		
		public function play(name:String, ... args):void
		{
			if(stream.hasEventListener(SampleDataEvent.SAMPLE_DATA) == true)
			{
				stop();
			}
			
			looper = args;
			pos = 0;
			volume = 1;
			
			bgmBytes.position = 0;
			
			stream = new Sound();
			stream.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			stream.play();
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactive);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActive);
		}
		
		private function onDeactive(e:Event):void
		{
			if(stream.hasEventListener(SampleDataEvent.SAMPLE_DATA) == false)
			{
				stop();
			}
			
			stream.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			SoundMixer.stopAll();
			volume = 0;
		}
		
		private function onActive(e:Event):void
		{
			stream.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			stream.play();
		}
		
		public function stop():void
		{
			stream.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			stream = null;
		}
		
		public function dispose():void
		{
			SoundMixer.stopAll();
			stop();
			
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, onDeactive);
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, onActive);
		}
		
		private function onSampleData(e:SampleDataEvent):void
		{
			for(var i:int = 0; i < BUFFER_SIZE; i++)
			{
				e.data.writeFloat(bgmBytes.readFloat() * volume);
				e.data.writeFloat(bgmBytes.readFloat() * volume);
				
				// ループ処理
				if(bgmBytes.position >= looper[pos] * SAMPLING_RATE * 8)
				{
					bgmBytes.position += looper[pos + 1] * SAMPLING_RATE * 8;
					pos += 2;
					
					if(pos >= looper.length)
					{
						pos = 0;
					}
				}
				
				// 復帰時のフェードイン
				if(volume < 1)
				{
					volume += 0.00005;
				}
			}
		}
	}
}