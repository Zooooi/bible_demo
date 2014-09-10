package projectComponents.bible.ctrl
{
	import JsC.events.JEvent;
	import JsC.mvc.Controller;
	
	import projectClass.vo.v.Config;
	import projectClass.vo.v.Config_1_files;
	
	
	[Event(name="INIT", type="JsC.events.JEvent")]
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	public class BibleInit extends Controller
	{
		public function BibleInit()
		{
			super();
			Config.Files = new Config_1_files
		}
		
		
		public function init():void
		{
			dispatchEvent(new JEvent(JEvent.COMPLETE))
		}
	}
	
	
}