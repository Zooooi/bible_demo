package projectComponents.bible.act
{
	import spark.components.Group;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	import JsC.mvc.ActionUI;
	import JsC.mvc.VO;
	
	import projectClass.ctrl.ProjectInit;
	
	import projectComponents.bible.ctrl.BibleInit;
	import projectComponents.bible.ctrl.DataNet;
	import projectComponents.bible.viewers.panel.BibleReader;
	import projectComponents.bible.viewers.symbol.BibleUpdate;
	import projectComponents.bible.vo.VersionUpdateVO;
	
	
	
	public class ActStart extends ActionUI
	{
		private var gr:Group
		private var initProject:ProjectInit
		private var initBible:BibleInit
		private var urlData:DataNet
		
		public function ActStart(_vi:Object)
		{
			gr = Group(_vi)
			CountTime.start()
				
			initProject = new ProjectInit
			initBible = new BibleInit
			initBible.addEventListener(JEvent.COMPLETE,function(event:JEvent):void{
				var _mainCtrl:ActMain_Bible = new ActMain_Bible(new BibleReader)
				gr.addElement(_mainCtrl._getView())
				checkupdate()
			})
			initBible.init()
		}
		
		private function checkupdate():void
		{
			urlData = new DataNet
			urlData.getVersion(
				function(event:JEvent):void{
					event.currentTarget.removeEventListener(event.type,arguments.callee);
					var _b:Boolean = event._xml.action.@version == "true"?true:false;
					if (!_b)
					{
						var _vo:VersionUpdateVO = new VersionUpdateVO
						_vo.fromXML(event._xml,"action")
						showUpdatePanel(_vo)
					}
				})
		}
		
		private function showUpdatePanel(_vo:VersionUpdateVO):void
		{
				var _update:BibleUpdate = new BibleUpdate
				_update.data = _vo
				_update.addEventListener(JEvent.REMOVE,function(event:JEvent):void{
					gr.removeElement(_update)
				})
				gr.addElement(_update)
			
		}
	}
}