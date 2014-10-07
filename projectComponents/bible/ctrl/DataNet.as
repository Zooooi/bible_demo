package projectComponents.bible.ctrl
{
	import JsA.sys.App;
	
	import JsC.events.JEvent;
	import JsC.net.UrlData;
	import JsC.sys.SystemOS;
	import JsC.vo.NetUserInfo;
	
	import projectClass.vo.v.Config;
	
	public class DataNet extends UrlData
	{
		
		public var webUrl:String	
			
		public function DataNet(_vo:NetUserInfo=null)
		{
			super(_vo);
			initValue()
		}
		
		private function initValue():void
		{
			webSite = "http://zooooi.com/wheatapps/"
		}
		
		public function getVersion(_func:Function):void
		{
			Config.version = App.getVersion()
			var _obj:Object = new Object
			_obj.platform = SystemOS.os
			_obj.language = Config.language
			_obj.version = Config.version
			onLoad("getVersion.php",_obj);
			addEventListener(JEvent.COMPLETE,_func)
			/**
			 * event.key
			 * event.xml
			 * */
		}
		
		public function getUpdateUrl():String
		{
			return webSite + "update.php?version=" + Config.version ;
		}
	}
}