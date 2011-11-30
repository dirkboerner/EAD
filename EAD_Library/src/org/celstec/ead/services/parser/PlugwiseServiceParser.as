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
			
			for each(var result:Object in resultObject.room)
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
			
			for each(var result:Object in resultObject.appliance)
			{
				if(result.id != 0)
				{
					var appliance:Appliance =  new Appliance();
					
					appliance.id = result.id;
					for each(var string:String in result.name.split("_"))
					{
						appliance.name += string + " ";
					}
					appliance.powerUsage = new Number(result.powerusage);
					appliance.totalUsage = new Number(result.totalusage);
					appliance.totalUsageToday = new Number(result.totalusagetoday);
					
					appliances.addItem(appliance);
				}
			}
			
			return appliances;
		}
	}
}