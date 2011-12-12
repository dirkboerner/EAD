package org.celstec.ead.services.parser
{
	import mx.collections.ArrayCollection;
	
	import org.celstec.ead.models.vo.Appliance;
	import org.celstec.ead.models.vo.Group;
	import org.celstec.ead.models.vo.Room;

	public class PlugwiseServiceParser implements IPlugwiseServiceParser
	{
		public function parseRooms(resultObject:Object):ArrayCollection
		{
			var rooms:ArrayCollection = new ArrayCollection();
			
			for each(var result:Object in resultObject.room)
			{
				var room:Room =  new Room();
				room.id = result.id;
				room.title = result.title;
				room.powerUsage = new Number(result.powerusage);
				room.totalUsage = new Number(result.totalusage);
				room.totalUsageToday = new Number(result.totalusagetoday);

				rooms.addItem(room);
			}
			
			return rooms;
		}
		
		public function parseGroups(resultObject:Object):ArrayCollection
		{
			var groups:ArrayCollection = new ArrayCollection();
			
			for each(var result:Object in resultObject.group)
			{
				var group:Group =  new Group();
				group.id = result.id;
				group.title = result.title;
				group.powerUsage = new Number(result.powerusage);
				group.totalUsage = new Number(result.totalusage);
				group.totalUsageToday = new Number(result.totalusagetoday);
				
				groups.addItem(group);
			}
			
			return groups;
		}
		
		public function parseAppliances(resultObject:Object):ArrayCollection
		{
			var appliances:ArrayCollection = new ArrayCollection();
			var timeArray:Array = new Array("00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00");
			
			for each(var result:Object in resultObject.appliance)
			{
				if(result.id != 0)
				{
					var appliance:Appliance =  new Appliance();
					appliance.id = result.id;
					
					var myPattern:RegExp = /_/g;
					appliance.name = new String(result.name).replace(myPattern," ");
					
					appliance.powerUsage = new Number(result.powerusage);
					appliance.totalUsage = new Number(result.totalusage);
					
					var decimal:Number = Math.pow(10, 2);
					appliance.totalUsageToday = Math.round(decimal * new Number(result.totalusagetoday)) / decimal;
					
					for(var j:int=0; j<8; j++)
					{
						myPattern = /'/g;
						var tempString:String = new String(result.logs.log[j]).replace(myPattern,"");
						myPattern = / /g;
						tempString = tempString.replace(myPattern,"");
						var logArray:Array = tempString.substring(1,tempString.length-1).split(",");
						
						for(var i:int=0; i<24; i++)
						{
							var item:Object = new Object();
							if(i == 12)
								item.date = new String(result.logs.log[j].@date).split(" ")[0];
							
							item.data = logArray[i];
							
							if(j < 7)
								appliance.logweek.addItem(item);
							else {
								item.time = timeArray[i];
								appliance.logday.addItem(item);
							}
						}	
					}
					appliances.addItem(appliance);
				}
			}
			return appliances;
		}
	}
}