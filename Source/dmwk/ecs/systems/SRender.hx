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
package dmwk.ecs.systems;

import ash.core.Engine;
import ash.core.System;
import ash.core.NodeList;
import flash.display.DisplayObjectContainer;
import dmwk.ecs.nodes.NRenderable;

class SRender extends System
{
    private var _nodes : NodeList<NRenderable>;
    private var _container : DisplayObjectContainer;

    public function new(container : DisplayObjectContainer)
    {
        super();
        _container = container;
    }

    override public function addToEngine(engine : Engine) : Void
    {
        _nodes = engine.getNodeList(NRenderable);
        for (node in _nodes)
        {
            addToDisplay(node);
        }
        _nodes.nodeAdded.add(addToDisplay);
        _nodes.nodeRemoved.add(removeFromDisplay);
    }

    private function addToDisplay(node : NRenderable) : Void
    {
        _container.addChild(node.displayObject);
    }

    private function removeFromDisplay(node : NRenderable) : Void
    {
        _container.removeChild(node.displayObject);
    }

    override public function update(time : Float) : Void
    {
        for (node in _nodes)
        {
            var displayObject = node.displayObject;
            var position = node.position;

            displayObject.x = position.worldX;
            displayObject.y = position.worldY;
            displayObject.rotation = position.rotation;
        }
    }

    override public function removeFromEngine(engine : Engine) : Void
    {
        _nodes = null;
    }
}
