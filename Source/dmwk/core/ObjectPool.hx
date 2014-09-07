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
package dmwk.core;

interface IPooled
{
    function activate() : Void;
    function deactivate() : Void;
}

interface IObjectFactory<T>
{
    function create() : T;
}

class ObjectPool<T>
{
    // TODO: Do we need to make this thread-safe?

    private var _live : Int;
    private var _available : Array<T> = new Array<T>();
    private var _factory : IObjectFactory<T>;

    public function new(factory : IObjectFactory<T>)
    {
        _factory = factory;
        _live = 0;
    }

    public function destroy(obj : T) : Void
    {
        if (0 == _live)
        {
            // TODO: Convert this to a real exception
            throw "destroyed too many objects!";
        }

        _live -= 1;
        if (Std.is(obj, IPooled))
        {
            cast(obj, IPooled).deactivate();
        }
        _available.push(obj);

        cleanup();
    }

    public function cleanup() : Void
    {
        if ((3 * _available.length) <= _live)
        {
            return;
        }

        var max : Int = Std.int(_live / 3);
        _available = _available.slice(0, max);
    }

    public function create() : T
    {
        var value : Null<T> = _available.pop();
        var newObject : T;
        if (null == value)
        {
            newObject = _factory.create();
        }
        else
        {
            newObject = value;
        }

        if (Std.is(newObject, IPooled))
        {
            cast(newObject, IPooled).activate();
        }
        _live += 1;
        return newObject;
    }
}
