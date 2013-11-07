package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Jaywalker
	 */
	public class star extends MovieClip
	{
		
		var speed:Number;
		
		public function star() 
		{
			speed = 20;
			draw();
		}
		
		private function draw():void {
			var star:MovieClip = new libSbullet();
			addChild(star);
		}
		
	}

}