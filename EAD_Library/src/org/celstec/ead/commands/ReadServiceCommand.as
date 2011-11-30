package org.celstec.ead.commands
{
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.services.IPlugwiseService;
	import org.robotlegs.mvcs.Command;
	
	public class ReadServiceCommand extends Command
	{
		[Inject]
		public var event:ViewEvent;
		
		[Inject]
		public var service:IPlugwiseService;
		
		override public function execute():void
		{
			switch(event.type)
			{
				case "initRooms":{
					service.readType("rooms");
					break;
				}
				case "initGroups":{
					service.readType("groups");
					break;
				}
				case "roomsRefresh":{
					service.readType("rooms");
					break;
				}
				case "groupsRefresh":{
					service.readType("groups");
					break;
				}
				case "initAppliances":{
					service.readType("appliances");
					break;
				}
			}
		}
	}
}