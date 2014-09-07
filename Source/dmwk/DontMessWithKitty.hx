/*
 * This file is part of Don't Mess with Kitty.
 *
 * Don't Mess with Kitty is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Don't Mess with Kitty is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with Don't Mess with Kitty.  If not, see <http://www.gnu.org/licenses/>.
 */
package dmwk;

import openfl.Assets;
import ash.core.Engine;
import ash.core.Entity;
import nape.geom.Vec2;
import nape.space.Space;
import nape.phys.BodyType;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import dmwk.ecs.systems.SPhysics;
import dmwk.ecs.systems.SRender;
import dmwk.ecs.systems.SystemPriorities;
import dmwk.ecs.components.CBody;
import dmwk.ecs.components.CDisplay;
import dmwk.ecs.components.CPosition;


class DontMessWithKitty
{
    private var _engine : Engine = new Engine();
    private var _lastTick : Float = -1.0;
    private var _space : Space;
    private var _container : DisplayObjectContainer;

    public var displayObject(get, never) : DisplayObject;

    private inline function get_displayObject() : DisplayObject
    {
        return _container;
    }

    public function new()
    {
        _space = new Space(Vec2.weak(0, 600));
        _container = new Sprite();
    }

    public function prepare()
    {
        _engine.addSystem(new SPhysics(_space), SystemPriorities.physics);
        _engine.addSystem(new SRender(_container), SystemPriorities.render);

        // Quick demo showing physics
        var img = new Bitmap(Assets.getBitmapData("assets/img/mechwarrior.png"));
        var e = new Entity();
        var b = new CBody();
        b.body.mass = 1;
        b.body.inertia = 1;
        e.add(b);
        e.add(new CPosition());
        e.add(new CDisplay(img));
        _engine.addEntity(e);
    }

    public function tick()
    {
        var elapsed : Float;
        var now : Float = Sys.time();

        if (0 > _lastTick)
        {
            elapsed = 1/60;
        }
        else
        {
            elapsed = now - _lastTick;
        }

        _lastTick = now;

        _engine.update(elapsed);
    }
}
