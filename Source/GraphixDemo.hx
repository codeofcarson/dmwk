package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Tilesheet;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.utils.Timer;
import openfl.events.TimerEvent;

class GraphixDemo extends Sprite
{

	private var currentFrame: Int = 0;
	public var timer: Timer;
	private var sprites: Tilesheet;

	public function new ()
	{

		super ();
		sprites = new Tilesheet(Assets.getBitmapData("assets/img/knuckles_sprite_sheet.png"));
		var tileData = new Array<Float>();

		/*for (i in 0...3)
		{
			sprites.addTileRect(new Rectangle(i*45, 12, 45, 27));
		}*/
		sprites.addTileRect(new Rectangle(144, 164, 34, 32));
		sprites.addTileRect(new Rectangle(180, 164, 34, 32));
		sprites.addTileRect(new Rectangle(215, 164, 34, 32));
		sprites.addTileRect(new Rectangle(411, 110, 34, 32));

		sprites.drawTiles(graphics, [0,0,0,4], false, Tilesheet.TILE_SCALE);

		timer = new Timer(100);
		timer.addEventListener(TimerEvent.TIMER, onTimerTick);
		timer.start();
	}

	public function onTimerTick(e:TimerEvent):Void
	{
		graphics.clear();
		if (++currentFrame == 3)
		{
			currentFrame = 0;
		}
		sprites.drawTiles(graphics, [0,0,currentFrame,4], false, Tilesheet.TILE_SCALE);

	}

}
