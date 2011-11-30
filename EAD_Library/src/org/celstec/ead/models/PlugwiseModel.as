package org.celstec.ead.models
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import org.celstec.ead.events.PlugwiseModelEvent;
	import org.celstec.ead.models.vo.Group;
	import org.celstec.ead.models.vo.Room;
	import org.robotlegs.mvcs.Actor;
	
	import spark.collections.SortField;
	
	public class PlugwiseModel extends Actor
	{
		private var _rooms:ArrayCollection;
		private var _groups:ArrayCollection;
		private var _appliances:ArrayCollection;
		
		private var _selectedRoom:Room;
		private var _selectedGroup:Group;
		
		public function PlugwiseModel()
		{
			this._rooms = new ArrayCollection();
			this._groups = new ArrayCollection();
			this._appliances = new ArrayCollection();
		}

		public function get selectedGroup():Group
		{
			return _selectedGroup;
		}

		public function set selectedGroup(value:Group):void
		{
			_selectedGroup = value;
		}

		public function get selectedRoom():Room
		{
			return _selectedRoom;
		}

		public function set selectedRoom(value:Room):void
		{
			_selectedRoom = value;
		}

		public function get appliances():ArrayCollection
		{
			return _appliances;
		}

		public function set appliances(value:ArrayCollection):void
		{
			_appliances = value;
			dispatch(new PlugwiseModelEvent(PlugwiseModelEvent.APPLIANCES_SET));
		}

		public function get groups():ArrayCollection
		{
			var sort:Sort = new Sort();
			sort.fields = [new SortField("totalUsageToday",true)];
			_groups.sort = sort;
			_groups.refresh();
			
			return _groups;
		}

		public function set groups(value:ArrayCollection):void
		{
			_groups = value;
			dispatch(new PlugwiseModelEvent(PlugwiseModelEvent.GROUPS_SET));
		}

		public function get rooms():ArrayCollection
		{
			var sort:Sort = new Sort();
			sort.fields = [new SortField("totalUsageToday",true)];
			_rooms.sort = sort;
			_rooms.refresh();
			
			return _rooms;
		}

		public function set rooms(value:ArrayCollection):void
		{
			_rooms = value;
			dispatch(new PlugwiseModelEvent(PlugwiseModelEvent.ROOMS_SET));
		}
	}
}