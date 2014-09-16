package projectComponents.bible.act
{
	import flash.utils.setTimeout;
	
	import spark.components.Group;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	import JsC.mvc.ActionUI;
	
	import projectClass.ctrl.ProjectInit;
	
	import projectComponents.bible.ctrl.BibleInit;
	import projectComponents.bible.viewers.panel.BibleReader;
	
	public class ActStart extends ActionUI
	{
		private var gr:Group
		private var initProject:ProjectInit
		private var initBible:BibleInit
		
		public function ActStart(_vi:Object)
		{
			gr = Group(_vi)
			CountTime.start()
			setTimeout(function():void{
			
				initProject = new ProjectInit
				initBible = new BibleInit
				initBible.addEventListener(JEvent.INIT,function(event:JEvent):void{
					
				})
				initBible.addEventListener(JEvent.COMPLETE,function(event:JEvent):void{
					var _main:ActMain_Bible = new ActMain_Bible(new BibleReader)
					gr.addElement(_main._getView())
				})
				initBible.init()
			},2000)
			
			
		}
	}
}