package  
{
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	

	
	/**
	 * ...
	 * @author Jaywalker
	 * 
	 * score = is de score variabel
	 * bij de functie "connect" kun je connecten aan de database
	 * 
	 */
	public class Main extends MovieClip
	{
		var Skin:int = 1;
		var floors:Array = [];
		var bgs:Array = [];
		var bulletz:Array = [];
		var players:Array = [];
		var enemys:Array = [];
		
		var addpoints:Boolean = true;
		var platformspeed:int = 10;
		var hit:Timer = new Timer(10, 100);
		var levens:int = 0;
		var lives:MovieClip = new liblives();
		var bg:MovieClip = new libbg();
		var submit:MovieClip = new libsubmit();
		var EndScreen:MovieClip = new libbackground();
		var player:MovieClip = new libplayer();
		var enemy:MovieClip = new libenemy();
		var floor:MovieClip = new libFloor();
		var startscherm:MovieClip = new libmenu();
		var varRight:Boolean = false;
		var varLeft:Boolean = false;
		var varUp:Boolean = false;
		var varDown:Boolean = false;
		var varJump:Boolean = false;
		var gravity:int = 1;
		var xspeed:int = 18;
		var yspeed:int = 0;
		var platformMC:Array = new Array();
		var enemiesMC:Array = new Array();
		
		var enemies:Array = [];
		
		
		var bullets:Array = new Array();
		var score:Number = 0;
		var scoreUp:Timer = new Timer(2000,2);
		
		var teller:int = 0;
		var teller2:int = 0;
		var teller3:int = 0;
		var teller4:int = 0;
		var enemiehp:int = 3;
		public var scoreField:TextField

		
		//start scherm
		public function Main ()
		{
			lives.stop();
			startscherm.x = 350;
			startscherm.y = 200;
			addChild(startscherm);
			startscherm.addEventListener(MouseEvent.CLICK, init);
			hit.addEventListener(TimerEvent.TIMER_COMPLETE, gehit);
			hit.addEventListener(TimerEvent.TIMER, flikker);
		}
		//flikker effect
		private function flikker(e:TimerEvent):void 
		{
			if (players[players.length-1].alpha == 1)
			{
				players[players.length-1].alpha = 0;
			}
			else
			{
				players[players.length-1].alpha = 1;
			}
		}
		//1 leven eraf
		private function gehit(e:TimerEvent):void 
		{
			levens += 1
			players[players.length-1].alpha = 1;
			
			
		}
		
		//start EventListeners/start spel
		private function init(e:MouseEvent):void 
		{
			lives.stop(); 
			
			startscherm.removeEventListener(MouseEvent.CLICK, init);
			removeChild(startscherm);
			
			switch (Skin) 
			{
				case 1 :
					bgs.push(new libSpaceBg());
					bgs[bgs.length -1].x = 350;
					bgs[bgs.length -1].y = 200;
					addChild(bgs[bgs.length -1]);
					
					players.push(new libSplayer());
					players[players.length -1].y = 365;
					addChild(players[players.length -1])
					
					floors.push(new libSfloor());
					floors[floors.length -1].x = stage.stageWidth / 2;
					floors[floors.length -1].y = stage.stageHeight;
					addChild(floors[floors.length -1])
				break;
				
				case 2 :
					bgs.push(new libbg());
					bgs[bgs.length -1].x = 350;
					bgs[bgs.length -1].y = 200;
					addChild(bgs[bgs.length -1]);
					
					players.push(new libplayer());
					players[players.length -1].y = 365;
					addChild(players[players.length -1])
					
					floors.push(new libFloor());
					floors[floors.length -1].x = stage.stageWidth / 2;
					floors[floors.length -1].y = stage.stageHeight;
					addChild(floors[floors.length -1])
				break;
				default:
			}
			
			
			lives.x = 500;
			lives.y = 45;
			addChild(lives);
			
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyup);
			scoreUp.addEventListener(TimerEvent.TIMER_COMPLETE, addScore);
			scoreUp.start();
			
			scoreField = new TextField();
			scoreField.text = "score : 0";	
			scoreField.x = stage.stageWidth - scoreField.width;
			addChild(scoreField);
		}
		
		// Game over scherm
		private function init2()
		{
			scoreUp.stop();
			addpoints = false
			removeEventListener(Event.ENTER_FRAME, loop);
			submit.addEventListener(MouseEvent.CLICK, SubmitScore);
			EndScreen.x = 350;
			EndScreen.y = 200;
			submit.x = 350;
			submit.y = 200;
			addChild(EndScreen);
			addChild(submit);
			
		}
		
		//score submit/connect database
		public function connect(score:Number)
		{
			var request:URLRequest = new URLRequest ("" + score);  
			var loader:URLLoader = new URLLoader(request);
		}
		//uitvoeren van de functie connect
		private function SubmitScore(e:MouseEvent):void 
		{
			trace("submit score!");
			connect(score);
			
		}
		//om de 2000 millisecondes komt er 10 punten bij
		private function addScore(e:TimerEvent):void 
		{
			if (addpoints = true)
			{
				scoreUp.start();
				score += 10;
			}
		}
		
		//keyboard toetsen (key up)
		private function keyup(me:KeyboardEvent)
		{
			switch (me.keyCode)
			{
				case 39 :
				case 68 :
					varRight = false;
					break;
				case 37 :
				case 65 :
					varLeft = false;
					break;		
				case 38 :
				case 87 :
					varJump = false;
					break;
			}
		}
		
		//keyboard toetsen (key down)
		private function keydown(me:KeyboardEvent)
		{
			switch (me.keyCode)
			{
				case 39 :
				case 68 :
					varRight = true;
					break;
				case 37 :
				case 65 :
					varLeft = true;
					break;
				case 38 :
				case 87 :
					varJump = true;
					break;
				case 17 :
					shoot();
					break;
			}
		}
		
		//loop functie
		private function loop(e:Event):void 
		{
			teller ++;
			teller4 ++;
			
			
			// als de teller bij de 9 is, word er een platform aangemaakt
			if(teller == 15)
			{
				platform();
			}
			
			// als de teller bij de 20 is, word er een enemy aangemaakt
			if(teller4 == 10)
			{
				createEnemy();
			}
			
			if (varRight)
			{
				players[players.length-1].x += xspeed;
			}
			if (varLeft)
			{
				players[players.length-1].x -= xspeed;
			}
			if (varJump)
			{
				jump();
				
			}
		
			//dit zorgt ervoor dat de player niet uit het scherm valt
			while(players[players.length-1].x + players[players.length-1].width/2 > stage.stageWidth)
			{
				players[players.length-1].x --;
			}
			while(players[players.length-1].x - players[players.length-1].width/2 < 0)
			{
				players[players.length-1].x ++;
			}
			
			
			//als de player de vloer niet aanraakt dan vlieg je omhoog en als de y positie groter dan 25 is dan gaat ie weer omlaag
			
			players[players.length - 1].y += yspeed;
			
			if(!(players[players.length-1].hitTestObject(floors[floors.length -1])))
			{
				if (yspeed < 25)
				{
					yspeed += gravity;
					
				}
			}
			//anders blijft ie staan
			else
			{
				while (players[players.length-1].y + (players[players.length-1].height / 2) > stage.stageHeight - floors[floors.length -1].height + 1)
				{
					players[players.length - 1].y--;
					
				}
				yspeed = 0;
				
			}
			//de functies voor het aanroepen van de enemys en platforms 		
			platformflying();
			enemyflying();
			
			/*
			hier word door de array van de platforms gelooped
			en voor elk platform word er gekeken of de x, y positie van de player de hittestpoint 
			van het platform raakt*/ 
			
			for (var i:int = 0; i < platformMC.length; i++) 
			{
				while (platformMC[i].hitTestPoint(players[players.length-1].x, players[players.length-1].y + players[players.length-1].height / 2, true))
				{
					players[players.length - 1].y --;
					yspeed = 1;
					players[players.length - 1].x += platformspeed;
				
				}
				
				if (floors[floors.length -1].hitTestObject(platformMC[i])) 
				{
					platformMC[i].y = 250;
				}
				
			}
			
			/*hier word door de array van de bullets gelooped 
			en voor elke bullet voor er speed aan toegevoegd
			in deze loop word er door de array van de enemies gelooped
			en daar in word gekeken of de bullet de enemie raakt en als dat zo is dan score + 20
			*/
			for (i = 0; i < bullets.length; i++) 
			{
				bullets[i].x -= bullets[i].speed;
				
				for (var j:int = 0; j < enemiesMC.length ; j++) 
				{
						if (bullets[i].hitTestObject(enemiesMC[j])) {
						score += 20;
						enemiesMC[j].y += 600;
						bullets[i].y += 600;
						
					}
						
				}
			}
			//hittest enemy 
			for (var k:int = 0; k < enemiesMC.length; k++) 
			{
				if (players[players.length-1].hitTestPoint(enemiesMC[k].x,enemiesMC[k].y)) {
					score -= 10;
					hit.reset();
					hit.start();
					enemiesMC[k].y = 1000;
					
				}
				if (floors[floors.length -1].hitTestObject(enemiesMC[k])) 
				{
					enemiesMC[k].y = 900;
				}
			}
			
				scoreField.text = "score : " + score;
			
			if (levens == 3)
			{
				init2();
			}
			if (levens == 1) 
			{
				lives.gotoAndStop(2);
			}
			if (levens == 2) 
			{
				lives.gotoAndStop(3);
			}
			if (levens == 3) 
			{
				lives.gotoAndStop(4);
			}

			
		}
		
		private function jump()
		{
			if (players[players.length-1].hitTestObject(floors[floors.length -1]))
			{
				yspeed = -15;
			}
			
			
			for (var i:int = 0; i < platformMC.length; i++) 
			{
				if (players[players.length-1].hitTestObject(platformMC[i]))
				{
					yspeed = -10;
				}
			}
			
			

		}
		
		private function platform()
		{
			teller = 0;
			switch(Skin)
			{
				case 1 :
					platformMC.push(new libspaceblok());
					platformMC[platformMC.length -1].y = Math.random() * stage.stageWidth;
					addChild(platformMC[platformMC.length -1]);
					platformMC[platformMC.length -1].iceyspeed = 0;
					platformMC[platformMC.length -1].icexspeed = 0;
					break;
				case 2 :
					platformMC.push(new libblok3());
					platformMC[platformMC.length -1].y = Math.random() * stage.stageWidth;
					addChild(platformMC[platformMC.length -1]);
					platformMC[platformMC.length -1].iceyspeed = 0;
					platformMC[platformMC.length -1].icexspeed = 0;
					break;
			}
			
		}
		
		private function createEnemy()
		{
			teller4 = 0;
					enemiesMC.push(new libenemy());
					enemiesMC[enemiesMC.length -1].y = Math.random() * stage.stageWidth;
					addChild(enemiesMC[enemiesMC.length -1]);
					enemiesMC[enemiesMC.length -1].iceyspeed = 0;
					enemiesMC[enemiesMC.length -1].icexspeed = 0;
					
		}
		

		
		private function shoot():void
		{
			switch (Skin) 
			{
				case 1:
					var new_star:star = new star;
					new_star.x = players[players.length-1].x;
					new_star.y = players[players.length-1].y; 
					bullets.push(new_star);
					addChild(bullets[bullets.length - 1])
				break;
				

				case 2:
					var new_bullet:Bullet = new Bullet;
					new_bullet.x = players[players.length-1].x;
					new_bullet.y = players[players.length-1].y; 
					bullets.push(new_bullet);
					addChild(bullets[bullets.length - 1])
				break;
				default:
			}
		}
		
		private function platformflying()
		{
			for (var i:int = platformMC.length - 1; i >= 0; i--)
			{
				platformMC[i].x += platformspeed;
			}
		}
		
		private function enemyflying()
		{
			for (var k:int = enemiesMC.length - 1; k >= 0; k--)
			{
				enemiesMC[k].x += 10
			}
		}
	}
}