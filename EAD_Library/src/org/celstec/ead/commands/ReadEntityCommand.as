package org.celstec.ead.commands
{
	import org.celstec.ead.events.SelectionListEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.models.vo.Group;
	import org.celstec.ead.models.vo.Room;
	import org.celstec.ead.services.IPlugwiseService;
	import org.robotlegs.mvcs.Command;
	
	public class ReadEntityCommand extends Command
	{
		[Inject]
		public var event:SelectionListEvent;
		
		[Inject]
		public var service:IPlugwiseService;
		
		[Inject]
		public var model:PlugwiseModel;
		
		override public function execute():void
		{
			if(event.selectedItem is Room)
			{
				model.selectedRoom = event.selectedItem as Room;
				service.readRoom(event.selectedItem.id);
			}
			else if(event.selectedItem is Group)
			{
				model.selectedGroup = event.selectedItem as Group;
				service.readGroup(event.selectedItem.id);
			}
		}
	}
}