package org.celstec.ead.models.vo
{
	import mx.collections.ArrayCollection;

	public class Group
	{
		private var _id:String;
		private var _title:String;
		private var _powerUsage:Number;
		private var _totalUsage:Number;
		private var _totalUsageToday:Number;
		private var _appliances:ArrayCollection;
		
		public function Group()
		{
			this._id = new String();
			this._title = new String();
			this._powerUsage = new Number();
			this._totalUsage = new Number();
			this._totalUsageToday = new Number();
			this._appliances = new ArrayCollection();
		}

		public function get totalUsageToday():Number
		{
			return _totalUsageToday;
		}

		public function set totalUsageToday(value:Number):void
		{
			_totalUsageToday = value;
		}

		public function get totalUsage():Number
		{
			return _totalUsage;
		}

		public function set totalUsage(value:Number):void
		{
			_totalUsage = value;
		}

		public function get appliances():ArrayCollection
		{
			return _appliances;
		}

		public function set appliances(value:ArrayCollection):void
		{
			_appliances = value;
		}

		public function get powerUsage():Number
		{
			return _powerUsage;
		}

		public function set powerUsage(value:Number):void
		{
			_powerUsage = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}
	}
}