package org.celstec.ead.mobile
{
	import flash.display.DisplayObjectContainer;
	
	import org.celstec.ead.commands.*;
	import org.celstec.ead.events.*;
	import org.celstec.ead.mobile.views.*;
	import org.celstec.ead.mobile.views.components.*;
	import org.celstec.ead.mobile.views.mediators.*;
	import org.celstec.ead.models.*;
	import org.celstec.ead.services.*;
	import org.celstec.ead.services.parser.*;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	
	public class EAD_MobileContext extends Context
	{
		public function EAD_MobileContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			//map views
			mediatorMap.mapView(EAD_Mobile, ApplicationMediator);
			mediatorMap.mapView(SelectedRoomView, SelectedRoomViewMediator);
			mediatorMap.mapView(SelectedGroupView, SelectedGroupViewMediator);
			mediatorMap.mapView(SelectionListComponent, SelectionListComponentMediator);
			mediatorMap.mapView(RoomsOverView, RoomsOverViewMediator);
			mediatorMap.mapView(GroupsOverView, GroupsOverViewMediator);
			
			//map models
			injector.mapSingleton(PlugwiseModel);
			
			//map services
			injector.mapSingletonOf(IPlugwiseService, PlugwiseService);
			injector.mapSingletonOf(IPlugwiseServiceParser, PlugwiseServiceParser);
			
			//map commands
			commandMap.mapEvent(ViewEvent.INIT_ROOMS, ReadServiceCommand, ViewEvent);
			commandMap.mapEvent(ViewEvent.INIT_GROUPS, ReadServiceCommand, ViewEvent);
			commandMap.mapEvent(ViewEvent.ROOMS_REFRESH, ReadServiceCommand, ViewEvent);
			commandMap.mapEvent(ViewEvent.GROUPS_REFRESH, ReadServiceCommand, ViewEvent);
			commandMap.mapEvent(ViewEvent.INIT_APPLIANCES, ReadServiceCommand, ViewEvent);
			
			commandMap.mapEvent(PlugwiseServiceEvent.ROOMS_RESULT, UpdateModelCommand, PlugwiseServiceEvent);
			commandMap.mapEvent(PlugwiseServiceEvent.GROUPS_RESULT, UpdateModelCommand, PlugwiseServiceEvent);
			commandMap.mapEvent(PlugwiseServiceEvent.APPLIANCES_RESULT, UpdateModelCommand, PlugwiseServiceEvent);
			
			commandMap.mapEvent(PlugwiseServiceEvent.ROOM_APPLIANCES_RESULT, RefineModelCommand, PlugwiseServiceEvent);
			commandMap.mapEvent(PlugwiseServiceEvent.GROUP_APPLIANCES_RESULT, RefineModelCommand, PlugwiseServiceEvent);
			
			commandMap.mapEvent(SelectionListEvent.CHANGE, ReadEntityCommand, SelectionListEvent);
		}
	}
}