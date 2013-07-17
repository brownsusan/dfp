package com.sbrown.view.ui
{
	public class AccordionPanel extends AccordionPanelBase
	{
		public function AccordionPanel()
		{
			super();
			close();
		}
		
		public function close():void
		{
			this.panel.height = 0;
			trace(this.height);
		}
		
		public function open():void
		{
			this.panel.height = 400;
		}
		
	}
}