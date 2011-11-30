package org.celstec.ead.commands
{
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.events.PlugwiseServiceEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.robotlegs.mvcs.Command;
	
	public class RefineModelCommand extends Command
	{
		[Inject]
		public var event:PlugwiseServiceEvent;
		
		[Inject]
		public var model:PlugwiseModel;
		
		override public function execute():void
		{
			if(event.resultAC.length > 0)
			{
				if(event.type == "roomAppliancesResult")
				{
					model.rooms[model.rooms.getItemIndex(model.selectedRoom)].appliances = event.resultAC;
					dispatch(new ViewEvent(ViewEvent.ROOM_SELECTED));
				}
				else if(event.type == "groupAppliancesResult")
				{
					model.groups[model.groups.getItemIndex(model.selectedGroup)].appliances = event.resultAC;
					dispatch(new ViewEvent(ViewEvent.GROUP_SELECTED));
				}
			}
		}
	}
}