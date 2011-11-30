package org.celstec.ead.mobile.views.mediators
{
	import flash.events.MouseEvent;
	
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.mobile.views.SelectedGroupView;
	import org.celstec.ead.mobile.views.components.SelectionDetailComponent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.models.vo.Appliance;
	import org.robotlegs.mvcs.Mediator;
	
	public class SelectedGroupViewMediator extends Mediator
	{
		[Inject]
		public var view:SelectedGroupView;
		
		[Inject]
		public var model:PlugwiseModel;
		 
		override public function onRegister():void
		{		
			//view component events
			eventMap.mapListener(view.backButton, MouseEvent.CLICK, handleClick);
			
			view.title = model.selectedGroup.title;
			view.groupPowerusage.text = new String(model.selectedGroup.powerUsage) + " W";
			view.groupTotalusagetoday.text = new String(model.selectedGroup.totalUsageToday) + " kWh";
			
			for each(var appliance:Appliance in model.selectedGroup.appliances)
			{
				var applianceDetail:SelectionDetailComponent = new SelectionDetailComponent();
				
				var name:Array = appliance.name.split(" ");
				if(name.length > 3)
				{
					applianceDetail.applianceName.text = name[0] + "_" + name[1] + " (" + name[2] + ")";
				}
				else
					applianceDetail.applianceName.text = name[0] + "_" + name[1];
				
				applianceDetail.appliancePowerusage.text = appliance.powerUsage + " W";
				applianceDetail.applianceTotalusagetoday.text = appliance.totalUsageToday + " kWh";
				
				view.applianceGroup.addElement(applianceDetail);
			}
		}
		
		private function handleClick(event:MouseEvent):void
		{
			dispatch(new ViewEvent(ViewEvent.GROUP_BACK));
		}
	}
}