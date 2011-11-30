package org.celstec.ead.mobile.views.components.renderer
{
	import spark.components.IconItemRenderer;
	
	public class SelectionListItemRenderer extends IconItemRenderer
	{
		public function SelectionListItemRenderer()
		{
			super();
		}
		
		public function myMessageFunction(data:Object):Object
		{
			return "Total Usage Today: " + data.totalUsageToday + " kWh";
		}
		
		[Embed(source='assets/green.png')]
		private const GREEN:Class;
		
		[Embed(source='assets/yellow.png')]
		private const YELLOW:Class;
		
		[Embed(source='assets/red.png')]
		private const RED:Class;
		
		public function myIconFunction(data:Object):Object
		{
			var source:Object = new Object();
			
			if(data.powerUsage <= 0){
				source = GREEN;
			}
			else if(data.powerUsage <= 10){
				source = YELLOW;
			}
			else if(data.powerUsage > 10){
				source = RED;
			}
			return source;
		}
	}
}