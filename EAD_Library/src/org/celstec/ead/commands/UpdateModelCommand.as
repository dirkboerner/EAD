package org.celstec.ead.commands
{
	import org.celstec.ead.events.PlugwiseServiceEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.models.vo.Appliance;
	import org.celstec.ead.models.vo.Group;
	import org.celstec.ead.models.vo.Room;
	import org.robotlegs.mvcs.Command;
	
	public class UpdateModelCommand extends Command
	{
		[Inject]
		public var event:PlugwiseServiceEvent;
		
		[Inject]
		public var model:PlugwiseModel;
		
		override public function execute():void
		{
			if(event.resultAC.length > 0)
			{
				if(event.resultAC.getItemAt(0) is Room)
					model.rooms = event.resultAC;
				else if (event.resultAC.getItemAt(0) is Group)
					model.groups = event.resultAC;
				else if (event.resultAC.getItemAt(0) is Appliance)
					model.appliances = event.resultAC;
			}
		}
	}
}