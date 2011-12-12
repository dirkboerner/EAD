package org.celstec.ead.models.vo
{
	import mx.collections.ArrayCollection;

	public class Appliance
	{
		private var _id:String;
		private var _name:String;
		private var _powerUsage:Number;
		private var _totalUsage:Number;
		private var _totalUsageToday:Number;
		private var _logweek:ArrayCollection;
		private var _logday:ArrayCollection;
		
		public function Appliance()
		{
			this._id = new String();
			this._name = new String();
			this._powerUsage = new Number();
			this._totalUsage = new Number();
			this._totalUsageToday = new Number();
			this._logweek = new ArrayCollection();
			this._logday = new ArrayCollection();
		}
		
		public function get logday():ArrayCollection
		{
			return _logday;
		}

		public function set logday(value:ArrayCollection):void
		{
			_logday = value;
		}

		public function get logweek():ArrayCollection
		{
			return _logweek;
		}

		public function set logweek(value:ArrayCollection):void
		{
			_logweek = value;
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

		public function get powerUsage():Number
		{
			return _powerUsage;
		}

		public function set powerUsage(value:Number):void
		{
			_powerUsage = value;
		}

		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
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