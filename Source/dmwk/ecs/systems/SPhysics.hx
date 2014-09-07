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
import nape.space.Space;
import dmwk.ecs.components.CBody;
import dmwk.ecs.nodes.NPhysical;

class SPhysics extends System
{
    private var _nodes : NodeList<NPhysical>;
    private var _space : Space;

    public function new(space : Space)
    {
        super();
        _space = space;
    }

    override public function addToEngine(engine : Engine) : Void
    {
        _nodes = engine.getNodeList(NPhysical);
        for (node in _nodes)
        {
            addToSpace(node);
        }
        _nodes.nodeAdded.add(addToSpace);
        _nodes.nodeRemoved.add(removeFromSpace);
    }

    private function addToSpace(node : NPhysical) : Void
    {
        node.body.space = _space;
    }

    private function removeFromSpace(node : NPhysical) : Void
    {
        node.body.space = null;
    }

    override public function update(time : Float) : Void
    {
        _space.step(time);
        for (node in _nodes)
        {
            node.position.worldX = node.body.position.x;
            node.position.worldY = node.body.position.y;
            node.position.rotation = node.body.position.angle;
        }
    }

    override public function removeFromEngine(engine : Engine) : Void
    {
        _nodes = null;
    }
}

