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
package dmwk.ecs.components;

class CPosition
{
    public var worldX : Float;
    public var worldY : Float;
    public var rotation : Float;

    public function new()
    {
        worldX = 0;
        worldY = 0;
        rotation = 0;
    }
}
