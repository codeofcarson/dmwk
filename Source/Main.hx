package;

import openfl.display.Sprite;
import flash.events.Event;
import dmwk.DontMessWithKitty;

class Main extends Sprite
{
    private var _game : DontMessWithKitty = new DontMessWithKitty();

    public function new ()
    {
        super();

        _game.prepare();
        this.addChild(_game.displayObject);
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(event : Event) : Void
    {
        _game.tick();
    }
}
