package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	/**
	 * ...
	 * @author Jaywalker
	 */
	public class Bullet extends Sprite
	{
		public var speed:Number;
		
	
		
		public function Bullet() 
		{
			
			speed = 20;
			draw();
			

		}
		
		private function draw():void {
			var kogel:MovieClip = new liblaser();
			addChild(kogel);
		}
		
	}

}